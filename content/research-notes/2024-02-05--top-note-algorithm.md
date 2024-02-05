# Review of the Top Note Algorithm

We are considering two posts: $A$ and $B$. $B$ is a reply to $A$.

Then we are observing the following events:

- $u_A := \text{the event that a vote on A is an upvote}$
- $u_B := \text{analogous}$
- $s_B := \text{the user was shown post B}$
- $\bar{s_B} := \text{the user was not shown post B}$
- $s_{B*} := \text{the user was shown the top note on B}$
- $\bar{s_{B*}} := \text{the user was not shown the top note on B}$

Then we define two quantities:

$$
\text{delta} = P(u_A | s_B) - P(u_A | \bar{s_B})
$$

and

$$
\text{support} = \frac{P(u_B | s_{B*})}{P(u_B | \bar{s_{B*}})}
$$

Then:

$$
P(u_A | s_B, s_{B*}) = P(u_A | \bar{s_B}) + \text{delta} \cdot \text{support}
$$

Reformulating this makes it clearer:

$$
P(u_A | \bar{s_B}) + \text{delta} \cdot \text{support} = P(u_A | s_B) \cdot \text{support} + P(u_A | \bar{s_B})(1 - \text{support})
$$

There is a problem with this formula, namely:

$$
\text{support} \in (0, \infty)
$$

Thus...

$$
P(u_A | s_B, s_{B*}) \notin [0, 1]
$$

... which is a problem because it's supposed to be a probability.

We can fix this by reformulating the support as a fraction, rather than a ratio:

$$
\text{support} = \frac{P(u_B | s_{B*})}{P(u_B | s_{B*}) + P(u_B | \bar{s_{B*}})}
$$

