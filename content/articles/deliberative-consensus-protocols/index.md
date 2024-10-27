---
layout: single
title:  "Deliberative Consensus Protocols"
date:   2024-04-05
toc: true
weight: 1 
toc_sticky: true
image: deliberative-consensus-protocol.png
canonical_url: https://social-protocols.org/deliberative-consensus-protocols
author: Jonathan Warden

---

## Introduction: Scalable Group Decision-Making

A **deliberative consensus protocol** is a process that online groups can use to make decisions. It's designed to produce *good* decisions that are fair and manifest the collective intelligence of the group. And it's designed to work at scale.

This is not easy. Once a group gets large enough, people will start trying to manipulate the results. And even if everyone acts in good faith, it is hard for a large group to agree even on basic facts, let alone optimal decisions. And even if people agree on the facts, they may have vastly different values and preferences.

And yet we think that **intelligent group decision-making can scale with the right process**.


<!--
But the fact that large groups often don't make good decisions doesn't mean they *can't*. Often, the key might simply be the **process**.
-->

<!--
A deliberative consensus protocol is like a blockchain consensus protocol, which uses game theory to produce consensus on questions of fact even in the face of bad-faith, manipulative behavior. But unlike a blockchain protocol, which online works for uncontroversial facts for which there is no honest disagreement, a deliberative consensus protocol works even when there is disagreement, using a **deliberative process** to discover the **honest and informed consensus**, and an unbiased machine learning algorithm. Finally, it **debiases** the results using an unsupervised machine-learning algorithm similar to the one used by X's Community Notes.

A deliberative consensus protocol is like a blockchain consensus protocol in that induces users to give **honest** answers (e.g. about the true state of the blockchain). But instead of depending on unanimous agreement on uncontroversial facts, it does not punish disagreement. Instead, it rewards users for (anonymously) giving **honest opinion**. It then uses a **deliberative process** to determine an **informed and unbiased consensus**.

-->

A deliberative consensus protocol is like a blockchain consensus protocol, which induces users to give **honest** answers to questions of sufficiently uncontroversial facts (such as the state of the blockchain). But unlike a blockchain consensus protocol, which only works when there is no honest disagreement about the correct answer, a deliberative consensus protocol does not punish disagreement. Instead, it elicits **honest opinions**. It then uses a **deliberative process** to discover the most **informed and unbiased opinion** of the group.

Although it is *like* a blockchain consensus protocol, a deliberative consensus protocol does not require a blockchain. It is meant to be used anywhere an online group needs to make decisions: governance of open-source projects and DAOs, direct democracy, open fact-checking and peer review, moderating online forums, or improving social-media ranking algorithms to combat misinformation.

<!--
Instead of using cryptocurrency as a reward system, a deliberative consensus protocol can reward users with **attention**. This produces a game-theoretic equilibrium where the users with the most influence on the platform are those who consistently vote according to their honest opinions given the information that has been shared with them by other users. 
-->


## Fair Decisions

Blockchain protocols consistently (and amazingly) produce a consensus on the *truth* when it comes to questions of unambiguous, uncontroversial fact. For an intuition of just how this miracle occurs, read my essay on [Truthtelling Games](/truthtelling-games). 

Unfortunately, no protocol can consistently give us the "truth" when the facts are uncertain or subjective, or when values or preferences conflict. The best we can do is try to create a protocol that produces the **most fair** decision.

What constitutes a fair decision? Well, let's consider some examples of unfair decisions. In a criminal trial, if exculpatory evidence is withheld, that's unfair. If the jurors are bribed to not give their honest opinion, that's unfair. And if the jury isn't representative of the defendant's peers, that's also unfair. 

So I would propose that a *fair* trail would be one that discovers the 1) **honest** and 2) **fully-informed** opinion of an 3) **unbiased** jury.

This is what a deliberative consensus protocol is designed to do. It uses a deliberative process to estimate what an **unbiased** sample of the group would **honestly** believe after they have considered all the information and arguments shared by all other users.

To accomplish this, the protocol uses three different technologies, that correct in turn for 1) **dishonesty**, 2) **ignorance**, and 3) **bias**.

