
### Note Effect Scoring Models

In note-effect-scoring-models.jl, I experiment with different models for calculating the uninformed and informed probability as a function of the overall, uninformed, and informed tallies.

The original model uses the mean of uninformed probability as a prior for the informed probability. But this isn't quite a proper Bayesian hierarchical.





Where did the intuition for the hybrid model come from?

First, it was this scenario:
	20 Voters, 0 Changes, 2 Uninformed

The new scenario had a higher estimate for the uninformed p: .93 vs .9. Why? By using the overall probability as a prior, shouldn't the 
	uninformed probability decrease, since the overall probability includes the informed voters, all of whom downvoted? 

But what's happening is the overall tally of (17, 20) increases the estimate to .818, then the this is updated with the uninformed tally of (17,18). BUt most of the votes in this tally have already been "counted"

This scenario illustrates why double-counting is problematic.

The new scenario also has a lower estimate for the informed p: .437 vs .481. Again this seems paradoxical because the count from the uninformed vote is mostly upvotes. But
	again the double counting explains it: the overall rally increases the estimate of the overall probability to .818, which is lower than the estimate .9 for the uninformed p, because the informed tally of (0,2)
	has already been counted. hen this is updated with the informed tally of (0,2). SO (0,2 is double-counted)

Yet the double-counting for the informed tally seems intuitive when I look at the "2 Voters, 1 Change" and especially the "2 Voters, 2 Changes" scenario. 	

For "2 Voters, 2 Changes", the overall probability estimate is .75. Both the uninformed and informed probabilities are lower than this. This seems wrong intuitively. The informed 
probability, based on a tally of [2,2] votes, which should result in a high estimate. To be exact, .75, the same as the overall estimate. In seems right that, since all voters are informed,
the informed and overall estimate should be the same.


Okay, new thought. Our prior beliefs for the informed and uninformed probabilities should not have the same center. We should believe, a priori, that the note brings the
informed probability back towards the global prior. A regression to the mean sort of thing. Why? because arguments are selected to be convincing. They provide the information
that would change belief without providing the information that would change the beliefs back. And counter-arguments are, a priori, those that are likely to  change beliefs back.

So there is another parameter, which tells us how far along the line between the global prior and the uninformed probability to expect the informed probability to be.

	uninformedProbability ~ Beta(global prior)
	uninformedUpvotes ~ Binomial(uninformedProbability, informedVotes)

	revisionConstant ~ Beta(global prior 2)

	informedProbability ~ Beta(global prior + (uninformedProbability - global prior)*revisionConstant)
	informedUpvotes ~ Binomial(informedProbability, formedVotes)

This turning intro: https://turing.ml/dev/tutorials/0-introduction/ 

"""



# update(d::BetaDistribution, t::Tuple{Int,Int}) = update(d, t(t[1], t[2]))




has a mean equal to the mean of the uninformed upvote probability. But prior for the sampleSize parameter is not equal to sampleSize of the uninformed probability. Why is this?

Because the our prior belief in the sampleSize parameter for the informed probability distribution is our belief in **how much people are influenced by arguments**.


If we have a large number of uninformed votes, this provides strong evidence for estimating the uninformed probability. But it does not necessarily provide strong evidence for estimating the informed probability. We expect the informed  



A large number of votes on 𝐴 provide strong evidence for estimating ω = 𝑃ᵥ(𝐴=a). But our estimate for κ is based on our prior expectations about the degree to which people are influenced by arguments. This information can come from observation of actual variance in the case of past arguments. If this is historical very high, then κ should be low, and vice versa.



This gives us a hierarchical model with two Beta distributions, and you're looking for an approximation for the posterior distribution of 






The global prior tiself

The global prior is also represented as a beta distribution.



The posterior can't be characterized analytically. We can use methods such as MCMC to approximate the posterior. 

But we are constantly getting new data on new posts. We need to be able to quickly estimate the posterior for a new post without rerunning the MCMC model.

If we have a very large amount of data, we can take our estimate of the global parameters and assume they are fixed, constant. Then, for each post, we have a simple beta-bernoulli model and the posterior  given tally (Z,n) is just beta(globalPriorAlpha + z, globalPriorBeta + n - Z) 






