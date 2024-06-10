# Proposed Change to Scoring Formula

I think that we should change our scoring formula to calculate p not based on a single critical thread, but as a weighted average of all argument threads. Here is my reasoning:

## Scenario 1A: Unbalanced Voting

There are two "sides" of a debate. The three people from the pro side upvote some post, three people from the con side downvote it (I think this scenario could likely arise in many small group discussions).

On each side, there is one strong argument supporting that side's point of view. It gets upvoted by everyone on that side.

But initially people don't vote on the argument for the other side (people on the pro side don't vote on the argument for the con side, and visa versa.)

Now, given our current algorithm *both* arguments will have equal relative entropy. So it will arbitrarily choose one as the critical comment, and thus arbitrarily the informed probability will be either close to 0% or close to 100%.

This doesn't seem right. Intuitively, it seems like the informed probability should be 50%. 

## Scenario 1B: Asymmetric Unbalanced Voting

Now, suppose one person from the pro side votes on the strongest argument from the con side. But they do not change their vote. So now the informed tally for the con-side that argument is 1/4, while it is 3/3 for the pro-side argument.

Now the pro side has the advantage. The arguments from both sides look convincing, the con side argument looks less convincing. 

So the pro side will be the critical post, and the informed probability will be close to 1 (because of 3/3 informed tally). 

It seems correct that the pro side should have the advantage. But an informed probability close to 1 seems too high. Both sides have mostly informed votes. The pro side is only slightly more informed (because one person has voted on both).


## Proposed Solution: Weighted Average

Currently, the score is based entirely on the informed probability *given* the critical thread. I propose instead basing the score on a weighted average probability across all threads.

But we can use same *scoring* formula that we are using to choose the critical comment as the weight.

The current scoring formula for choosing the critical thread is:

	relative_entropy(p,q) * p_size

So comments get more weight if they are more convincing, and also if they have received more attention.

The result would be that, for scenario 1A above, p would be 50%, is it feels it should be. And for scenario 1B, p would still be above 50%, but not so close to 100%, since it would be a weighted average of the two informed probabilities. 

## Disadvantages

Suppose one initially-convincing argument against post A has already received a lot of attention and has been debunked by a counter argument. If someone then posts a duplicate argument that is also initially convincing, it will not become the critical comment until it has received enough attention, by which time (hopefully) somebody will have posted the corresponding convincing counter argument. With the new scoring formula, however, this argument will immediately have en effect (in the wrong direction).

A possible improvement might be to further weigh each argument not just be the amount of attention it has received, but also to factor in the amount of attention its replies have received. 

## Opposite Effects

This formula also produces better results in the case of two sibling comments with opposite effects. Suppose for example two siblings have equal but opposite effects, and an equal number of votes. With the old scoring formula, on of them would be arbitrarily chosen as the critical comment. With the proposed new scoring formula, the result would be a weighted average of the two.

Now in the case of sibling comments, we can't really know the combined effect unless there are users that comment on both. It could be that the two effects "cancel out". But it could also be that one "wins" and is convincing even given the other. For example, when discussing whether to go to Dino's for lunch, the argument B1 *Dinos is authentic Italian*, is trumped by B2 *Dino's is closed*).

It would be great if the algorithm could look at the combined effects of pairs of sibling comments and use that to calculate the informed probability. But even if it doesn't do so, the process should converge towards the right result. For example, suppose the initial vote on whether to go to lunch at Dino's is 50%:50%. But then B1 and B2 are equally convincing, but in the opposite direction. And suppose they receive an equal number of votes. So in the new algorithm, they would have equal weight, so the weighted average informed probability would also be 50%:50%.

But then somebody should come along and replies to B1 with the counter argument C1 *Dino's is closed* (a duplicate of or reference to B2), and people who consider C1 change their minds. Now, the thread B1=>C1 will be convincing in the opposite direction. That is, the votes of people who considered the thread B1=>C1 should be close to the votes of people who considered B2. So the informed probability for both threads will be the same, and they both will have high weight, and so the result will be correct.
