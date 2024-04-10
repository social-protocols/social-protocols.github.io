using RxInfer, Distributions, Random

rng = MersenneTwister(42)
n = 10
p = 0.75
distribution = Bernoulli(p)

dataset = float.(rand(rng, Bernoulli(p), n))

# GraphPPL.jl export `@model` macro for model specification
# It accepts a regular Julia function and builds an FFG under the hood
@model function coin_model(n)

    # `datavar` creates data 'inputs' in our model
    # We will pass data later on to these inputs
    # In this example we create a sequence of inputs that accepts Float64
    y = datavar(Float64, n)

    # We endow θ parameter of our model with some prior
    θ ~ Beta(2.0, 7.0)
    # or, in this particular case, the `Uniform(0.0, 1.0)` prior also works:
    # θ ~ Uniform(0.0, 1.0)

    # We assume that outcome of each coin flip is governed by the Bernoulli distribution
    for i in 1:n
        y[i] ~ Bernoulli(θ)
    end

    # We return references to our data inputs and θ parameter
    # We will use these references later on during inference step
    return y, θ
end


@model function coin_model(n)

    # `datavar` creates data 'inputs' in our model
    # We will pass data later on to these inputs
    # In this example we create a sequence of inputs that accepts Float64
    y = datavar(Float64, n)

    # We endow θ parameter of our model with some prior
    θ ~ Beta(2.0, 7.0)
    # or, in this particular case, the `Uniform(0.0, 1.0)` prior also works:
    # θ ~ Uniform(0.0, 1.0)

    # We assume that outcome of each coin flip is governed by the Bernoulli distribution
    for i in 1:n
        y[i] ~ Bernoulli(θ)
    end

    # We return references to our data inputs and θ parameter
    # We will use these references later on during inference step
    return y, θ
end





model = coin_model(length(dataset))

result = infer(
    model = model,
    data  = (y = dataset, )
)

θestimated = result.posteriors[:θ]

println("mean: ", mean(θestimated))
println("std:  ", std(θestimated))














begin 
    @model function coin_model2(n, m)

        # `datavar` creates data 'inputs' in our model
        # We will pass data later on to these inputs
        # In this example we create a sequence of inputs that accepts Float64
        y = datavar(Float64, n)
        y2 = datavar(Float64, m)

        # We endow θ parameter of our model with some prior
        θ ~ Beta(2.0, 7.0)
        θ2 ~ Beta(1.0, 1.0)
        # or, in this particular case, the `Uniform(0.0, 1.0)` prior also works:
        # θ ~ Uniform(0.0, 1.0)

        # We assume that outcome of each coin flip is governed by the Bernoulli distribution
        for i in 1:n
            y[i] ~ Bernoulli(θ)
        end
        for i in 1:n
            y2[i] ~ Bernoulli(θ2)
        end

        return y, y2, θ, θ2
    end





    model = coin_model2(length(dataset), length(dataset))

    result = infer(
        model = model,
        data  = (y = dataset, y2=dataset)
    )

    θestimated = result.posteriors[:θ]

    println("mean: ", mean(θestimated))
    println("std:  ", std(θestimated))
end




begin 
    transition_meta = @meta begin 
        transition() -> Linearization()
        dotsoftplus() -> Linearization()
        getinverse() -> Linearization()
    end


    @model function coin_model2(n, m)

        # `datavar` creates data 'inputs' in our model
        # We will pass data later on to these inputs
        # In this example we create a sequence of inputs that accepts Float64
        y = datavar(Float64, n)
        y2 = datavar(Float64, m)

        q ~ Beta(1, 1)

        alpha ~ mean(q) where { meta = transition_meta }
        # beta = mean(q)
         # where { meta = transition_meta }

        p ~ Beta(2, 2)

        # We assume that outcome of each coin flip is governed by the Bernoulli distribution
        for i in 1:n
            y[i] ~ Bernoulli(p)
        end
        for i in 1:n
            y2[i] ~ Bernoulli(q)
        end

        return y, y2, p, q
    end





    model = coin_model2(length(dataset), length(dataset))

    result = infer(
        model = model,
        data  = (y = dataset, y2=dataset),
            # meta = transition_meta,
    )

    θestimated = result.posteriors[:p]

    println("mean: ", mean(θestimated))
    println("std:  ", std(θestimated))
end
    
