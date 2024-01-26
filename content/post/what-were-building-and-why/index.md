---
title: "What We Are Building and Why"
author: "Johannes Nakayama"
date: 2024-01-16
categories: ["social-network"]
tags: ["social-network"]
draft: true
---

# What We Are Building and Why

Social media and social networking platforms have created a global stage for discussion.
Platforms like Instagram, X (formerly Twitter), Facebook, TikTok, Snapchat, and many more are used to exchange information at an unprecedented scale.
The amount of information shared on these platforms is so large that they require algorithms that solve the problem of *information overload*.
These algorithms are called recommender systems.
While their objectives were benign in the beginning (directing users' attention to content that was relevant to them), the advertisement-driven business models of most social media companies have set incentives for these algorithms to optimize for different outcomes.
Most social media companies optimize for *user engagement* and their business models revolve around capturing as much attention as possible and selling it to advertisers.
At the global scale that these platforms achieve, the dynamics created by such a system can lead to emergent effects that deeply affect the world.

The problem is that what engages users the most is not *random*.
Humans seem to have natural proclivities to

a) align themselves with their peers and
b) direct attention towards (perceived) threats.

In the field of opinion dynamics research, the proclivity to align oneself with peers is called *homophily*.
This principle can be summarized as "the more similar two individuals are, the more likely it is that they become more similar".
If this principle and the proclivity to pay special attention to threats meet at scale, a natural environment is created for groups to form around commonly perceived threats and agreed-upon measures to alleviate them.

For almost any topic today, especially political ones, you can find two irreconcilable ideological groups that are on opposite sides of the argument.
The flow of information between them is severely impaired because the algorithms that govern their interactions do not provide any mechanism to resolve the conflict.
In fact, they are designed to achieve the opposite:
If the groups perceive each other as threats, they will pay more attention to one another on social media, and the algorithms will learn that this is the content to optimize for, leaving the users in a perpetual fight.
From the perspective of an ad-space provider who stands to profit from the attention spent on its platform, this is a huge win.
This is a big problem because resolving large-scale conflicts and exchanging information between groups with ideological differences - in our estimation - is exactly what is required to achieve progress on any particular issue.

We think of social media platforms as "meta-organisms":
They are collectives of humans connected by the Internet, with sensors and actuators in the world (the users) and rules of interaction that structure and govern the way that information is exchanged.
We call these sets of rules **social protocols**.
The social protocols of today's social media are inadvertent by-products of the incentives of the companies that built them.
When they were first built, it was not foreseeable what their unintended consequences would be.
Today, even with the benefit of hindsight, we can still barely understand them, but at least we know that they exist.
We want to design a social protocol that makes the "meta-organism" that we create *intelligent*.
Or in other words, we want to create **collective intelligence**.

At the core of this endeavour is attention.
Attention is at the cross-roads of all system constituents on a social networking platform.
What users pay attention to will affect the way they act in the world and the way they perceive the world, which in turn affects what they feed back into the system, which will change the way other users perceive and interact with the world... and so on.
We believe that attention is a supremely powerful resource that could be made much better use of than be treated as a commodity that can be sold to advertisers.

The core idea behind the platform we are trying to build is to **direct attention to content that changes users' minds**.
Changing one's mind, in a Bayesian sense, means to obtain new, previously unknown information, and updating one's beliefs accordingly.
We believe that optimizing for belief updates will enable distributed Bayesian reasoning, making the network as a whole more intelligent than the sum of its parts, i.e. the users.

