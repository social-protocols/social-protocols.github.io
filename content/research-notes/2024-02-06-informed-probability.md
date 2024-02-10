# Measuring Informed Probability

Our scoring formula starts with an estimate of the probability that a user upvotes a post, and then observes how exposure to information in the note influences that probability. We differentiate "informed" vs "uninformed" upvote probabilities depending on whether users have or have not been "exposed" to the information.

But what exactly does it mean to be exposed to the information in the note? Does this mean they have **read** the note? But what if they read it and don't really pay attention to it?

We can't tell if a user really read the post, let alone really **considered** it. We assume that if we showed the note below the post when they voted on the post, it is more likely that they considered it. And if they voted on the note, they almost certainly considered it. 

We can also assume that the proportion of users who consider the note when it is shown to them is the same for all posts, and similarly the proportion of users who vote on the note after considering it is the same for all posts.

## The Causal Model

So that gives us a causal model that looks like this, and some assumptions:

- $N$: note is created
- $T$: user is shown the note
- $C$: user considers the note
- $V$: user votes on the note
- $U$: user upvotes the post

```
          N
          ↓
          T
          ↓   
          C
        ↙   ↘  
      U       V
```

With the following assumptions:

- We cannot observe $C$
- $T$ is entirely under our control and can be manipulated randomly.
- $P(V=1|C=0) = 0$ and $P(V=1|C=1)$ is a global constant. 
- Assume $P(C=1|T=0)$ is nonzero, and that $T=1$ increases the probability of $C=1$ by some constant, and $P(C=1|T=1)$ is the same for all posts.

So what do we want to ask of this model? Well, what we really want is to estimate the effect of **considering** the note on the probability of upvoting the post. 

Let's define the Informed Upvote Probability as:

$$
     P(U=1|do(C=1))
$$

Since the only arrow into $U$ is from $C$, this is equal to:

$$
    P(U=1|C=1)
$$

The informed probability is the *maximum* possible effect of the information. Any intervention we do to bring the note to the user's attention can't have an effect beyond the user properly considering the information.

## V as a proxy for C

Given our assumptions above, we can treat $V$ as a proxy for the unobserved variable $C$. Since $P(V=1|C=1)$ is a constant and $P(V=1|C=0)=0$, the users who vote on the note are a representative sample of those who consider it. So we can estimate:

$$
P(U|C=1) \approx P(U|V=1) = 
    \frac{\text{Number of upvotes on posts when note is voted on}}{\text{Total number of votes on posts when note is voted on}}
$$

## Shown vs Voted on Note

When a user votes on the note, we know they considered it. If they were shown the note, but did not upvote, there is less of a chance they considered it. Thus, the effect of showing the note should be less than the full effect of considering the note, but in the same direction.

So the events $T$ and $V$ increase the probability of $U$ in proportion to the amount they increase the probability of $C$. This relationship is illustrated in the chart below.

```
                 |                 |
                 |                 ×-P(U|C=1) = P(U|V=1)
                 |              ∙  |
                 |           × ------P(U|T=1,V=0)
                 |        ∙  |     |
    P(U|T=0,V=0)------ ×     |     |
                 |  ∙  |     |     |
        P(U|C=0)-∙     |     |     |
                 |     |     |     | 
                  -----|-----|-----|
                       |     |     |
               P(C|T=0,V=0)  | P(C|V=1)=1
                             | 
                         P(C|T=1,V=0)
```

