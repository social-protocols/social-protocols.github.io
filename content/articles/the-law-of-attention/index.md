---
layout: single
title:  "The Law of Attention"
date:   2021-09-13 00:00:00 +0200
toc: true
toc_sticky: true
tags: ['Game Theory']
sidebar:
  - title: "In This Series"
    nav: "give-truth-the-advantage"
  - nav: "give-truth-the-advantage-related"
    title: "Related Articles"
series: ['Game Theory in Social Media']
series_weight: 2
canonical_url: https://social-protocols.org/the-law-of-attention/
author: Jonathan Warden
image: law-of-attention.png
---

In this article, I argue that we can apply [game theory](https://en.wikipedia.org/wiki/Game_theory) to explain and control the behaviors that dominate in an online community. Not only can game theory explain why misinformation and abuse are so common in social platforms, it can be used to design social platforms that will be filled with honest, informed, civil, and behavior.


## Attention Games

> "If a tree falls in a forest and no one is around to hear it, does it make a sound?
> If content is distributed and no attention is paid to it, does it matter?"
>
> -- Aviv Ovadya and Luke Thorburn, [Bridging Systems, 2023](https://arxiv.org/pdf/2301.09976.pdf)


Social networks are games where people compete for attention. 

It's true that not everyone is motivated purely by attention. But if your posts are not seen by anybody else, then you are just shouting into the void. You will probably eventually give up and stop shouting. And if you don't, nobody will notice.

Like economists who model human beings as rational agents motivated by money, we can model participants on social platforms as rational agents motivated by attention. Although economic agents may be motivated by more than just money, those who don't acquire money eventually stop participating in the economy, because they run out of money to participate with. Likewise agents in social platforms who don't get attention effectively stop contributing to social platforms, because nobody is paying attention to them.

## The Law of Attention

In nature, an **an ecological niche will tend to be filled with individuals adapted to survive in it**. If I stop watering my garden, it will soon be filled with weeds. If I create an online community where, for whatever reason, the posts that get the most views are pictures of cats, my community will be filled with pictures of cats. And if I create a community that rewards trolling with attention, the community will come to be filled with trolls, and will [eventually die](https://www.lesswrong.com/posts/tscc3e5eujrsEeFN4/well-kept-gardens-die-by-pacifism), as has happened with [countless online communities in the past](https://www.gwern.net/docs/technology/2005-shirky-agroupisitsownworstenemy.pdf).

The Law of Attention says that **online communities will be filled with behaviors that are rewarded with attention.**

This means the people running a social platform can apparently control their users' behavior, simply by manipulating attention. But they are not necessarily **causing** this behavior. Rather, they are creating an environment where people who behave that way flourish, and people who don't behave that way leave. Just as when I stop watering my garden, my flowers don't turn into weeds: I create an environment where the weeds thrive, and my flowers die.

## The Attention Daemon

Attention-seeking is also common in the real world. So why are online communities **dominated** by attention-seeking behavior, while offline spaces are not? 

Because offline spaces don't have algorithms manipulating our attention.

A social network is like a giant room with thousands of people talking at once. Since you can't possibly listen to everyone, there is an invisible daemon in the room determining which voices you hear. And if the daemon decides you are not worth hearing, not only will you be muted, people won't even see that you are talking.

So the room is dominated by the voices of the few people who have figured out how to get the deamon to make their voices heard. The vast majority of people choose not to play the game, and remain silent (perhaps going to other other rooms where their contributions do receive attention). 

## Measuring Attention

<!--
[TODO: reference person who coined attention economy].
[todo: eher Roy Attention Networks]
-->

The algorithms of a social platform are the rules of the attention game, just as the laws of physics and biology are the rules of the game of life. They determine what content receives attention in users' feeds and notifications. The algorithms can show a given piece of content to millions of users, or none at all. 

While it's impossible to be sure what content users actually pay attention to, advertisers traditionally count the number of times a piece of content appears on a user's screen as a good proxy for attention. These **impressions** have value; that is why advertisers pay for them, and why online influencers make money. So impressions can be thought of as the currency of the social media attention game, and the value of this currency is what an advertiser would pay for these impressions in a free market.

The impressions metric lets us not only precisely measure how much attention each user receives, but also to precisely control it. And now that we have the ability to quantify and control attention, we have access to an extraordinarily powerful tool for influencing user behavior: game theory.

## Game Theory

Game theory is used to model human behavior as games where the players can take certain actions and receive payouts as a function of their own actions **and** the actions of other players. And we can mathematically analyze these games and prove things about them. For example, we can prove that there are **equilibria**, which are situations where everyone has adopted a strategy that is optimal for them, given the strategy everyone else has adopted. Rational people will remain in these equilibria unless they can somehow coordinate with others to move to another one (a collective action problem).

## Information Elicitation Mechanisms

One of the most astonishing things to come out of game theory are mechanisms for [Information Elicitation Without Verification](/information-elicitation-mechanisms): getting people to tell the truth where we can't verify their answers. These mechanisms can be thought of survey games, where people are paid to answer completely subjective questions such as "do you like anchovies" -- where the answer is impossible to objectively verify -- and these games have an equilibrium where everyone's payout-maximizing strategy is to **tell the truth!**.

In other words, game theorists have proven that when playing these games, participants **will tell the truth**, as long as the assumptions of the model hold: that users act as rational agents seeking to maximize attention. And if you accept the Law of Attention, then the users of the social platform *will* act as rational agents seeking to maximize attention. So if a social algorithm can be designed to couple the payout formula of these mechanisms with the attention rewarded to users (measured in normalized impressions), then the participants in this social network will only post, share, and upvote content that **honestly** reflects their beliefs and preferences.

## Improving Public Discourse

The Law of Attention is perhaps a presumptuous name. But assuming it is true gives us a basis for predicting how algorithms will influence behavior and what emergent dynamics will dominate in an online community. More importantly, it gives us a basis for **designing** social algorithms, using tools such as game theory, to promote not only honesty, but also civility, mutual understanding, and [informed opinions](/the-deliberative-poll). 

Since models are always approximations of reality, the outcomes may not always be what we hope for. But today's social network were not designed with any outcome in mind at all, except growth and profit. The shallow and toxic nature of social media is just an accident.

But society is capable of learning. New social networks have always periodically come along to replace the old. My hope is that the next generation of social platforms will be built more intentionally, designed not just for profit, but to make public discourse less polarizing, more honest, and more intelligent.

<!--
## Next in this Series: [The Deliberative Poll](/the-deliberative-poll)
-->