## 1) Correcting for Dishonesty using Game Theory

First, to address the problem of **dishonesty** and coordinated manipulation, a deliberative consensus protocol can use game-theoretical mechanisms such as the [**Bayesian truth serum**](https://nel.mit.edu/bayesian-truth-serum/). BTS is an extraordinary mechanism (developed at MIT) that rewards users for giving honest answers *even if users believe that most people disagree with them*.

To make these game-theoretical mechanisms work, there must be some sort of **payout**. If a deliberative consensus protocol is not a blockchain protocol, and the payout is not cryptocurrency, then what is the payout?

As I argue in [The Law Of Attention](/the-law-of-attention), there is one and only one thing that effectively motives behavior of social platforms, and that is **influence**, which is mediated by **attention**. If nobody pays any attention to your posts in an online platform, there is no point in posting. If your votes have no effect on what posts get attention, there is no point in voting. So all participants in social platforms, whether their motives are financial, political, personal, or selfless, can be treated as if they were motivated entirely by attention.

An online platform can use some sort of **reputation** system to determine how much attention users can command on the platform. Instead of building a follower count, users would need to build their reputation score in order to have "reach" on the platform. 

A protocol can then use reputation as the payout currency. So users need to consistently vote honestly in order for their votes to have any weight.

This makes it possible to fully employ the tools of game theory and mechanism design to engineer a protocol that creates an equilibrium where everyone is motivated to answers honestly in order to have influence on the platform, because they expect other users to do the same.

## 2) Correcting for Ignorance using Deliberation

Second, to address the problem of **ignorance**, a deliberative consensus protocol can use an algorithm such as the [**Global Brain Algorithm**](https://social-protocols.org/global-brain/) to curate conversations that discover the most convincing arguments on each side of a question, and estimate the opinion of users who have considered all the most convincing arguments. 

The global brain algorithm works by analyzing a threaded conversation tree and considering the upvotes and downvotes on each comment, depending on *who has seen what other comments before they voted*. It then filters and ranks comments to influence how much attention each receives, in order to deepen the most informed conversation threads while pruning uninformative threads that do not effect voting behavior. 

The integration of a truthtelling protocol such as the Bayesian Truth Serum with a deliberative protocol such as the Global Brain Algorithm can produce an equilibrium at **informed honesty**, where users maximize their influence on the platform by voting according to their *honest opinion given the information that has been shown to them*.

This is the opposite of the effect of many social media algorithms, which create an equilibrium on **dishonest conformity**: where people are rewarded for posts that are easily recognized as conforming to the biases and dogmas of the group, even if that requires ignoring nuance and reason.

## 3) Correcting for Bias using Machine Learning

However, even if all members of a group are honest and informed of the most convincing information and arguments posted by other users, the result will still depend on who you ask, because people have different core values, belief systems, and preferences. And because participation in online discussions is necessarily optional, votes will often be a biased sample of the opinions of the group.

To address this problem of **self-selection bias**, an unsupervised machine-learning algorithm can be used discover latent factors that predictably affect users' votes, and adjust for these biases so that the results are representative of the overall opinions of the group. A similar algorithm is used by X's [Community Notes](https://communitynotes.x.com/guide/en/about/introduction) to correct for political bias.


## Summary


In one sense, the problem of democracy is one of scalable group decision-making. A deliberative consensus protocol does not solve all the problems of group decision-making. The vast field of social choice theory deals with the challenges of  designing fair democratic voting mechanisms when there are conflicting goals and preferences. But a deliberative consensus protocol can enhanced online group decision-making processes by more effectively distributing information and producing a decision that best represents the collective intelligence of the group.

But the greatest potential of these protocols may simply be the improvement in discourse. In a sense, the most important decision for any group to make is [*how to allocate their attention*](/what-deserves-our-attention). In any online discussion platform, a deliberative consensus protocol can be used to focus attention on the most informative conversation threads and on comments that stand up to scrutiny, thereby promoting deep, honest, informed, and intelligent conversations.

We are currently working on a concrete implementation of a deliberative consensus protocol in [Jabble](https://github.com/social-protocols/jabble?tab=readme-ov-file#jabble-better-online-conversations).