The slope of the line is $R(U,C) = P(U|C=1) - P(U|C=0)$. I call this slope the **relevance** of $C$ to $U$, as defined in my essays on [Bayesian Argumentation](https://jonathanwarden.com/bayesian-argumentation/).

So before being shown the note, the probability of considering the note is $P(C|T=0,V=0)$, and the probability of upvoting the post is $P(U|T=0,V=0)$. This is the first x on the line.

This value is greater than $P(U|C=0)$ because even a user who wasn't shown the note under the post when they voted on it may have found it and considered it some other way.

If the user is shown the note, but has not yet voted on it, then the probability that they considered the note moves to $P(C|T=1,V=0)$, and consequently the probability of upvoting the note moves to $P(U|T=1,V=0)$. This is the second × on the line.

Finally, when the user votes on the note, the probability that they considered the note moves to 1, and consequently the probability of upvoting the note moves to $P(U|V=1) = P(U|C=1)$. This is the third × on the line.

## Extrapolating

Once we find any two points on this line, we can extrapolate any other point. This is great:

- If we know $P(U|T=0,V=0)$ and $P(U|T=1,V=0)$ we can extrapolate $P(U|V=1)=P(U|C=1)$. This is useful if we have sparse data (nobody has voted on the note).
- If we know $P(U|T=0,V=0)$ and $P(U|V=1)$ we can extrapolate $P(U|T=1,V=0)$. This is also

 useful if we have sparse data.
- We can also extrapolate based on $P(U|C=0)$ -- which we can do by considering upvotes that happened *before* the note was created.

We can extend this method to other events that bring the note to the attention of the user. This allows us to calculate the value of each of these attention events.

### Example Extrapolation

Say we observe $P(U|V)=P(U|C=1)$, and $P(U|T=1,V=0)$. We want to extrapolate $P(U|C=0)$:

$$
        P(U|T=1)  = P(U|C=0,T=1) + P(U|C=1,T=1)  
                  = P(U|C=0) \cdot P(C=0|T=1) + P(U|C=1) \cdot P(C|T=1)
$$

$$
        P(U|C=0) \cdot P(C=0|T=1) = P(U|T=1) - P(U|C=1) \cdot P(C|T=1)
$$

$$
        P(U|C=0) = \frac{ P(U|T=1) - P(U|C=1) \cdot P(C|T=1) }{ P(C=0|T=1) }
$$

### Example Extrapolation 2 

Now say we observe $P(U|T=0,V=0)$ and $P(U|T=1,V=0)$. We can also extrapolate $P(U|V=1)$. Derivation [here](https://chat.openai.com/share/381d2699-f8b1-4079-87cd-f8180d33d785).

$$
    P(U|V=1) = P(U|T=0,V=0) + \frac{ P(U|T=1,V=0) - P(U|T=0,V=0) }{ P(C|T=1,V=0) }
$$

## Bayesian Hierarchical Model

Let's define the following Bayesian hierarchical model:

Assumptions:

- $t_{i,j}$ is whether user $i$ was shown the note on post $j$ but did not vote.
- $c_{i,j}$ is whether user $i$ considered the note on post $j$.
- $uv_{i,j} = 1$ if user $i$ upvoted post $j$ given they voted on the note.
- $ut_{i,j} = 1$ if user $i$ upvoted post $j$ given they were shown the note.
- $θ_j = P(V=1|V_j=1)$ = informedProbability.
- $θ[0]_j = P(V=1|T_j=0,V_j=0)$ = probabilityGivenNotShown.
- $θ[1]_j = P(V=1|T_j=1,V_j=0)$ = probabilityGivenShown.
- $r = P(V=1|C=1)$ = globalVoteProportion (known constant).
- $s0 = P(C=1|T=0,V=0)$ = globalConsiderationRate (known constant).
- $s1 = P(C=1|T=1,V=0)$ = globalConsiderationRate (known constant).
- $c_{i,j} = s0(1 - t_{i,j}) + s1 \cdot t_{i,j}$  

Since $V$ is a proxy for $C$, then $P(U|V=1) \approx P(U|C=1) = θ$.

Then we can have beta-bernoulli models to estimate $θ$, $θ[0]$, and $θ[1]$ based on the votes of people who voted on the note. 

- $uv_{i,j} = 1$ if user $i$ upvoted post $j$ given they voted on the note.
    
$$
    θ_j \sim \text{beta}(\text{globalPriorUpvoteProbability})
$$

$$
    uv_{i,j} = \text{bern}(θ_j)
$$

And another model for $θ[1]$:

- $ut_{i,j} = 1$ if user $i$ upvoted post $j$ given they were shown the note.
    
$$
    θ[1]_j \sim \text{beta}(\text{globalPriorUpvoteProbability})
$$

$$
    ut_{i,j} = \text{bern}(θ[1]_j)
$$

And another model for $θ[2]$.

### Combining Hierarchical Models using Pseudo-Counts

Now, since the thetas are all related, we can combine these models into one model, where the parameters are slope and intercept, and the $θ$ values are a function of these. But this is super-complicated. 

Another approach would be to estimate $θ$ using the data we have for users that voted on the note. Then we can separately estimate$ θ[1]$ and$ θ[2]$ , and use these to update$ θ$ using a pseudo-tally.

Suppose we already have $θ=\text{beta}(\alpha,\beta)$ based on the tally of votes of users that voted on the note, and we also have beta distributions for $θ[1]$ and $θ[2]$.

Then we can take $\text{mean}(θ[1]) \approx P(U|T=1,V=0)$ and $\text{mean}(θ[0]) \approx P(U|T=0,V=0)$ and use this to estimate a value for $θ'$. Given

$$
    P(U|V=1) = P(U|T=0,V=0) + \frac{ P(U|T=1,V=0) - P(U|T=0,V=0) }{ P(C|T=1,V=0) }
$$

So 

$$
    θ' = \text{mean}(θ[0]) + \frac{ θ[1] - θ[0] }{ s1 }
$$

We can then create a pseudo-sample-size $n$ by just adding the sample sizes for $θ[1]$ and $θ[2]$ (perhaps multiplying by some constant), and a pseudo count $Z = n \cdot θ'$. Then use these to update $θ$.

So we get a posterior $θ \sim \text{beta}(\alpha + Z, \beta + n - Z)$.

### Linear Regression 

Another approach would be a linear regression. Doing a Bayesian linear regression would give us a probability distribution for the slope and intercept. From this, we can compute the probability distribution for $θ$, $θ[1]$, or $θ[2]$ values.


## Further Thoughts

We are glossing over some assumptions. We should rewrite the above based on the idea of different events. N -> T -> V. Probability of considering note increases with each event. The event T should be shown note *but not voted on it*. And the state V should be voted, whether or not it was shown.

The probability of C increases as each event happens. P(C|V)=1. P(C|N) and P(C|T) should be global constants. We can estimate these by finding the slope R(C,U). If we know the slope and the vertical coordinate of a point on the line (P(U|N) or P(U|T)), we can find the horizontal.

## Conclusions/Summary

I think that it's best to simplify the model and only look at users who voted on the note. This lets us calculate $θ=P(U|C=1)=P(U|V)$ more directly using a simple beta-bernoulli model.


