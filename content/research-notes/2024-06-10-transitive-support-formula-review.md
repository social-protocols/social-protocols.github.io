# Uses of the Transitive Support Formula

This note briefly reviews the **support formula**, why we are not using it now, and how we could use it.

The support formula allows us to estimate effects *transitively*: e.g. we can estimate the effect of C on A based on the effect of B on A and the effect of C on B.

Here are some research notes on the Support Formula from back in March:

- [Derivation of the "Support Formula"](https://github.com/social-protocols/internal-wiki/blob/main/pages/research-notes/2024-03-01-support-formula.md)
- [More Formal Derivation of Support Formula](https://github.com/social-protocols/internal-wiki/blob/main/pages/research-notes/2024-03-05-support-formula-derivation.md)

It would be nice if we could simplify our algorithm by relying on a transitive formula like this completely, instead of measuring the effects every descendant on every ancestor. However, I don't think we can do this, as I explain below. However, I believe we *can* make use of a similar transitive formula in the future.


## Review of Support Formula with Example

Consider this example argument:

- A: We should hire this candidate
- B: He aced the skills test
- C: He is in the hospital in a coma

And suppose the upvote probabilities are:

- $P(A |vert~B)$ = 0.5
- $P(A \vert B)$ = .90
- $P(A \vert B,C)$ = .01
- $P(B |vert not~C)$ = .99
- $P(B \vert C)$ = .5

So B increases upvotes on A by .40 percentage points, from .5 to .90. And C decreases upvotes on B from .99 to .5 -- roughly cutting them in half. The support formula says that the effect of B on A should now also be cut in half, from +.40 percentage points to +.20 percentage points. So B would increase votes on A by only .20 points, from .50 to .70.

### Exact Formula

The initial support formula was the following (in [More Formal Derivation of Support Formula](https://github.com/social-protocols/internal-wiki/blob/main/pages/research-notes/2024-03-05-support-formula-derivation.md) I derive a slightly more correct formula). Based on this formula, we estimate $P(A \vert B,C)$ as follows



``` math
\begin{aligned}
    E(A,B) &= P(A \vert B) - P(A \vert not~B) .90-.50 = .40 \\
    S(B,C) &= \frac{P(B \vert C)}{P(B \vert not~C)} = \frac{.5}{.99} ≈ .50 \\
    P(A \vert B,C) &≈ P(A \vert not~B) + S(B,C) × E(A,B) = 0.5 + 0.4 × 0.5 = 0.7
\end{aligned}
```


## Analysis

The estimate of 0.70 given by the suport formula is not even close to the correct value of 0.01.

The problem is first of all that that there are just too many ways that the effects of comments in a thread can interact. In this example, C "trumps" B, so to speak. Once people learn the candidate is in a coma, they downvote A, regardless of other arguments. But in other cases it could be that effects are complimentary, redundant, additive, etc. 

The other problem is that people may upvote/downvote a comment not only because they agree and are convinced, but also because it is funny, useful, relevant (or not) etc. In this case, even after learning that the candidate is in a coma, half of people still upvote B, perhaps because B was true, and was a useful contribution to the discussion, despite the coma. But other users may downvote B since it's no longer relevant. Although we can interpret an upvote on B to mean a user agrees with the claim made in B, AND think it's relevant, civil, etc., if they downvote, we don't know why.

## Uses of the Support Formula

### As Prior

I believe the support formula could be used, first of all, as a prior. If we have few or no people that have upvoted both the target and some descendant comment deep in the tree, but have enough votes to calculate each individual effects of all links in the thread, we can use the support formula to make a guess about the effect of the comment on the target.

If C causes everyone who upvoted B to change their vote, it seem reasonable *as an initial assumption*, to assume that the effect of B on A should be erased. Not just because this gives us a likely estimate of the final informed probability, but because in a sense, users who are basing their upvote on A on their support of B don't have a *justified* position. Maybe people downvote B because it was uncivil, even though it is still convincing. It seems that people should have to justify their votes on A with an argument that is acceptable to the community.

### Votes on B as Weight

One way to factor support for B into the scoring formula is to use it as the weight in a [weighted average scoring formula](https://github.com/social-protocols/internal-wiki/blob/main/pages/research-notes/2024-06-10-weighted-average-informed-probability.md). In my original proposal, I was suggesting using the total number of votes on B as the weight, but using the total number of upvotes would be interesting. If there was only one thread under A, it wouldn't make a difference. But if there was two threads -- say B and some more civil sibling D arguing in the opposite direction -- then D would have more weight. Users will have weakened their position by making an argument that gets a lot of downvotes, even if convincing. Now a counter-argument to B may not even be necessary. Users who are convinced by B will have to respond to D, hopefully with a more civil version of the argument made in B, in order for the results to converge to the correct informed probability.

### For Questions

Second, I hope we can use a transitive formula for [questions](https://github.com/social-protocols/internal-wiki/blob/main/pages/research-notes/2024-03-27-questions.md). Suppose somebody creates a question/poll and asks "did so and so ace the skills test"? Suppose B is now the probability of users answering "yes" to this question. And suppose once again 99% of people think B is true, and B increases agreement with A by .4 percentage points.

Now, just by isolating B as an independent question, we can make use of transitive effects. Upvotes and downvotes on B now presumably reflect agreement with the claim made in B, and not its relevance to C, or how funny or useful it is. If somebody (irrelevantly) replies to B with C *He is in the hospital in a coma*, then hopefully people will downvote C (being in a coma doesn't change how he did on the test) and C won't change people's votes on B.

On the other hand, if somebody posts a reply, D *No he did terribly. You were thinking of another candidate*, that might reduce votes on B from say .99 to .01. And in that case, the effect of B on A should be effectively erased. And so a transitive formula could be used in this case to give an estimate of $P(A \vert B,D)$ should be .5 + 0 = .5.

This all depends on user voting behavior, and whether we can make a user experience that effectively carves out the debate on B into a conditionally independent sub-argument, encouraging people to upvote and downvote based solely on their belief in B and not on its relevance to A.

But if we can do this, this makes "distributed reasoning" possible, where we can have users that aren't even participating in the discussion about A, but still contribute indirectly to the discussion about B or any node deep in the discussion tree.
