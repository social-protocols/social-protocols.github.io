using GlobalBrain

const Beta = BetaDistribution
const Tally = BernoulliTally
using DataFrames

uniform = BetaDistribution(.5,2)

const T = BernoulliTally

# Scenario, 1 up, 1 down, no overlap

prior = uniform


models = []


# Model 1: old model
push!(models, (prior, overall_t, uninformed_t, informed_t, scenario) -> begin
	overall = prior |>
		(x -> update(x, overall_t))

	uninformed = prior |>
		(x -> update(x, uninformed_t)) 

	informed = uninformed |>
		(x -> reset_weight(x, C2)) |>
		(x -> update(x, informed_t)) 

    overall_p = overall.mean
    uninformed_p = uninformed.mean
    informed_p = informed.mean
    model = "Old"
	return (; overall_p, uninformed_p, informed_p, model)
end)


push!(models, (prior, overall_t, uninformed_t, informed_t, scenario) -> begin
	overall = prior |>
		(x -> update(x, overall_t))

	uninformed = overall |>
		(x -> reset_weight(x, C2)) |>
		(x -> update(x, uninformed_t)) 

	informed = overall |>
		(x -> reset_weight(x, C2)) |>
		(x -> update(x, informed_t)) 

    overall_p = overall.mean
    uninformed_p = uninformed.mean
    informed_p = informed.mean
    model = "New"
	return (; overall_p, uninformed_p, informed_p, model)
end)



push!(models, (prior, overall_t, uninformed_t, informed_t, scenario) -> begin
	overall = prior |>
		(x -> update(x, overall_t))

	informed = prior |>
		(x -> update(x, uninformed_t)) |>
		(x -> reset_weight(x, C2)) |>
		(x -> update(x, informed_t)) 

	uninformed = prior |>
		(x -> update(x, informed_t)) |>
		(x -> reset_weight(x, C2)) |>
		(x -> update(x, uninformed_t)) 

    overall_p = overall.mean
    uninformed_p = uninformed.mean
    informed_p = informed.mean
    model = "New2"
	return (; overall_p, uninformed_p, informed_p, model)
end)



push!(models, (prior, overall_t, uninformed_t, informed_t, scenario) -> begin
	overall = prior |>
		(x -> update(x, overall_t))


	# uninformed_t = scenarios[1].uninformed_t
	# informed_t = scenarios[1].informed_t

	# begin 
		model = hierarchical_model2(uninformed_t, informed_t)
	    chain = MCMCChains.sample(model, NUTS(), 1000)
		uninformed_p = mean(chain[:q])
		informed_p = mean(chain[:p])
	# end

    overall_p = overall.mean

	model = "HMC"
	return (; overall_p, uninformed_p, informed_p, model, scenario)
end)


scenarios = []

push!(scenarios, 
	begin
		prior = uniform
		uninformed_t = T(0,2)
		informed_t = T(2,2)
		overall_t = informed_t
		scenario = "2 Voters, 2 Changes"
		(; prior, overall_t, uninformed_t, informed_t, scenario)
	end)



push!(scenarios, 
	begin
		prior = uniform
		uninformed_t = T(0,2)
		informed_t = T(1,2)
		overall_t = informed_t
		scenario = "2 Voters, 1 Change"
		(; prior, overall_t, uninformed_t, informed_t, scenario)
	end)

push!(scenarios, 
	begin
		prior = uniform
		informed_t = T(1,1)
		uninformed_t = T(0,1)
		overall_t = informed_t + uninformed_t
		scenario = "2 Voters, 0 Changes"
		(; prior, overall_t, uninformed_t, informed_t, scenario)
	end)

push!(scenarios, 
	begin
		prior = uniform
		uninformed_t = T(7,10)
		informed_t = T(3,10)
		overall_t = T(10, 15)
		scenario = "15 Voters, 5 Change"
		(; prior, overall_t, uninformed_t, informed_t, scenario)
	end)

push!(scenarios, 
	begin
		prior = uniform
		uninformed_t = T(17,18)
		informed_t = T(0,2)
		overall_t = informed_t + uninformed_t
		scenario = "20 Voters, 0 Changes, 2 Uninformed"
		(; prior, overall_t, uninformed_t, informed_t, scenario)
	end)

push!(scenarios, 
	begin
		prior = uniform
		informed_t = T(17,18)
		uninformed_t = T(0,2)
		overall_t = informed_t + uninformed_t
		scenario = "20 Voters, 0 Changes, 18 Uninformed"
		(; prior, overall_t, uninformed_t, informed_t, scenario)
	end)



push!(scenarios, 
	begin
		prior = uniform
		uninformed_t = T(170,180)
		informed_t = T(0,20)
		overall_t = informed_t + uninformed_t
		scenario = "200 Voters, 0 Changes, 20 Uninformed"
		(; prior, overall_t, uninformed_t, informed_t, scenario)
	end)



function t(tally::BernoulliTally)
	return [tally.count, tally.sample_size]
end

#results = DataFrame([  for m in models for s in scenarios ])
results = DataFrame([ (
			s..., 
			m(s...)...,
			overall_r=ratio(s.overall_t),
			uninformed_t=t(s.uninformed_t), 
			informed_t=t(s.informed_t), 
			prior = s.prior.mean,
			# overall_t=t(s.overall_t), 
			# uninformed_r=ratio(s.uninformed_t),
			# informed_r=ratio(s.informed_t),
		    ) for s in scenarios for m in models  ]);
@show results;


# Initialize a float array of size 3 with zeros
# n
# m
n=10
m=10

begin

	total = ( n + n*(n+1)/2 ) * ( m + m*(m+1)/2 )

	using ProgressMeter
	pm = Progress(Int(total))

	total_errors_p = zeros(Float64, 3)
	total_errors_q = zeros(Float64, 3)
	i = 0
	for t1 in 1:n
		for s1 in 0:t1
			for t2 in 1:m

				for s2 in 0:t2

					uninformed_t = T(s1,t1)
					informed_t = T(s2,t2)


					(q, p) = estimate_posterior_mean(uninformed_t,informed_t)
						# println("Best estimate; $q, $p")

					for j in 1:3
						(overall1, qApprox, pApprox) = models[j](uniform, uninformed_t,informed_t,informed_t, "")

						# println("Approximation $j; $qApprox, $pApprox")

						if q <= 0 || q >= 1 || p <= 0 || p >= 1
							println("Here $(t1), $(s1), $(t2), $(s2), $p, $(pApprox), $q, $(qApprox)")
						end
	
						e1 = relative_entropy(q, qApprox)
						e2 = relative_entropy(p, pApprox)
						# println("Errors: $e1, $e2")
						total_errors_q[j] += e1
						total_errors_p[j] += e2

					end	

					# ps[t1, s1, t2, s2] = informed_p
					i = i + 1
				    next!(pm)
				end
			end
		end
	end

	@show total_errors_q ./ total
	@show total_errors_p ./ total

	return
end


