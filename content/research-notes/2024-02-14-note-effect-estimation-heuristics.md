## Outline of Informed Probability

The Bayesian Hierarchical model for the informed prob
	- the simple form
	- the more complex form with reversion constant
MC Estimate
	- implementation in Julia
Speeding up calculation
	Approximate calculations
		- refer to approximation we made before
		- reasoning for approximation
		- compare models
	Precalculation and Caching
		- code in Julia

Thoughts: we need output distribution, not just mean


### Brainstorm for Alternative Model

Okay what if we modeled things differently. What if we had a parameter for the *overall upvote probability, which was based on the final votes of all users.


We use the votes of informed users then to estimate the overall Probability, then use them again to count the informed Probability. So we are in a sense double-counting votes. Why is this valid? Well it's certainly valid to estimate some parameter, such as upvoteProbability or height, for any well-defined group. And then it's valid to look at two different subgroups and estimate height for each subgroup. Is it valid to use the overall as the prior for each subgroup?

Here's why I think so. If you did not count the entire group when estimating the prior for the subroups, then suppose when of the subgroups was very small. You would estimate the average for the subgroup based on the hyperprior Bayesian averaged with the data for the small subgroup. The average of the large subgroup does not even influence the result. But in reality we would expect the average for the small subgroup to be closer to the average of the large.

You could use the average for the one subgroup as the prior for the average. But again suppose one group is large and one is very small (e.g. 1 user). Using the average for the small subgroup as a prior for the larger makes the final estimate for the larger very sensitive to the value for that one group.

Using the overall mean as the prior makes sense under this scenario. If there is one very small subgroup, then the posterior for both subgroups will be very similar. Only if both subgroups are sufficiently large will we have evidence that there is a difference between the groups.

Another reason it makes sense to "double count" is that we are asking two different questions. We are not asking


so form estimate of overall Probability. Then form estimate of informed Probability. The prior is the overall Probability...



### Implementation in Julia

An implementation of this model using Julia and Turing is here. 

### Point Estimates for $p$ and $q$

We can simplify the model by running a Monte-Carlo simulation on the full model to estimate the values for $m$, $C$, $C2$ and $R$, and then treating these as constants. 

- $q_i\sim \text{Beta'}(m, C)$
- $p_(i,j) \sim \text{Beta'}(q̅_i - (q̅_i - m)×R, C2)$
- $Z_{uninformed} \sim \text{Binomial}(n, q_i)$
- $Z_{informed} \sim \text{Binomial}(n, p_{i,j})$

The posteriors of the simplified model still cannot be characterized analytically. But the posteriors are all now independent. So as more posts and notes are created and as more data is added, we can quickly calculate updated estimates for $p$ and $q$ without recalculating the whole model.

#### Estimation using Bayesian Averaging

Looking at just $q$, we have a standard Beta-Binomial model, and we can estimate $q$ using Bayesian Averaging.

We can then user $q̅$ to estimate the prior for $p$. And once again we have a simple Beta-Bernoulli model.

However, these approximations aren't really valid Bayesian inferences. They will approximate the mean of the correct Bayesian posterior only if we have a very large sample size for the uninformed tally.

If we have a small uninformed sample size, our estimate of $q$ may be very different from the true Bayesian posterior. This is especially true if we have a large *informed* sample size, because a proper Bayesian estimate will incorporate the informed votes in the estimate of the uninformed probability. If for example the informed tally is (999,1000), and the uninformed tally is (0,1), our estimate for the uninformed probability should probably be closer to 1 than 0. The large number of informed votes adds plausibility not just to the hypothesis that the $p$ is much larger than $q$, but also to the hypothesis that $q$ is very high and $p$ is not much higher. 

Another approach to 


#### Estimation using Sampling



run a tiny Monte-Carlo simulation for each 

We still need to use methods such as Monte-Carlo simulations to approximate the posterior. 





, although in order to estimate these constants we need to add them 

- $q \sim \text{Beta'}(m, C)$
- $Z \sim \text{Binomial}(n, q)$


- $p_{\text{post}} \sim \text{Beta'}(m, C)$

- $q_{\text{post}} \sim \text{Beta'}(m, C)$



- $q_{\text{post}} \sim \text{Beta'}(m, C)$
- $Z \sim \text{Binomial}(n, q_{\text{post}})$


- $m \sim \text{Uniform}(0, 1)$
- $C \sim \text{Gamma}(2, 2)$
- $m_{\text{post}} \sim \text{Beta'}(m, C)$
- $Z \sim \text{Binomial}(n, m_{\text{post}})$



This adds another Beta distribution to our model. The prior for the informed upvoteProbability is based on our estimate of the uninformed probability. Obviously our best starting guess is that the informed probability equals the uninformed probability. 

However, our prior for the informed probability is not the exact same probability distribution as our posterior for the uninformed probability. Although the mean of the two distributions is the same, the sampleSize parameters should be different.

This is because the more data we collect for the uninformed probability, the more confident we are in our estimate of the mean. However, this does not make us more confident in our estimate of the mean of the informed probability. We believe, a priori, that the informed probability is likely to be different, and are very uncertain of its value  until we have collected more data specifically about the informed probability.

So the sampleSize parameter for the informed probability should start out the same for each post and should be relatively weak. We'll call the global sampleSize parameter $C_2$.

Just as with $C_2$, we need a prior for $C$. We can use the same Gamma distribution in this case. So we have added the following to our hierarchical model:

- $C_{2} \sim \text{Gamma}(2, 2)$
- $m_{\text{informed}} \sim \text{Beta'}(m_{\text{post}}, C2)$
- $Z_{\text{informed}} ~ Bernoulli(m_{\text{post}})$

### Shortcuts for Estimating Probabilities

The Bayesian Averaging formula takes a shortcut: it treats $C$ and $m$ as fixed values. This is cheating because a theoretical Bayesian reasoner doesn't have such fixed beliefs. Before we have a lot of data, each observed vote will have a large affect on the posterior for both the global and the post parameters. But after data for many posts is collected, the posterior for the global parameter will have a large sampleSize, and the evidence of new votes will mostly change beliefs about the post. So cheating, and just assuming this parameters as fixed at some point, is pretty safe.

One way of making quick estimate about the informed probability is to cheat in the same way. Treat $C_{2}$ and $m_{\text{post}}$ as fixed. 

The latter is more questionable, because we may not have a lot of uninformed votes for the post. 

The problem is, if we don't take some shortcuts, estimating the informed probability is a lot of work. It's not possible to characterize the posterior distribution analytically. We'd need to do something like run an MCMC simulation to estimate the uninformed and informed probability for each post (and updating the global priors at the same time). 

But here's another approach. Fix our global priors $m$, $C$, and $C_2$ after an initial MCMC simulation. Then, create a grid of combinations of possible values for m_post and m_informed in increments of .01. Then, sample many times from the posterior given these parameters, for a fixed value of n and m, and saving the results in a table that counts the number of times the sample produces Z1/n and Z2/m results for each combination of parameters. Use this to calculate prob(theta|Z1,Z2).

We could then go over the




But we are constantly getting new data on new posts. We need to be able to quickly estimate the posterior for a new post without rerunning the MCMC model.

If we have a very large amount of data, we can take our estimate of the global parameters and assume they are fixed, constant. Then, for each post, we have a simple beta-bernoulli model and the posterior  given tally (Z,n) is just beta(globalPriorAlpha + z, globalPriorBeta + n - Z) 
