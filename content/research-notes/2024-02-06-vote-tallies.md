# Computing Vote Tallies 


The calculation of informed/uninformed upvote probabilities requires tallies of the total number of upvotes and downvotes among users that have/have not been exposed to the note in various ways.

This is tricky because it requires either keeping track of state for each user/post/note combination. If the user changes their vote on a post, we need to upvote tallies considering whether that user was shown the note when they voted, whether they have already voted on the note, and whether they vote on the note after voting on the post.

This can all be done with SQL views but these are complicated, slow, and hard to understand. Instead we use triggers, which are also complicated and hard to understand but at least much faster.

## Proposed Solution:

### UninformedVote and InformedVote

We start with the voteHistory table, which includes every vote, and info on whether a note was shown on the post when the vote occurred. The vote history includes changes to votes.

We then create two tables that keep track of the current state for a user/tag/post/note combination: uninformedVote and informedVote. uninformedVote tells us, for each post note/user combination if the user has voted on the post, but **not** voted on the note. That is, it tells us if there are votes on posts where users are uninformed of one or more notes for that post. The vote field of this table is the current/latest vote on the post: it tells us the current vote on the post as long as this user is uninformed of the note. Once the user becomes informed, this value no longer changes.

informedVote keeps track of the latest vote for a user on a post given they have been exposed to some note in some way. The eventType column (which is part of the primary key) tells us how the user was exposed to the note. It can currently takes values 1 for "shown note while voted" and 2 for "voted on note". 

But currently, I think it would be better to try to simplify the code by not trying to deal with different type of events. Instead, for now just focus
on votes on post given voted on note. But since we already have code for both types of events I won't remove it.

The vote column also keeps track of the latest value of the vote on the post given the event. 

uninformedVote and informedVote and updated using a trigger on inserts/updates to voteHistory.

### uninformedTally and informedTally

We then aggregate the votes in informedTally. This is a bit simpler and the code is more self explanatory.

To compute the uninformedTally used to calculate q, we need to add up the tally's for users that were never exposed to the note, to the 'beforeNote' tallies that give us users votes before they were exposed to the note.

We do this calculation to create the detailedStats view which puts the stats in the form needed by the algorithm

## Scenarios

Below are some scenarios and the proposed outcome for these scenarios.

- User hasn't voted on post then is shown post with note 
	- and votes: insert record in informedVote
	- and doesn't vote: do nothing. We aren't counting "being shown note" alone as an event. Only "voting on post while note is shown."

- User has voted on post then is shown post with note 
	- and changes vote on post: update informedVote record
   	- and doesn't change vote on post: do nothing

- User votes on post then votes on note 
	- insert informedVote record. As mentioned above, this record should contain the same result whether the user voted on the note before or after the post.
   	- and then changes vote on post: Update the informedVote record with latest vote on post

- User votes on note then votes on post
	- insert informedVote record.
   	- and then changes vote on post: Update the informedVote record with latest vote on post

Tricky Scenarios:

- User votes on post while being shown note, then changes vote while **not** being shown note. What happens? 
  	- It should change the value of vote in the informedVote record. The informedVote record should be the latest value of the vote on the post given the event occurred. And for us the event is that the user voted on the post while the note was shown. 

- User votes on post having voted on note. Then clears vote on note. 
	- On the one hand, the informedStats record should remain unchanged, because the event happened: the user considered the note (just changed their mind about the vote)
	- On the other hand, should not clearing a vote act as a proper undo? Users assume that vote that they undo has no consequences. 

- User votes on note having voted on post. Then clears vote on note. 
	- I guess the same as above. It seems more likely on this case that the vote was just an accident...

- User votes on post given voted on note. Then votes on post given shown note! 
	- Here we will insert two event records. They will both have the same value of vote. Do we even need a value of vote in these records?
	- So both events will have the same value. So they will both be included in the count/total for the tally for both event types. 
	- But we don't have a tally for the combined event. So we can't just subtract tallies.
	- So if we want tally given shown note only, how do we calculate?

What if the user votes on the post **then** votes on the note? If the user doesn't then subsequently change their vote on the post, then the end result is the same whether the vote on the note happened before or after the vote on the post. So we should insert or update a record with eventType 2 both when the user votes on a post having already voted on a note, or vice versa.



## Open Questions 

### Adjusting for Selection Bias in Votes on Note

When we calculate P(upvote post|voted on note), we introduce a voter bias. The calculation of P(upvote post|shown note) doesn't have this bias because users do not decide what note they are shown. However, users do decide what notes to vote on. Probably, a user who downvotes a post is more likely to vote on a note that opposes the post. However, we can adjust for this. So for example if a post has an upvoteProbability of say 90%, but of users who voted on the note, only 40% upvoted the post (60% downvoted the post), we know there is a bias (users who downvoted the post are more likely to vote on the note) and can adjust for it using a standard adjustment formula.


### Combining "Shown Note" and "Voted on Note" Signals

If we have both signals (vote while shown note, vote on post with vote on
note), we can combine them in some way to calculate the probability of an
upvote on the post given user has/has not been exposed to the note. I have
thought that this should be a Bayesian average with one being the prior to
the other, but now that I think of it I'm not sure this is justified by our
causal assumptions. How should these signals be combined? What are we trying
to measure? The potential effect of the information on the vote. But the
effect of this information theoretically depends on how much the
user has paid attention to it. Presumably, if the user has voted on the note,
it indicates they have paid more attention to it than if they have only been
shown it (because they may not even have read it). So the magnitude of the
effect on votes (the diff between p and q) should be higher in one case than
the other. Using one as the prior for the other doesn't seem right. If a user
is shown the note AND vote on the note it indicates even more attention paid.
And then generalizing, just showing the note in the feed (as an attachment to
the post or directly) gives us an expectation that the user has paid some
amount of attention. 

Also, we expect the magnitude of the vote change to be different depending on whether 
user has already voted on post.


### Count Replies as Votes

In a sense, a reply is an implicit upvote? Or e different type of signal. But
definitely if a user has replied it indicates they have paid attention to the
post.
