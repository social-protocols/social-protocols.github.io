# Question Model

Here's a review of an idea we have had for adding questions to our model and the possible benefits.

## UI

A post can be a question, and the UI enforces that it is worded like a question. 

People can then upvote or downvote the question itself, and then they can separately upvote/downvote answers to the question. We can then produce separate scores for both the question and the answer. If the question is a yes/no question, we'd produce two informed probabilities: the upvote probability, and the agreement probability.

## Benefits

### Formal Claims

A question implies a claim (*is X true?* => *X is true*). So with this little bit of formality, we can quantity the level of agreement with claims. In the current algorithm, an upvote/downvote only tells us "I do(don't) want this to have attention", but we don't know if that reflects agreement, relevance, or informativeness of any claims made in the post. The question model lets us separate agreement on the claim from relevance/informativeness of the claim.

### Fact Checking

I think this is going to be important for a fact-checking site. For example, there may be questions that people from all across the political spectrum think are distasteful. "Does politician X have halitosis?" for example. So it may get a low upvote probability for being unhelpful after applying bridging-based ranking, even if people agree it's true. And yet a fact-checking website should not confuse bad taste with falsehood.

### Conversation Dynamics

But beyond fact checking, I think questions will have many other benefits:

- It allows people who disagree on the answer to agree on the relevance, helping to focus attention on relevant questions even if minds are not changed.

- In some conversations, I think simply **asking** a question about a post will be sufficient to change votes on the post. Maybe somebody posts "Inflation has gone down since this president took office." This post initially has a high upvote probability, and somebody responds by asking "Is the official CPI on today's date lower than it was on the day the president was sworn in?" Before the question, people upvoted it because they had some vague idea that people are saying the president has done something to lower inflation. Once the question is asked, it may cause them not only to doubt their assumptions, but to doubt their assumptions about the answers of other users. They now need to ask themselves "what does the CPI data actually say? Would people who have actually considered that question upvote this post?"

This gives users an alternative to posting some definite claim in the case they aren't sure. For example I might be 80% sure that the CPI data will disprove the claim in the post, but don't want to take the time to go find the numbers, and don't want to make a post claiming something I am not certain of. So I just ask a question. People who upvote the question may have similar doubts to my own, and so the informed probability may fall.

### Scaling Conversations

We can possibly use it to make the conversations scale better. For example, suppose the informed agreementProbability on the question is 90%. People who see the post also see the question as a note along with the agreement probability (90% agree the official CPI is lower...). Many people won't personally go check the CPI data and will assume that the answer is correct, and based on this the informed upvote probability of the post is also 90%. Then suppose somebody responds to the question with an actual link to official government CPI data showing CPI has increased, and the informed agreementProbability for the question falls to 10%. Now when people see the post, they see the question and the fact that only 10% agree that the official CPI is lower, and as a consequence the informed upvote probability also falls to 10%.

With this data, we can derive a full Bayesian model of users' joint beliefs about the post and the claim in the question. In this particular example, it's easy to extrapolate the $`P(upvote A|disagree B) ≈ 0%`$, and $`P(upvote A|agree B) ≈ 100%`$. If new information changes the informed probability $`P(B)`$`, we can use this (using Jeffrey's rule) to update the informed probability of $`P(A)`$. 

This completely decouples the conversation about B from the conversation about A. We don't need *anyone* who was in the discussion about B to also vote on A!