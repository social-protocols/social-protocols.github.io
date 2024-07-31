# Notes on 2024-07-19-thoughts-on-convincingness.md

This note is a response to Johannes's [2024-07-19-thoughts-on-convincingness.md](2024-07-19-thoughts-on-convincingness.md)

## "Imbalance" ≈ "Statistical Independence"

It seems to me that "imbalance" as you are defining it boils down to statistical independence, or lack of correlation. If upvotes on B and upvotes on A are perfectly correlated, the imbalance score will be 0, and if they are totally uncorrelated (statistically independent), the imbalance score will be maximized.

Let's simplify things by assuming that that we always have equally sized groups

$$
	p_a = P(upvote A) = 0.5
$$

Since we are only interested in people who voted on A, let's slightly simplify our notation:

	- $`p   = P(upvote B)`$
	- $`p_d = P(upvote B \vert downvote A)`$
	- $`p_u = P(upvote B \vert upvote A)`$
	- $`p_a = P(upvote A)`$

We can now write p as a function of $`p_d`$ and $`p_u`$:

By the law of total probability:

$$
	P(upvote B) = P(upvote B \vert upvote A) \times P(upvote A) + P(upvote B \vert downvote A) ×P(downvote A)
$$

Which we can rewrite as:

$$
\begin{aligned}
	p &= p_u × p_a + p_d × (1 - p_a) \\
	  &= p_d + (p_u - p_d) \times p_a \\
	  &= p_d + (p_u - p_d) \times 0.5 
\end{aligned}
$$

**Aside**: that note gives an example where $`p = 0.25`$, and $`p_d = .25`$, and says "the further away from $p$ $p_u$ is...the higher the absolute imbalance". But $`p = p_d = .25`$ actually implies that $`p_u`$ is also equal to $`.25`$ -- there can be no imbalance in this case.

Since $`p`$ is a function of $`p_u`$ and $`p_d`$, the "imbalance" formula is really just a measure of the difference between $`p_u`$ and $`p_d`$. Imbalance should be 0 when $`p_u = p_d`$, and should be maximized when $`p_u`$ and $`p_d`$ are very different (e.g. when $`p_u`$ = 0 and $`p_d`$ = 1 or vice versa). A simpler score, perhaps just $`abs(p_u - p_d)`$, would also have the properties we want.

But we could also just measure the statistical correlation of A and B. If $`P(upvote B) = P(upvote B \vert upvote A) = P(upvote B \vert not upvote A)`$ then by definition "upvote B" and "upvote A" are statistically independent. 

The information-theoretic measure of statistical correlation is mutual information. In fact, I think if we really dug in, we'd find your formula is closely related to the mutual information formula. 

## Micro Bridging-Based Ranking

You are asserting that a high imbalance (low correlation between A and B) implies that B is likely to change users' minds. But why would this be?

I think this implies something similar to a high "common ground" factor in a bridging-based ranking algorithm. In community notes, a note has a high score if it's upvotes cannot simply be explained or predicted by user's left-wing or right-wing bias. 

When looking at a single post and a single comment/note, "bias" is implied by users' votes on A. So we want to give a high score to replies to A that can't simply be explained by users' biases (their original votes on A).

Of course, if people from both groups downvote B, then B probably isn't changing any minds. So what we want is not just lack of correlation, but a high upvote probability *despite* user's biases (just as in community notes, we want notes with a high *positive* common-ground factor, not just a non-zero common-ground factor). So we probably want to look at comments where $`p_u`$ and $`p_d`$ are both high.

Basically, we could do something that is kind of like bridging-based ranking but at a micro-level (single comment/note) instead of macro-level (all notes). The community notes algorithm effectively erases any difference between the sizes of the two groups. We could do the same by giving p_u and p_d equal weight (regardless of what p_a actually is). So the formula could be simply:

$$
	(p_u + p_d) / 2
$$








