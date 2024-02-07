# Measuring Informed Probability

Our scoring formula starts with an estimate of the probability that a user upvotes a post, and then observes how exposure to information in the note influences that probability. We differentiate "informed" vs "uninformed" upvote probabilities depending on whether user have or have not been "exposed" to the information.

But what exactly does it mean to be exposed to the information in the note? Does this mean they have **read** the note? But what if they read it and don't really pay attention to it?

We can't tell if a user really read the post, let alone really **considered** it. We know if we showed the note below the post when they voted on the post, and we can guess a priori that doing so caused in increased probability of the user considering the note. We also know if they voted on the note. And we can probably assume a priori that the user upvotes the note only if they considered to it.

## The Causal Model

So that gives us a causal model that looks like this:

- T is the probability of showing the note
- C is the probability of considering the note
- U is the probability of upvoting the post
- V is the probability of voting on the note

          T
          ↓   
          C
        ↙   ↘  
      U       V

And the following assumptions:

- We cannot observe C.
- T is entirely under our control and can be manipulated randomly.
- P(V=1|C=0) = 0 and P(V=1|C=1) is a constant.  
- Assume P(C=1|T=0) is nonzero, and that T=1 increases the probability of C=1 by some constant, and P(C=1|T=1) is the same for all posts.

So what do we want to ask of this model? Well what we really want is to estimate the effect of **considering** the note on the probability of upvoting the post. 

Let's define:

	Informed Upvote Probability = P(U=1|do(C=1)) = P(U=1|C=1)

This is the *maximum* possible effect of the information. Any intervention we do to bring the note to the user's attention can't have an effect beyond the user properly considering the information.

## V as a proxy for C

First, we can treat V as a proxy for the unobserved variable C. P(V=1∣C=1) is a constant and P(V=1|C=0)=0, the users who vote on the note are a representative sample of those who attend to it. So we can estimate

P(U|C) ≈ P(U|V=1)

	Number of upvotes on posts when note is voted on 
	-------------
	Total number of votes on posts when note is voted on


We can further restrict our data to scenarios where users were shown the note:

P(U|C) ≈ P(U|T=1,V=1)

	Number of upvotes on posts when note is shown and voted on 
	-------------
	Total number of votes on posts when note is shown and voted on




## Calculating Effect of Showing Note on Attention

Once we know S(U,C), then we can estimate how showing the note affects upvotes on the post.

If we define relevance as we do in my article on (Relevance and Corelevance](https://jonathanwarden.com/relevance-and-corelevance/):

	R(U,C) = P(U|C) - P(U|not C)
	R(U,T) = P(U|T) - P(U|not T)

And given the conditional independencies implied in the causal graph:

	P(U|T) = P(U|C)*P(C|T)
	P(U|not T) = P(U|C)*P(C|not T)

Then

	R(U,T) = P(U|T) - P(U|not T) = P(U|C)*P(C|T) - P(U|C)*P(C|not T)
           = P(U|C) * R(C,T)

So we can derive the effect of T on A as a general rule for posts by observing, for the average post.

	R(C,T) = R(U,T) / P(U|C)

We can generalize this to estimating the effect of other interventions (e.g. showing the note in notifications) on A.


## Hierarchical Model



Let's define the following Bayesian hierarchical model:

Assumptions:

	t_i,j is user i was shown note on post j
	c_i,j is user considered the note on post j
	u_i,j is user i upvoted post j
	v_i,j is user i voted on the note on post j
	p_j = P(U_j=1|C_j=1) = informedProbabability (for note j)
	r = P(V=1|C=1) = globalVoteProportion (known constant)

	s0 = P(C=1|T=0) = globalConsiderationRate (known constant)
	s1 = P(C=1|T=1) = globalConsiderationRate (known constant)
	c_i,j = s0(1 - t_i,j) + s1*t_i,j  

And the model:

	p_j ~ beta(globalPriorVoteRate)
	u_i,j ~ bern(p_j * c_i,j)
	v_i,j ~ bern(r * c_i,j)


Now, suppose for some post/note combination, we want to estimate p_j P(U_j=1|C_j=1) but we have sparse data. We only have a handful of users that voted on the post: some that voted on the note, a few were shown the note but didn't vote, and none were both shown the note and voted on it.

According to ChatGPT, the answer is no:
- https://chat.openai.com/share/04bbe82c-7db1-4eda-baa6-0a09e651755b


## Conclusions for Today

This is a difficult problem. I am not convinced that there is not a way to create an estimator for the informed probability given sparse data that includes some user that were shown the note and note voted, and some that voted but not shown, and some both.

However, it's complex. I will be easier to *only* consider users that voted.


Here are some updates of some other chats with ChatGPT discussing this approach

- https://chat.openai.com/share/89c6a4f2-3105-4927-ab98-616aad2d3aa9
- https://chat.openai.com/share/440e3d9a-51f8-4d59-9e11-3bd57c666013
- https://chat.openai.com/share/04bbe82c-7db1-4eda-baa6-0a09e651755b
