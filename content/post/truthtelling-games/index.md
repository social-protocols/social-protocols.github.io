---
layout: single
title:  "Truthtelling Games"
date:   2021-09-12 00:00:00 +0200
toc: true
toc_sticky: true
tags: ['Game Theory']
sidebar:
  - title: "In This Series"
    nav: "give-truth-the-advantage"
  - nav: "give-truth-the-advantage-related"
    title: "Related Articles"
# header:
#     teaser: /assets/images/decentralized-truth-wide.png
series: ['Game Theory in Social Media']
series_weight: 3
summary: "In this article, I will use game theory to explain why, under certain conditions, otherwise dishonest Internet people will behave with scrupulous honesty, and how social platforms can be intentionally engineered to create these conditions."
canonical_url: https://social-protocols.org/truthtelling-games/
author: Jonathan Warden
image: truthtelling-games.png

---

## How To Get People on the Internet to Tell the Truth

Everyone knows that you can't believe what you read on the Internet. That is, unless it comes from people you trust. 

Except...many of us also trust content from websites such as Wikipedia and Stack Overflow, which accept anonymous contributions from random people on the Internet. How can these sites consistently produce trusthworthy content from people who are not necessarily trustworthy? 

In this article, I will use [game theory](https://en.wikipedia.org/wiki/Game_theory) to explain why, under certain conditions, otherwise dishonest Internet people will behave with scrupulous honesty, and how social platforms can be intentionally engineered to create these conditions.


A striking example of where this has actually been done is blockchain. If you directly own cryptocurrency, the balance of your cryptocurrency wallet is stored in a ledger maintained by a group of anonymous people on the Internet. These people are not necessarily by nature very honest, and yet they always tell the truth about your wallet balance. Game theory can explain why they don't just take all your cryptocurrency for themselves.

Recent advances in game theory have gone even further, and have shown how to induce people to [truthfully reveal **subjective** information](https://deliberati.io/information-elicitation-mechanisms): that is, to reveal things that **only they know**, such as their favorite color, who they are going to vote for, etc.

In [The Law of Attention](/the-law-of-attention), I argue that game theory can actually be applied to the design of social media algorithms. This is tremendously significant, because game-theorists have proved that it is possible to get random people on the internet to tell the truth.  

If this is the first time you are reading this, it probably seems impossible. How can the algorithms know if people are telling the truth about something only they know? How can you stop people from lying if they are motivated to lie? I hope that after reading this and the following post you will understand how this is actually possible.

## Blockchain and Coordination Games


> Everyone wants to provide the correct answer because everyone expects that everyone else will provide the correct answer and the protocol encourages everyone to provide what everyone else provides.
> 
> -- Vitalik Buterin, [SchellingCoin: A Minimal-Trust Universal Data Feed](https://blog.ethereum.org/2014/03/28/schellingcoin-a-minimal-trust-universal-data-feed/)

In 2014 [Vitalik Buterin](https://en.wikipedia.org/wiki/Vitalik_Buterin) proposed a method for getting anonymous people on the internet to [tell the truth about simple facts](https://blog.ethereum.org/2014/03/28/schellingcoin-a-minimal-trust-universal-data-feed/). This basic method is now being used with remarkable success to reliably get facts such as stock prices and the results of sports games into blockchains. In fact, all [blockchain consensus protocols](https://www.investopedia.com/terms/c/consensus-mechanism-cryptocurrency.asp) are built on the same basic principle. 


The principle is one of the most basic ideas of game theory: there are situations where it is rational for people to do something just because other people are doing it. It is for example why you use your local currency and language, drive on the right (or left) side of the road, use standard weights and measures, etc. In game theory, such situations are called [**coordination games**](https://en.wikipedia.org/wiki/Coordination_game).

The trick to getting people to tell the truth is to create a coordination game where everybody wins if they all give the same answer, and everybody tells the truth because they expect everybody else to tell the truth.

A blockchain is essentially a decentralized bank based on a coordination game, where people report on each other's cryptocurrency balances, and every everybody wins if they report the same balances. But there are clearly defined rules for determining the balances, and so everyone knows what the "true" balances are. So everyone reports the true balances because they expect everyone else to report the true balances, and the rules reward people (with cryptocurrency) for doing what everybody else does.

## Multiple Equilibria

> On the one hand, you have a fork where the larger share of the internal currency is controlled by truth-tellers. On the other hand, you have a fork where the larger share is controlled by liars. Well, guess which of the two currencies has a higher price on the market?
>
> -- Vitalik Buterin, [The Subjectivity / Exploitability Tradeoff](https://blog.ethereum.org/2015/02/14/subjectivity-exploitability-tradeoff/), 2015

In game theory, a situation where everybody is doing what's best for themselves given what everybody else is doing called an [**equilibrium**](https://en.wikipedia.org/wiki/Nash_equilibrium). There are often many possible equilibria, because there are many possible sets of rules. But once a group gets themselves into some equilibrium, it can be very stable, because moving to a different equilibrium would require the participants not only to agree on a new set of rules, but also to trust that everyone else will actually switch to the new rules, since a single individual will lose out if they move but the majority doesn't. This can be a very difficult [collective action problem](https://en.wikipedia.org/wiki/Collective_action_problem). 

In fact, even if a majority of participants do coordinate a move, the consensus of the minority who continue to follow the original rules [will almost always be seen by society to be more legitimate](https://blog.ethereum.org/2015/02/14/subjectivity-exploitability-tradeoff/). So moving to a different equilibrium actually requires **society** to coordinate on recognizing a new set of rules. This **social consensus** is why [hard forks](https://www.investopedia.com/terms/h/hard-fork.asp) to improve the Bitcoin protocol have [almost never been successful](https://en.bitcoin.it/wiki/Block_size_limit_controversy), and why Bitcoin and other proof-of-work blockchains are secure even if [a small number of mining pools](https://bitcoinist.com/bitmain-51-percent-bitcoin-hashrate/) control the majority of bitcoin hashing power.

## Common Knowledge



> Most situations...provide some clue for coordinating behavior, some focal point for each person's expectation of what the other expects him to expect to be expected to do.
> 
> -- Thomas Schelling, the Strategy of Conflict


It is very easy to win a coordination game: you just have to successfully coordinate your actions with everyone else. But to do so, everyone must **know what everyone else is going to do**.

In a truthtelling game, everyone must know that everyone else is going to tell the truth, but this means they all must know and agree on what the truth is. And everybody must know that everyone knows this. The (perceived) truth must be [**common knowledge**](https://plato.stanford.edu/entries/common-knowledge/). 



## Coordinating on Subjective Truth

> ...the truth is arguably the most powerful Schelling point out there.
> 
> -- Vitalik Buterin, [SchellingCoin: A Minimal-Trust Universal Data Feed](https://blog.ethereum.org/2014/03/28/schellingcoin-a-minimal-trust-universal-data-feed/)



This is why blockchain consensus protocols are limited to situations where there are **unambiguous** rules[^1]. They also work for sufficiently objective facts, which is why the idea behind Buterin's Minimal-Trust Universal Data Feed is now the basis for many trustless blockchain [**oracles**](https://en.wikipedia.org/wiki/Blockchain_oracle#:~:text=A%20blockchain%20oracle%20is%20a,that%20decentralised%20knowledge%20is%20obtained.) which can be used to include facts about the "real world" into the state of the blockchain, such as [who won a sports game](https://www.coindesk.com/tech/2021/05/24/augur-adds-sports-betting-with-launch-of-polygon-based-augur-turbo/). As long as the fact is sufficiently uncontroversial and verifiable, people have no doubt how everyone expects everyone else to answer (the truth in this case is said to be a [focal point](https://en.wikipedia.org/wiki/Focal_point_\(game_theory\)), or Schelling Point). And so it is easy to coordinate on truthtelling.


## Coordinating on Objective Truth

> We have reached the third degree where we devote our intelligences to anticipating what average opinion expects the average opinion to be. And there are some, I believe, who practice the fourth, fifth and higher degrees.
> 
> --  Keynes, General Theory of Employment, Interest and Money, 1936


But it is not so easy to coordinate on an answer to subjective questions, such as "is the president doing a good job" or "do you like anchovies", where there is not one true answer. If participants can't get together to coordinate in advance, a subjective coordination game is a [Keyensian Beauty Contest](https://en.wikipedia.org/wiki/Keynesian_beauty_contest), where rather than voting based on their honest opinion, everyone tries to guess what everyone expects everyone else to do. It is still possible for people to coordinate on **some** piece of common knowledge -- for example popular opinion -- but conformity is not the same as honesty.


## Honest Auctions

However, game theorists have actually designed systems that elicit honest answers to **subjective** questions, where only the person answering the question knows the truth!

It started with auction design. In traditional auctions, you don't tell people the maximum price you are willing to pay, because if the seller knew for sure what your true price was, they could simply refuse to sell for a lower price.

But game-theorists showed us that you can design auctions so that rational people, if they are only concerned with maximizing their utility in the auction, will always reveal the maximum price they are willing to pay! For example, there is a type of auction called a [second-price sealed-bid auction](https://en.wikipedia.org/wiki/Vickrey_auction), where people write down a bid, seal it in an envelope, give it to the auctioneer. The winner is the highest bidder, but the price they pay is the **second** highest bid. A careful analysis of this mechanism shows that bidding any more or any less than your true price can only hurt you. A mechanism that forces a rational agent to private information such as their true price is said to be [incentive-compatible](https://en.wikipedia.org/wiki/Incentive_compatibility).

## Information Elicitation Mechanisms

Incentive-compatible auctions are impressive, but game-theorists have gone even further. Information Elicitation Without Verification (IEWV) mechanisms are **incentive-compatible surveys** where you pay participants for their answers to questions, and everybody's expected payout is maximized if they tell the truth --- **even for the personal, subjective, unverifiable questions**, such as *what is your favorite flavor of ice cream?* or *have you ever smoked weed?* In [Information Elicitation Without Verification](/information-elicitation-mechanisms), I provide a non-mathematical explanation for how these methods work.

Many of these survey games are also coordination games: truthtelling is the winning strategy only if everybody else tells the truth. These games sometimes have other possible equilibria, for example participants can coordinate on lying in certain ways, such as always reporting "blue". But coordinating on truthtelling often requires no more than knowing that at least one participant is scrupulously honest. 

## The Law of Attention

So to create social networks where people don't lie, the social network must be a coordination game. Now, a coordination game requires a **payout**. But people aren't paid for their participation in social networks.

Or are they? In [the law of attention](/the-law-of-attention), I argue that in social networks, people are effectively motivated by one and only one thing: **attention**. Regardless of their motives for seeking attention, be they commercial, political, or personal, all social networks will come to be dominated by agents behaving **as if** they are rational beings trying to maximize attention, because participants who don't behave this way will effectively stop participating. 

This means that, if a social network is designed as a coordination game where participants are paid in **attention**, then there will be an equilibrium on subjective honesty. Participants will maximize attention by telling the truth.

## Give Truth the Advantage

What does it mean to "tell the truth?" Colloquially it means **to say what one believes to be true**: to be honest. But this is not the same as speaking truth. **People can be honest and wrong.** 

[The Deliberative Poll](/the-deliberative-poll) describes a social media algorithm for promoting **informed** opinions. Combining a Truthelling Game and a Deliverative Poll addresses the problems of **dishonesty** and **ignorance**, and can result in online communities where the way to win attention is to post, share, and upvote content that reflects opinions people's honest and informed opinions. The result is a social network that promotes not just truthtelling, but **the truth**.

See more of our ideas for improving conversations on the internet on [social-protocols.org](https://social-protocols.org/).

[^1]: The rules of blockchains are complicated partly because common knowledge of the correct balance of an account requires common knowledge of the **order of transactions**. And although it's easy to prove that a transaction was authorized -- metaphorically, that a check was signed -- it's impossible to prove exactly **when**. But timing is critical because a check is no good unless there is enough money in the account, but this depends on which transactions happened previously. Once [Satoshi Nakamoto](https://en.wikipedia.org/wiki/Satoshi_Nakamoto#:~:text=Satoshi%20Nakamoto%20is%20the%20name,devised%20the%20first%20blockchain%20database.) solved this problem with a method for [objectively determining the order of transactions](https://bitcoin.org/bitcoin.pdf), it became possible to design a protocol where the **correct balance of each account was common knowledge**, and blockchains came into existence. 


<!--

<style>

.postscript {
  margin: auto;
  background-color: lightgrey;
  border: 1px solid black;
  max-width: 600px;
  padding-top: 1em;
  padding-bottom: 0px;
  padding-left: 1em;
  padding-right: 1em;
  margin-bottom:  1em;
}

.postscript h3 {
    margin-top: 0px;
}

</style>

-->





