
# Define the hierarchical model
@model function hierarchical_model1(y)
    C = 2
    N = size(y)[1]


    # Prior distributions
    q ~ Beta(1, 1)

    r = .25

    globalPriorMean = 0.5

    informedPrior = globalPriorMean + r*(mean(q) - globalPriorMean)

    # m = mean(q)
    # epsilon = 1e-4
    # p ~ Beta(max(m * C, epsilon), max((1 - m) * C, epsilon))
    p ~ Beta(informedPrior * C, (1 - informedPrior) * C)

    # Likelihood
    for i in 1:N
        y[i, 1] ~ Distributions.Bernoulli(q)
        y[i, 2] ~ Distributions.Bernoulli(p)
    end
end


begin
    
    q_true = 0.8
    p_true = 0.2

    # Iterate from having seen 0 observations to 100 observations.
    Ns = 0:1000;

    # Draw data from a Bernoulli distribution, i.e. draw heads or tails.
    Random.seed!(120)
    data1 = rand(Bernoulli(q_true), last(Ns))
    data2 = rand(Bernoulli(p_true), last(Ns))
    y = [data1 data2]

    # Create the model instance
    model = hierarchical_model1(y)

    # Sample from the posterior using the NUTS sampler
    # chain = MCMCChains.sample(model, Metropolis(), 1000)
    chain = Turing.sample(model, NUTS(), 100)
    plot(chain)

    density(chain; xlim=(0, 1), legend=:best, w=2, c=:blue)

    # Visualize the true probability of heads in red.
    vline!([q_true, p_true]; label="True probability", c=:red)

end


