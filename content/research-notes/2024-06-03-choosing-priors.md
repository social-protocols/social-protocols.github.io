# Choosing Prior Upvote Probability

We currently use a prior of $Beta(0.25, .025)$ for the uninformed upvote probability.

This was arrived at from two different directions:

## 1. The Empirical Prior

The 'Empirical Prior' of $Beta(.27, .27)$ is from [Zhu, Jian-Qiao & Sanborn, Adam & Chater, Nick. (2020)](https://www.researchgate.net/publication/340042592_The_Bayesian_sampler_Generic_Bayesian_inference_causes_incoherence_in_human_probability_judgments
)[^1], based on an attempt to answer the question "What is the most appropriate generic prior Beta distribution...". The idea is that a Uniform prior $Beta(1,1)$ may not reflect the real world. In the real world, we tend to deal with claims that are probably true or probably false. The Haldane's Prior $Beta(0,0)$ and Jeffrey's Prior $Beta(0.5,0.5)$ are two Beta distributions that have this property. But the authors used an analysis of human language to come up with an Empirical prior of $Beta(.27,.27)$.


## 2. Our Intuitions 

We have some intuitions of how scoring should work when there are few votes:

1) initially, when there is only the submitter's upvote, p should be close to .85 based on anecdotal data on upvote/downvote ratios from Reddit
2) if there is an equal number of upvotes and downvotes, there doesn't seem reason for p to be anything other than 50%
3) if a user posts a counter-argument with their vote, there should be a slight bias in favor of that user until other users vote on or reply

The expected results of the simulation test two-users-disagreeing.jl reflects these constraints. Only a prior close to $Beta(.27, .27)$ -- the Empirical Prior above -- makes these test pass. 

All the distributions we've discussed have a mean of 0.5 and a sample <= 1. Focusing on sample sizes, we have a pattern:

- Uniform: 2
- Jeffrey's: 1
- Empirical: .54
- Haldane: 0

This may all just be a coincidence, but it makes me think that the Empirical prior sample size should be .5 exactly and that it reflects some fundamental distribution. So that's what we're going with for now.


### Notes from Zulip Chat 2024-06-03

From Zulip chat.
> Johannes Nakayama
> 5:24 PM
> Interesting! Makes a lot of sense, thinking about it this way. It's probably a better prior for our purposes because the  uniform prior doesn't apply so well to a very polarized discourse ecosystem. Might be a better assumption to have a prior  belief that reflects that people will either agree or disagree (somewhat strongly) with any given post.

## Estimating via MCMC Simulation

I previously assumed we'd have to discover this global prior empirically using a MCMC simulation once we got enough data. But now I think we have a good guess what the results of that simulation will be. In fact I think the MCMC simulation would necessarily produce similar numbers as long as the data has the following properties:

1) the average upvote probability on a post (given the original poster's upvote) is close to .85
2) the average upvote probability given the first vote is a downvote (e.g. when there is 1 upvote and 1 downvote) is close to .50

If empirically, we find these numbers are different, then the global prior upvote probability would have to be whatever made those numbers fit. For example, suppose we find the average upvote probability on a post is .75, and that given the first vote is a downvote, the average upvote probability is .6. We'd need a prior $Beta(alpha, beta)$ such that the mean of $Beta(alpha+1, beta)$ is .75 and the mean of $Beta(alpha+1, beta+1)$ is .6.


[^1]: [Zhu, Jian-Qiao & Sanborn, Adam & Chater, Nick. (2020). The Bayesian Sampler: Generic Bayesian Inference Causes Incoherence in Human Probability Judgments. Psychological Review. 127. 10.1037/rev0000190.](https://www.researchgate.net/publication/340042592_The_Bayesian_sampler_Generic_Bayesian_inference_causes_incoherence_in_human_probability_judgments
)
