# Calculation of Informed and Uninformed Tallies

## Background: Effects

One of the most important concepts in the GlobalBrain algorithm is the "effect" of a reply on a target. We use the term "target" to refer to the post being affected. A reply may be any reply in the reply tree for the target. The effect is how much more or likely users are to upvote the target (given they vote on it) given they have "considered" the reply.

### Definition of Consideration

There are (at least theoretically) different ways that users can be informed.
Our originally idea was that we consider a vote to be informed if the note
was shown below the post at the time the user voted on the post. But as
discussed in [this research note]
(https://github.com/social-protocols/internal-wiki/blob/main/pages/research-notes/2024-02-06-informed-probability.md),
the fact of actually voting on a note is probably a better for proxy for
whether the user has actually **considered** the note, which is really what
we care about when talking about users being "informed". 


### Defining Effects

To compute effects, we start by computing two vote tallies. First, the **informed tally** is the count of upvotes/downvotes among users who have considered the reply. Second, the **uninformed tally** is the count for users who have not considered the reply.

### Definition of Informed Tally

Defining the informed tally is fairly straightforward. We include the (latest) votes of users who have considered a reply in the informed tally. We say that a user has "considered" a reply if they have voted on it.

However, there are some nuanced rules to the way we calculate the informed tally.

#### Rule: Ordering Doesn't Matter

Whether the user votes on the target before or after voting on the reply, the
informed tally will always include their latest/final vote on the target, as
long as they have voted on the reply.

#### Rule: Clearing Votes

Since users can clear votes, users votes can become un-informed. The semantics
of voting and then clearing a vote should pretty much be the same as never
having voted. So both clearing a vote on the post and clearing a vote on the
note should result in the uninformed vote being cleared. 

If the user clears their vote on the note but leaves their vote on the post,
their vote should become uninformed and be included in the uninformed tally.

#### Rule: Implicit Consideration

We also say a user has considered a reply if they have voted on *any of its
descendants*. So for the thread A->B->C, if a user has voted on B, they have
implicitly considered B.

This further implies that user has considered a reply if they reply to it
(because their reply come with an automatic upvote).


### Uninformed Tally

The users who have not considered a reply are counted in the uninformed tally. 

#### Rule: Uninformed Tally Includes Users who are Informed of Parent

The first refinement to this rule is that, when computing the uninformed tally for a target/reply combination, we want to count users who have not voted on the reply, but have voted on the target, as well as *the parent of the reply*.

For example if we have thread A->B->C, the informed tally of target A and note C is includes the votes on A of users who are informed of B but not informed of C. 

It is necessary to compute the uninformed tally this way because the algorithm calculates the effect of C on A by by first calculating the partially informed probability *r*, which is the probability that a user upvotes A given they have considered B but not yet C. This partially informed probability *r* is the prior for calculating the informed probability *p*. That is, we start by calculating the effect of B on A, and make the prior assumption that C has no *additional* effect on A, beyond the effect of B on A. We then update our posterior based on the votes of users who have also considered C.

In fact, what we are calling the uninformed tally should probably be renamed to partially-informed tally.

#### Rule: Temporality

Defining the uninformed tally as the votes of users who have not considered the reply is ambiguous, because it doesn't take **time** into consideration. Do we mean the votes of users who have never considered the reply? Or the votes of users who had not considered the reply at the time they voted on the target?

## Counting Methods

So even given these rules, there are different methods for calculating informed and uninformed tallies.

### Method 1: No Temporality

The simplest method simply says that if a user has not (ever) voted on the reply, they are uninformed, and are thus counted in the uninformed tally. Otherwise, they are informed, and are thus counted in the informed tally.

#### Downside:

But this means we can't capture the information in an actual "changed mind". If a user sees a post, votes on it, then votes on the reply and also, being convinced by the reply, changes their vote on the post, we only count that user's final vote in the informed tally. We don't count their *previous*, uninformed vote in the uninformed tally. 

In other words, by Method 1, a user's vote is only included in one tally, even if they change their vote after becoming informed.

### Method 2: Uninformed Vote Shapshot

To count the votes of users who have changed their minds in the uninformed tally, we can take a "snapshot" of the user's vote on the target at the time they become informed of the reply. For example, if they upvote target A, then vote on reply B, their uninformed vote on A is now an upvote, and this can no longer change. If they change their vote on A to a downvote, the uninformed vote remains an upvote. Any subsequent changes to their vote on A only changes their informed vote.

#### Downside:

The problem here is that it makes the final tallies dependent on the order in which users depend to do things. This became clear in the simulations when we had many users all voting in the same way. 

Suppose initially 100 users upvote A, but then are are convinced by reply B. 
	- If they first all change their vote on A from an upvote to a downvote, and then they all vote on B, the uninformed tally will include 100 *downvotes*.
	- If they first vote on B, then change their vote on A from an upvote to a downvote, the uninformed tally will include 100 *upvotes*.

### Method 3

This is similar to Method 2, but the uninformed snapshot is taken at the time the reply is posted. So the uninformed tally includes users who either:

1. never voted on the reply
2. OR voted on the target *before* the reply was posted

This solves the ordering problem of Method 2. To understand why, consider the example of the 100 users above. When using Method 3 to calculate the uninformed tally, there are two possible scenarios:

- Scenario 1. If the 100 users upvote A *before* B is posted. In this case, their initial upvotes are included in the uninformed tally. Thus we have:

	- Informed Tally: 100 downvotes, 0 upvotes
	- Uninformed Tally: 0 downvotes, 100 upvotes

- Scenario 2. If the 100 users upvote A *after* B is posted, their initial upvotes are *not* included in the uninformed tally. Thus we have

	- Informed Tally: 100 downvotes, 0 upvotes
	- Uninformed Tally: 0 downvotes, 0 upvotes

Note that Scenario 2, when using Method 3 has the same results as when using Method 1. Each user is only counted once, and we don't capture any uninformed votes. However, in the best case, if some users vote on A before B is posted, we also capture data about uninformed votes.

#### Downside

The downside is that this is more complicated and confusing.


### Which Method?

Method 2 isn't an option because of its sensitivity to vote order. Method 1 is the simplest and most intuitive, but captures less information. Method 3 is more complex but captures more information.

Is the additional information worth the complexity?

#### Argument for Method 3: Small Team Scenario

Consider small teams where every user ultimately considers/votes on every reply. With Method 1, we can never measure if a vote actually changes minds -- we lose information about the informativeness of reply. On the other hand, Method 3 will capture many common small-team scenarios. 

For example, suppose there are only 2 users. The first user posts something, the second user downvotes the post and replies with a reason, and then the first user changes their vote. 

With all methods, the informed tally will be 0:2 (0 upvotes, 2 downvotes). The informed probability will be small. Let's say, for example's sake, that it is p=30%. 

With Method 1, the uninformed tally will be empty (0:0), since all users are informed. The uninformed probability will thus be equal to the prior. Suppose the prior is 50%, so q=50%. Then the relative entropy is DKL(30%, 50%).

But with Method 3, the uninformed tally will be 1:0 (1 upvote, 0 downvotes). The uninformed probability will thus be high. For example's sake, let's say that q=82.5%. The relative entropy is DKL(30%, 85%). 

So there is a big difference in how much relative entropy we measure between Method 1 and Method 3. With Method 3, we will thus be able to see more clearly that the post actually changed minds. This will be reflected in a higher uninformed upvote probability, and thus a larger relative entropy. 

In this case it will be a small difference with a lot of uncertainty. In larger groups it might be more significant.

#### Argument for Method 1

In addition to simplicity, an argument for Method 1 is the idea that there isn't as much value in measuring relative entropy (the difference between informed and uninformed upvote probability) unless there is in fact cognitive dissonance -- that is, unless there are in fact uninformed users. The relative entropy is used to score posts and send more attention to posts that are likely to change minds. But if every user is informed, there are no minds to change. So maybe Method 1 is sufficient.

## Double-Counting

An important thing to understand is that, using method 3 (and method 2), a
user can be double-counted. If 10 users vote on a post before the note is
posted, and then they all were later informed of the note, then both the
uninformed tally and the informed tally will have a sample size of 10. Even
though there are only 10 actual users.

On the other hand, it's possible for there to be no overlap, for example if 5
users voted on a post and were never informed of the note, and the other
fiver voted on the post only after being informed (they were never
uninformed).


