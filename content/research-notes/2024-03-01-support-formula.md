# Derivation of the "Support Formula"

## The Problem

Suppose we have an estimate of the effect of note B on post A, and the effect of subnote C on note B. Should we be able to predict the effect of subnote C on post A.

To estimate the informed probability for A, we want to know the effect of all information -- both the note and the subnote. Since considering the subnote implies considering the note, what we are really interested in is $P(A \vert considered~C)$.

We can estimate this the same way we estimate $P(A \vert considered~B)$, by looking at the informed and uninformed tallies of $B$ or $C$ with respect to A.

However, there are a couple of reasons we would like to estimate $P(A \vert considered~C)$ without looking at the tallies for A and C. 

1. One is that B might be a reused post, and we would like to automatically apply the arguments for/against B to discussion about A, even for users that are not involved in the discussion about A.

2. The other is that we can perhaps simplify the algorithm and the number of tallies we need to keep track of.

So to summarize the problem, we want to calculate $P(A \vert considered~C)$ given the tallies for (A,B) and the tallies for (B,C).

## Scenario 1

I'll start by laying out a scenario that I'll use to talk through my reasoning.

Suppose 46% of people believe A, but considering B increases that to 90%

``` math
\begin{aligned}
    &P(A \vert not~cB) = 46\% \\
    &P(A \vert cB) = 90\%
\end{aligned}
```

Suppose 99% of people believe B, but considering C reduces that to 50%

``` math
\begin{aligned}
    &P(B \vert not~cC) = 99\% \\
    &P(B \vert cC) = 50\%
\end{aligned}
```

## Define

Let's define the effect of B on A as:

``` math
\begin{aligned}
    E(A,cB) &= P(A \vert cB) - P(A \vert not~cB) \\
            &= 90\% - 46\%  \\
            &= 44%
\end{aligned}
```

So we can write:

``` math
\begin{aligned}
    P(A | cB) = P(A \vert not~cB) + E(A,cB)
\end{aligned}
```

Then let's define the support of C wrt B as 

``` math
\begin{aligned}
    S(B,cC) &= \frac{P(B \vert cC)}{P(B \vert not~cC)} \\
            &= \frac{50\%}{99\%} \\
            &≈.505  
\end{aligned}
```

## Initial Proposed Formula

My initial proposed formula was for estimating the effect of considering C on A was:
    
``` math
\begin{aligned}
    P(A \vert cC) ≈ P(A \vert not~cB) + S(B,cC) × E(A,cB)
\end{aligned}
```

## Intuition for Initial Formula

My reasoning is as follows. In the above scenario, considering B makes increases the probability of upvoting A by 44 percentage points. Presumably, this increase comes from people that agreed with and upvoted B.

Now, if only 55% of those people upvoted B after considered C, the effect would be reduced to


``` math
\begin{aligned}
    50.5\% × .44 = .22 
\end{aligned}
```

And so B and C together, instead of increasing the probability of upvoting A by 44 percentage points to $90\%`$, only raises it by 22 percentage points to $`68.22\%`$.

## Problem with Proposed Formula

[Johannes discovered](2024-02-05--top-note-algorithm.md) that this formula practically results in probabilities outside the range of 0 to 100, because:

``` math
\begin{aligned}
	\text{support} \in (0, \infty)
\end{aligned}
```

### Scenario 2


This problem can be illustrated with a variation of the above scenario. We still have


``` math
\begin{aligned}
    &P(A \vert not~cB) = 46\% \\
    &P(A | cB) = 90\%
\end{aligned}
```

But now let's say that considering C increases the upvote probability of B from 0.01 to .99

``` math
\begin{aligned}
    &P(B|not~cC) = 0.01 \\
    &P(B|cC) = .99
\end{aligned}
```

Support is now

``` math
\begin{aligned}
    S(B, cC) = .99/.1 = 99
\end{aligned}
```

So a user who considers C is 99 times more likely to upvote A.

``` math
\begin{aligned}
    P(A \vert cC) \\
    &= P(A \vert not~cB) + E(A,cB) × S(B,cC) \\
    &=  46\% + (90\% - 46\%) × 99 \\
    &= .46 + (.90 - .46) × 99 \\
    &= 4400\% \\
\end{aligned}
```

This doesn't make sense.


## Analysis of Problem

The problem is that users are behaving outside of our assumptions. Presumably, when post B changes users votes on A, this is what happens:

- users see and vote on post B
- they downvote B if they think B is 1) not true 1) not informative or 2) and relevant
    - probably, they won't upvote things they think are not true an relevant
    - they may upvote things that are not informative to them (that they already knew) if they think they are relevant to others.
- they upvote B if they accept B as true, informative, and relevant (all three):
    - the fact that B is *informative* implies that it may causes them to change their belief about some underyling claim Z (e.g the claim being made in the post)
    - the fact that B is *relevant* implies that Z is relevant to their belief in Y

The reason we conjure some underyling claim $Z$ is that users belief in $Z$, $P(Z)$, is not the same as $P(B)$. To upvote $B$, users need not only accept $Z$ as true, but also as relevant and informative. This means that the probability of upvoting B is some fraction of the probability of believing $Z$. Namely

``` math
\begin{aligned}
    P(B) = r × P(Z)
\end{aligned}
```

Where $r$ is between 0 and 1.

So if users change their belief in $Z$ (e.g. by considering note $C$), they may increase their probability of upvoting $B$, but not by as much as they increase their belief in $Z$.

So if $P(B)$ is only 1%, then $P(Z)$ is only $r×1%$. So post $B$ increased $Z$ by at most 1 percentage point. It seems hard to believe that such a small increase in $Z$ would have a large increase in $A$.

And in fact, our intuitions here are validated by math, and the rules of Bayesian belief updating. Given any two propositions such as $Z$ and $A$, the probability of one is a linear function of the other probability of the other. Per something called Jeffrey's Rule, a Bayesian reasoner with beliefs $P(A)$ acquires information that has no other effect than to increase their belief in $Z$ from $P(Z)$ to $P'(Z)$ their posterior $P'(A)$ will be:

``` math
\begin{aligned}
    P'(A) = P(A \vert not~Z) + R(A,Z)×P'(A)
\end{aligned}
```

Where

``` math
\begin{aligned}
    R(A,Z) = P(A|Z) - P(A|not~Z)
\end{aligned}
```


I call the quantity $R(A,Z)$ the relevance of $Z$ to $A$, and discuss this in more depth in my articles on [Bayesian Argumentation](https://jonathanwarden.com/bayesian-argumentation/)

It is easy to see that $R(A,Z)$ will be between 0 and 1. This means that considering post $B$ causes $P(Z)$ moves from $z0$ to $z1$, then $P(A)$ will move to $R(A,Z)*(z1 - z0)$. So if $B$ changes $Z$ by less than 1%, $A$ will change by less than 1%.

In our second scenario, $B$ increased $Z$ by 44 percentage points. So if our assumptions about user behavior is correct, this scenario is not realistic, and which means that we fortunately may be unlikely to see it in our data. 

But unfortunately, we probably will sometimes see scenarios resulting in impossible probabilities. First, because our assumptions may be wrong. And second, because randomness. Our estimates of the various probabilities that go into our support formula is based on vote tallies, which are random samples from the "true" probability distributions, and so errors in these estimates can cause them to fall outside the limits of our assumptions.

So what do we do about this? Well my first thought is that a we could use Bayesian methods here and estimate the various probabilities using MCMC or something.

But for now we could just assume that our estimates will usually fall within a reasonable range, and if the estimate is 100% we could just cut it off at 100%.







