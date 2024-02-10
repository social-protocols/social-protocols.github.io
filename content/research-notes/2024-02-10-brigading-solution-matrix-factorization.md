# Thoughts on "Brigading"

The community notes algorithm, doesn't solve the problem of "brigading", or the "self-selection problem."

But here's an idea how a variation of this algorithm could solve the problem.

Community notes *partially* solves the problem because it is insensitive to the relative numbers of left/right users. If there are already more right-wing users voting, having a "brigade" of right wing users vote even more on a targeted note won't make a difference. In fact, if some of those users have a positive common-ground factor, more votes only adds adds information that helps estimate how helpful the note is (e.g. brigading by left-wing users backfires if users, given they do vote, aren't even *more* likely to downvote the brigaded post then they are to downvote other right-wing posts).

What if the post is neither left-wing nor right-wing, and a group of right-wingers brigade it. Well the matrix factorization algorithm should end up identifying that post as left-wing or right-wing. So that scenario isn't an issue.

But what if the brigading is based on some other factor? For example, say Chevron wants to prevent bad publicity about their product. They cultivate a bunch of accounts with a high common-ground factor and low polarity factors. Then they downvote negative notes about their product and vice versa.

This should fool community notes (at least, the basic matrix-factorization based algorithm). Because pro-Chevron will look like common ground. This is because there won't be polarization in this dimension. There will only be users with a positive Chevron factor, but not a negative factor. Certainly, left-wing anti-corporation users will tend to be anti-Chevron, but *after factoring out the political polarity component*, there shouldn't be polarization on a Chevron dimension that's independent of the polarity dimension.

But what if we look at vote rate? The Chevron brigade will have a high vote rate for Chevron-related posts, both pro and anti. 

A 2-D matrix factorization of vote rates might find that vote rate can be well-estimated by a combination of the polarity factor and the Chevron factor. 

  Vote Rate ≈ intercept[post] + intercept[user] + polarity[post]*polarity[user] + chevron[post]*chevron[user]

The effect of the polarity factor will depend on the balance of right- and left-wing voters (not number of voters, but total frequency of voting). The Chevron factor will only increase vote rate for the Chevron brigade. So Chevron-brigade users will be over-represented in votes on Chevron posts.

If we are trying to correct for voteRate bias when estimating upvoteRate, we want to reduce the weight of the Chevron brigade. We can do this using a standard statistical adjustment (e.g. the back-door formula)

Causal Graph

  Y = upvote
  W = user factor (e.g. Chevron-brigade or not)
  X = user voted (true or false)

     W
   ↙   ↘ 
  X  →  Y


Back-door Adjustment formula:

  P(upvote|do(X)) = ∑_w P(upvote|X, W=w) * P(W=w)

Note on Back-Door adjustment formula:

  The back-door adjustment formula is just the law of total probability, but replacing P(W=w|X) with P(W=w). This results in the opinions of each group of users being weighted not in proportion to the number of votes, but to their representation in the population. Or in other words, it estimates the upvoteRate if no group was any more likely to vote than any other (if W were independent of X, or P(W=w|X) were equal to P(W=w) ). So if the Chevron brigade is only 1% of users, even if they are 90% of the the votes on some post, then their votes only get one percent of the weight.

  From a causal perspective, instead of asking "what is the probability of an upvote given they *did* vote", we ask "what is the probability of an upvote if we asked users to vote". This removes the self-selection bias. It gives us the same result as if we randomly selected users to vote and required them to vote.

Now, reducing the weight of the polarity factor makes little difference because the base community-notes algorithm already corrects for this. But it does make a big difference for the Chevron factor.

## Buterin's Comments on Brigading

From his article [What do I think about Community Notes](https://vitalik.eth.limo/general/2023/08/16/communitynotes.html), Vitalik Buterin comments:

> Of course, there is a totally different way in which this vote could have been manipulated: brigading. Someone who sees a note that they disapprove of could call upon a highly engaged community (or worse, a mass of fake accounts) to rate it NOT_HELPFUL, and it may not require that many votes to drop the note from being seen as "helpful" to being seen as "polarized". Properly minimizing the vulnerability of this algorithm to such coordinated attacks will require a lot more analysis and work. One possible improvement would be not allowing any user to vote on any note, but instead using the "For you" algorithmic feed to randomly allocate notes to raters, and only allow raters to rate those notes that they have been allocated to.

Randomly allocating notes to users is exactly what the back-door adjustment simulates.

## Adjusting for Polarity

It is probably not necessary to make this adjustment for polarity, because the core matrix factorization algorithm already makes this adjustment. In fact, if adjusting for polarity in this way produces the same results, maybe it would be better to *only* to a Matrix factorization on voteRate, and then do the above adjustment. It would be very interesting to do an experiment with this.

Oh but we don't want to adjust for the common-ground factor!

Perhaps, when doing the Matrix factorization for upvoteRates, we can include the factors for the vote rates and freeze them. Then the algorithm will only find factors that influence vote rates beyond the polarity and common-ground factor.

## Validating Approach

Definitely worth further research. One thing that could validate this approach is simulated data. Another is to see if adjusting for polarity using the back-door adjustment formula gives us the same result as the core algorithm.

Another would be to see if we detect "brigades" in the Community Notes dataset. There was one note where Elon Musk accused state actors of trying to manipulate community notes. Maybe this could validate that.

## Summary

So basically do a second matrix factorization to estimate vote rate (could their be like a Poisson-regression analog of Matrix factorization?) after running the core matrix-factorization algorithm. Do it on many dimensions to detect lots of different "brigades", or factors that bias vote rates. Then do the back-door adjustment formula on the vector W of vote rate factors. Boom!

## Misc Further Thoughts

### The "Political" Factor

In some forums, a post being "political" may be a factor that reduces vote rates, regardless of users politics. In others, it might increase vote rates. "Political" might be common ground when it comes to "relevance". This might be modeled by taking the absolute value of the polarity factor, and using that as a frozen factor in the matrix factorization for voteRate.

In a forum where political post tend to have a high vote rate, the adjustment formula will make the vote of the political crowd count less than those of the non-political crowd. This maybe is not good if the forum is explicitly about politics. But it probably makes no difference if the core algorithm has already adjusted for the effect of political polarity.





