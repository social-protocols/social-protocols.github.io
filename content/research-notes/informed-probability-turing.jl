using Turing, MCMCChains
using Random
using Plots
using Distributions
using StatsPlots

using GlobalBrain

# This model uses the mean of q as the mean of the prior for q. It does not incorporate the reversion parameter.
@model function informed_probability_model1(uninformed_t, informed_t)
    successes1, trials1 = unpack(uninformed_t)
    successes2, trials2 = unpack(informed_t)

    q ~ Beta(1, 1)
    m = mean(q)
    epsilon = 1e-4
    p ~ Beta(max(m * C2, epsilon), max((1 - m) * C2, epsilon))

    for i in 1:successes1
        1 ~ Bernoulli(q)
    end
    for i in 1:(trials1 - successes1)
        0 ~ Bernoulli(q)
    end

    for i in 1:successes2
        1 ~ Bernoulli(p)
    end
    for i in 1:(trials2 - successes2)
        0 ~ Bernoulli(p)
    end
end

# This model adds the reversion parameter, which assumes an a priori regression to the mean. 

    @model function note_effect_model_rxinfer(trials1, trials2)
        # successes1, trials1 = unpack(uninformed_t)
        # # successes2, trials2 = unpack(informed_t)

        # uninformed_t = datavar(Tally, 1)
        # informed_t = datavar(Tally, 1)

        # successes1 = uninformed_t.count
        # trials1 = uninformed_t.sample_size 

        # successes2 = informed_t.count
        # trials2 = informed_t.sample_size 


        y1 = datavar(Float64, trials1) 
        # trials1 = datavar(Int64, 1) 

        y2 = datavar(Float64, trials2) 
        # trials2 = datavar(Int64, 1) 



        q ~ Beta(1, 1)
        m = mean(q)
        r ~ Beta(1,1)
        informedPrior = mean(q) - r*(mean(q) - mean(m)) 
        p ~ Beta(informedPrior * C, (1 - informedPrior) * C)


        for i in 1:trials
            y1[i] ~ Bernoulli(q)
        end


        for i in 1:trials2
            y2[i] ~ Bernoulli(p)
        end


    end

# Try rxinfer
using RxInfer
begin

    model = note_effect_model_rxinfer(4, 3)
    result = infer(
        model = model,
        data  = ( y1 = [1,0,1,1], y2=[0,0,1] )
    )

end




begin
    # Set the true probability of heads in a coin.
    # Set the true probability of heads in a coin.
    q_true = 0.8
    p_true = 0.2

    # Iterate from having seen 0 observations to 100 observations.
    votes1 = 10
    votes2 = 5


    # Draw data from a Bernoulli distribution, i.e. draw heads or tails.
    Random.seed!(120)
    upvotes1 = rand(Binomial(votes1, q_true))
    upvotes2 = rand(Binomial(votes2, p_true))

	uninformed_t = T(upvotes1, votes1)
	informed_t = T(upvotes2, votes2)

	model = hierarchical_model2(uninformed_t, informed_t)

    chain = MCMCChains.sample(model, NUTS(), 100)

    plot(chain)

	 
end

using Logging
using ProgressMeter

function get_sample_results(n,m) 

    # n = 2
    # m = 2
	results = Array{Tuple{Float64, Float64}, 4}(undef, n+1, n, m+1, m);


	# 0,1 1,1;  0,2 1,2 2,2;  0,3 1,3 2,3 3,4 4,4; 

	total = ( n + n*(n+1)/2 ) * ( m + m*(m+1)/2 )


	stream = IOBuffer(UInt8[])
	logger = Logging.SimpleLogger(Logging.Error)


	p = Progress(Int(total))

	i = 0
	for t1 in 1:n
		for s1 in 0:t1
			for t2 in 1:m
				for s2 in 0:t2

					uninformed_t = T(s1, t1)
					informed_t = T(s2, t2)
					model = hierarchical_model2(uninformed_t, informed_t)

				    # chain = 
					chain = Logging.with_logger(logger) do
					   MCMCChains.sample(model, NUTS(), 1000; progress=false)
					   # sample(...)
					end



					uninformed_p = mean(chain[:q])
					informed_p = mean(chain[:p])

                    if informed_p < 0
                       println("What the heck? $uninformed_p, $informed_p, $uninformed_t, $informed_t") 
                    end

					results[s1+1, t1, s2+1, t2] = (uninformed_p, informed_p)
					# ps[t1, s1, t2, s2] = informed_p
					i = i + 1
				    next!(p)
				end
			end
		end
	end
    # next!(p; showvalues = [(:t1,t2), (:t1, t2), (:i, i)])


	# took about 5 minutes to run for n=10 and m=10

	# estimate_posterior_mean(T(3,4),T(0,4))

    return results
end

n = 5
m = 5
sample_results = get_sample_results(n,m);

function estimate_posterior_mean(uninformed_t, informed_t) 
    return sample_results[uninformed_t.count+1, uninformed_t.sample_size, informed_t.count+1, informed_t.sample_size]
end

# estimate_posterior_mean(T(0,1),T(0,1))




