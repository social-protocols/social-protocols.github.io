using Distributions

using Random
using Turing
using MCMCChains

# Introductor yexample from https://turing.ml/dev/tutorials/00-introduction/
begin 
	Random.seed!(12); # Set seed for reproducibility

	using StatsPlots

	p_true = 0.5;

	N = 100;

	data = rand(Bernoulli(p_true), N);

	prior_belief = Beta(1, 1);


	function updated_belief(prior_belief::Beta, data::AbstractArray{Bool})
	    # Count the number of heads and tails.
	    heads = sum(data)
	    tails = length(data) - heads

	    # Update our prior belief in closed form (this is possible because we use a conjugate prior).
	    return Beta(prior_belief.α + heads, prior_belief.β + tails)
	end


	# Unconditioned coinflip model with `N` observations.
	@model function coinflip(; N::Int)
	    # Our prior belief about the probability of heads in a coin toss.
	    p ~ Beta(1, 1)

	    # Heads or tails of a coin are drawn from `N` independent and identically
	    # distributed Bernoulli distributions with success rate `p`.
	    y ~ filldist(Bernoulli(p), N)

	    return y
	end

	# Convenience method for constructing a coinflip model
	# that is conditioned on observations `y`.
	coinflip(y::AbstractVector{<:Real}) = coinflip(; N=length(y)) | (; y);

	model = coinflip(data);

	sampler = HMC(0.05, 10);

	chain = sample(model, sampler, 1_000; progress=false);


	histogram(chain)


	# Visualize a blue density plot of the approximate posterior distribution using HMC (see Chain 1 in the legend).
	density(chain; xlim=(0, 1), legend=:best, w=2, c=:blue)

	# Visualize a green density plot of the posterior distribution in closed-form.
	plot!(
	    0:0.01:1,
	    pdf.(updated_belief(prior_belief, data), 0:0.01:1);
	    xlabel="probability of heads",
	    ylabel="",
	    title="",
	    xlim=(0, 1),
	    label="Closed-form",
	    fill=0,
	    α=0.3,
	    w=3,
	    c=:lightgreen,
	)

	# Visualize the true probability of heads in red.
	vline!([p_true]; label="True probability", c=:red)

end