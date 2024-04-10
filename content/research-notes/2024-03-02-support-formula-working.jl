




To understand this intuitively, I assume that users only upvote B if they think Z is true. So, for the users that change their vote after considering B, B=1 and Z=1. So for example in the first scenario for the last post, 44 out of 100 users changed their votes after considering B. For these users, B=1 and Z=1. 10 users 


That is, B=1 implies Z=1. So P(A=1|Z=1) = P(A=1|B=1).



Further they will only change their mind about A if Z is new information -- that is, if they previously believed Z=0. So 




### Assumption: B=1 implies Z=1. Upvote implies agreement

Disagreement implies Downvote

If we assume an upvote implies agreement, then P(B=1|Z=0) = 0












### Discussion


  a2 - a0 = q(y2 - y0) 
          = qrλ(z2 - z0)
          = qλ(b2 - b0)
          = qλ(b2 - b0) = A2
  qλ = (a2 - a0)/(b2 - b0)





What a sec, the sequences is
  seeing A (V) causes 
    Y to move from y0 to y1
      A to move from a0 to a1
        a1 - a0 = q(y1 - y0)
  seeing B (W) cuases
    Z to move from z1 to z2 (z started at z1, corresponding to Y1)
      B to move from b0 to b1
        b0 = rz1 + zi
        b1 = rz2 + zi
        b1 - b0 = r(z2-z1)
      Y to move from y1 to y2
        y2-y1 = rλ(z2-z1)
        A to move from a1 to a2
          a2-a1 = q(y2-y1)
                  = qrλ(z2-z1)
                  = qλ(b1-b0)
  seeing C (X) causes
    Z to move from z2 to z3
    B to move from b1 to b2
      b2 - b1 - r(z3-z2)
    Y to move from y2 to y3
      y3-y2 = rλ(z3-z2)
      A to move from a2 to a3
      a3-a2 = q(y3-y2)
            = qrλ(z3-z2)
            = qλ(b2-b1)






if the probability of Z increases by ΔZ percentage points, B change by r × ΔZ, and Y changes by λr × ΔZ.



b2 - b1 = r(z2 - z1)
y2 - y1 = rλ(z2 - z1)
a2 - a1 = q(y2 - y1) 
        = qrλ(z2 - z1)
        = qλ(b2 - b1)
qλ = (a2 - a1)/(b2 - b1)


b1 - b0 = r(z1 - z0)
y1 - y0 = rλ(z1 - z0)
a1 - a0 = q(y1 - y0) 
        = qrλ(z1 - z0)
        = qλ(b1 - b0)
        = qλ(b1 - b0) = A1
qλ = (a1 - a0)/(b1 - b0)


a2 - a0 = q(y2 - y0) 
        = qrλ(z2 - z0)
        = qλ(b2 - b0)
        = qλ(b2 - b0) = A2
qλ = (a2 - a0)/(b2 - b0)

(a2 - a0)/(b2 - b0) = (a1 - a0)/(b1 - b0)
(a2 - a0) = (a1 - a0)(b2 - b0)/(b1 - b0)

# This formula
a2 = a0 + (a1 - a0)(b2 - b0)/(b1 - b0)

b2 - b0 = ( (b2 - b1) + (b1 - b0) )

a2 = a0 + (a1 - a0)( (b2 - b1) + (b1 - b0) )/(b1 - b0)

a2 = a0 + (a1 - a0)( (b2 - b1)/(b1 - b0) + 1 ) 
a2 = a0 + (a1 - a0)( (b2 - b1)/(b1 - rz0) + 1 ) 



How does this fit my intuition? that if w cut the number of people who support B in half, we cut the numbe rof people who support A in half?

Because cutting B in half would require Moving B from B1 to B1/2, which may be below B0. But above Bint. Implyig zimilar move with z.


What a sec, the sequences is
  seeing A (V) causes 
    Y to move from y0 to y1
      A to move from a0 to a1
        a1 - a0 = q(y1 - y0)
  seeing B (W) cuases
    Z to move from z1 to z2 (z started at z1, corresponding to Y1)
      B to move from b0 to b1
        b0 = rz1 + zi
        b1 = rz2 + zi
        b1 - b0 = r(z2-z1)
      Y to move from y1 to y2
        y2-y1 = rλ(z2-z1)
        A to move from a1 to a2
          a2-a1 = q(y2-y1)
                  = qrλ(z2-z1)
                  = qλ(b1-b0)
  seeing C (X) causes
    Z to move from z2 to z3
    B to move from b1 to b2
      b2 - b1 - r(z3-z2)
    Y to move from y2 to y3
      y3-y2 = rλ(z3-z2)
      A to move from a2 to a3
      a3-a2 = q(y3-y2)
            = qrλ(z3-z2)
            = qλ(b2-b1)

      qλ = a3-a2 /  (b2-b1)
      qλ = a2-a1 / (b1-b0)

      a3-a2 = (a2-a1)(b2-b1)/(b1-b0)

      # this formula
      a3 = a2 + (a2-a1)(b2-b1)/(b1-b0)

      because qλ < 1
      a2-a1<b1-b0
      a3-a2<b2-b1

      (a2-a1)-b1 < -b0
      b1-(a2-a1) > b0
      b0 < b1-(a2-a1)
      b0 < .55

      a3<(b2-b1)+a2
      a3 < (.5-.99)+.9
      a3 < .44+.9

  b1 is .99
  b2 = .5
  b2 - b1 = .5 - .99 = 0.59
  b1-b0 = 

so if b0 is .55

    a3 = .9 + .44*(-.49)/(.99-.55)
       = .41

  if b0 is 0


    a3 = .9 + .44*(-.49)/(.99)
       - .682




so we see two effects on Z: W, and X

we also know the starting point of z at z1 corresponding to a1

effect on a = rqλ * effect on z = qλ * effect on B

so we see effect on B and affect on A, that tells us qλ? no because we do't know B0

if we know qlambda, we know b1 - b0

so we have the 44 = 90 - 46 = q(y2 - y1) = qrλ(z2 - z1) = qλ(b1-b0)


b1 is 99% 

But we have bounds q is less than 1, lambda is less than 1

b1 - b0 < y2 - y1
b1 - b0 < 44
b1 - 44 < b0
99 - 44 < b0
55 < b0




we observe
  b1 (after W)
  b2 (after X)

  a0 (after V)
  a1 (after b1 after W)

  want to guess a2



-----

Okay thinking through this more. If users upvote B, it means they must agree with Z. Further, if they change their vote, it means Z is relevant.

Can we say P(A|Z) is equal to P(A|B)??? Well yes, because B implies Z. If they upvote B it means they accepted Z. It's true there might be reasons not for them to upvote B, including that they think Z is not relevant. NO matter, if they do upvote, they have accepted Z and think it is relevant (but not necessarily relevant to Y).

z2 = 1
So we know P(A|Z=1). We also know P(A|Z=z1). We know P(B|Z=1) an P(B|Z=z1)


now considering C changes P(B) and also changes P(A). Now, it will only change votes on A among users who no longer believe Z.

So walk through an example. 46% upvote A. 99% people upvote B. After that, 90% upvote A. What percentage of the people that upvote B agree with A? Approx 90%, I guess.

It could be 90 agree with B and upvote A, 9 agree with B and downvote A, and 1 disagree with B and downvote A. But the one who disagreed with B could upvote A. So there is the wildcard.

Anyway, P(A|upvote B) = P(A|Z) is 90%.

and P(A|not considered B) is 46%

so if people considered B
  99% chance they agree with z
    90/99 chance they upvote A
    9/99 downvote A
  1% they disagree with Z
    100% chance they downvote A

Now of the 90 that agree with Z and upvote A, 90-46 must not have known Z (or thought Z was unlikely). But 46 either already knew Z, or agree with A regardless.
  but not quite. We say P(A|Z) is only 90%. So at most 90% of the 46 who already upvoted A knew Z.

    wait a sec, that's backwards. Up to 46/.9 = 51.1 people knew Z, resulting in 51.1*.9 = 46 upvotes 

    so 48.8 didn't know Z. And of those, none upvoted.
  What if 0% of the 46 who already upvoted knew Z? 
    Then P(A|notZ) is 46/100?

So we have established that P(A|not Z) is between 0% and 46%.

Okay then what. Post C comes along. P(B) drops from 99% to 50%.

What does this tell us about Z? About A? About the relationship between Z and A?


Okay the people that change their mind about B considering C may or may not have upvoted A.

If people changed their vote on A after seeing/upvoting B and then downvote B, we guess they should downvote A.


But aren't we assuming that it is only people who agree with B that change their mind about A?

So we have a specific cohort of people, 44 to be precise, that saw B, changed their mind about Z, upvoted B.
  all 44 changed their minds about Z

if these people see something that makes them reject Z, they would change their upvote on B, and change their mind back.  

groups
  group 1: 44 people
    prior
      Z=0
      A=0
    posterior
      Z=1
      A=1

  max scenario. Prior Z=1 is 51.1
    group 2: prior Z=1.
      group 2a: 46
        prior
          Z=1
          A=1
        posterior
          Z=1
          A=1
      group 2b: 5.5
        prior
          Z=1
          A=0
        posterior:
          Z=1
          A=0
      group 3: prior Z=0
        0
    in this scenario, what can we say if people change their mind about Z?
  min scenario: Prior Z=1 = 0
    group 2: prior Z=1
      0
    group 3: prior Z=0
      group 3a: 5.5 to 46
        prior
          Z=0
          A=1
        posterior:

      group 3b: 5.5 to 46
        prior
          Z=0
          A=0
  group 4: 1 person
    prior
      Z=0
      A=0
    posterior
      Z=0
      A=0


So our simple formula gives a *mininum* for the effect of C on A. There could be some prior number of people who agree with Z, in which case the effect will be even larger!

If P(A|not Z) is between 0 and 46%, then if Z falls to Zero, P(A) falls to as
low as zero, but as high as 46%.



   cnt(upvote A,accept Z) = 44
   cnt(upvote A,not accept Z) = 4.6 to 46
   cnt(downvote A,accept Z) = 9 to 47.2 
   cnt(downvote A,not accept Z) = 1

If cnt (upvote A,not accept Z) is 46, then
  reducing acceptance of Z only effects the 44 who changed their vote.
  the 46 who upvoted A regardless of Z don't change their vote
If cnt (upvote A,not accept Z) is 4.6










of people who didn't conisider B
  up to 58.6 knew Z
    4.6 upvoted A
    54 downvoted A
    meaning 41.4 didn't know z
      and none upvoted A
      and P(A|not Z) = 0
  as little as 0 knew Z
    46 upvoted A
    54 downvoted A
    so
      P(A|not Z) = 46/100 = 46%












# Here we want to validate the support-based formula for estimating P(A|voted on C), where C is a subnote (note on a note on A).
# The support formula is based on the following reasoning:
#    - If B changed minds about A, the people who changed their minds are people who **agree with B**.
#    - If subnote C decreases percentage of people who agree with B by X%, it should also decrease # of people who changed minds on A by X%
#    - In other words, C decreases the **effect** of B on A, in proportion to its effect on B.


### Scenario 1

Suppose 99% of people believe B, but C reduces that to 50%

	P(B|not sC) = 99%
	P(B|sC) = 50%

Suppose 46% of people believe A, but B increases that to 90%

	P(A|not sB) = 46%
	P(A|sB) = 90%

### Define

X≈50% is percent effect of C on B

	X = (99 - 50)/99 ≈ 50% 
	  = ( P(B|not sC) - P(B|sC) ) / P(B|not sC)
      = 1 - P(B|sC) / P(B|not sC)

if we define support as simply

	S(B,sC) = P(P|sC) / P(B|not sC)

Then
	X = 1 - S(B,sC)

Let's define the effect of B on A as:

	E(A,sB) 
	= P(A|sB) - P(A|not sB)
	= 90% - 46% 
	= 44%

### Proposed Formula: First Draft

We have established that C makes people roughly half as likely to upvote B. So we estimate that C reduces the effect of B on A to:

	44% * (.5/.99)% ≈ 22%

Working out the formula in detail:

	E(A,sB) = P(A|sB) - P(A|not sB)

	P(A|sB, sC) = P(A|not SB) + E(A,sB)*X
			    = P(A|not SB) + (P(A|sB) - P(A|not sB))*(1 - S(B,sC))
			    = P(A|not SB) + (P(A|sB) - P(A|not sB))*(1 - S(B,sC))
			    = P(A|not SB) + P(A|sB) - P(A|sB)*S(B,sC) - P(A|not sB) + P(A|not sB) * S(B,sC)
			    = P(A|sB) - P(A|sB)*S(B,sC) + P(A|not sB) * S(B,sC)
			    = P(A|sB)[ 1 - S(B, sC) ] + P(A|not sB) * S(B,sC)
			    = P(A|sB) + S(B,sC) * (P(A|not sB) -  P(A|sB))
			    = P(A|sB) - S(B,sC) * (P(A|sB) - P(A|not sB))
			    = P(A|sB) - S(B,sC) * E(A,sB)
			    = P(A|not sB) + S(B,sC) * E(A,sB)

So in the above example
	P(A|sB, sC) = 
			    .9 - .5 * (.9 - .46) = .9 - .22 = .68
			    .46 + .5 * (.9 - .46) = .46 + .22 = .68

## Problem: Probabilities greater outside of 0-100% ranage.

### SCenario 2

Suppose the effect of C on B is oppose direction

	P(B|not sC) = 0.01
	P(B|sC) = .99

S(B, sC) = .99/.1

So people are 90x as likely to agree with B if they see C.

But this is impossible. If 44% percent changed their minds when they saw B, then seeing C would increase this to 44% * 99 = 4356% 

So our latest assumptions here are not compatible. If only 1% of people originally agreed with B, B wouldn't have caused 49% of people to change their minds.

So we can look at the effect of *upvoting* B. Let's say B=0 is no vote, B=-1 is downvote, and B=1 is upvote.

    P(A|not upvote B) + S(B,sC) * E(A,upvote B)

	= P(A|B != 1) + E(A,B=1)*S(B=1,sC)
	= P(A|B != 1) + (P(A|B = 1) - P(A|B != 1))*S(B=1,sC)

So back to scenario 1
	P(A|B=0) = 46%
	P(A|B!=0) = 90%

	P(A|B!=0) = P(A|B=1)*P(B=1|B!=0) + P(A|B=-1)*P(B=-1|B!=0) = 90%
			  = x*.99 + .y*.01 = 
			  one solution here is 
			  x=.908=P(A|B=1)
			  y=.092=P(A|B=-1)

So waht we want is 
	P(A|sB, sC) 
	= P(A|B!=0, sC) 
	= P(A|B=-1,B!=0) + S(B,sC) * E(A,B=1|B!=0)
	= P(A|B=-1) + S(B,sC) ( P(A|B=1,B!=0) - P(A|B!=1,B!=0) ) 
	= P(A|B=-1) + S(B,sC) ( P(A|B=1) - P(A|B=-1) ) 
	= .092 + .5/.99 * ( .908 - .092 ) = .504

^THIS SEEMS PLAUSIBLE

Yet it makes a causal assumption we maybe can't make? We didn't actually observe the effect of B on A. We observed the relevance of B=1 to A given B!=0. That's different. 

Yes but we saw the effect of seeing B (.9 - 46 = .44). Which is pretty big. Let's start over.

Totel effect is

	.46 + effect of (seeing b and downvoting) +  effect of (seeing B and uvoting)

	P(A|B=0) + ( P(A|B!=0) - P(A|B=0) ) = .46 + (.9 - .46 )
	P(A|B=0) + ( P(A|B=1)*P(B=1|B!=0) + P(A|B=-1)*P(B=-1|B!=0) - P(A|B=0) ) = .46 + (? - .46) 
	P(A|B=0) + ( .908*.99 + .092*.01 - P(A|B=0) ) = .46 + (.8989 + .00092 - .46) 


	P(A|B=0) + P(A|B=-1)*P(B=-1|B!=0) + ( P(A|B=1)*P(B=1|B!=0) - P(A|B=0) ) = .46 + .00092 + (.8989 - .46) 
	P(A|B=0) + P(A|B=-1)*P(B=-1|B!=0) + ( P(A|B=1)*P(B=1|B!=0) - P(A|B=0) ) = .46 + .00092 + (.8989 - .46) 
	P(A|B=0) + P(A,B=-1|B!=0) + ( P(A,B=1|B!=0) - P(A|B=0) ) = .46 + .00092 + (.8989 - .46) 

So  if we then discount just the effect of people who upvoted B 

	P(A|B=0) + P(A,B=-1|B!=0) + ( P(A,B=1|B!=0) - P(A|B=0) ) 

	P(A|B=0) + P(A,B=-1|B!=0) + S(B,Sc) * ( P(A,B=1|B!=0) - P(A|B=0) ) 

	= .46 + .00092 + .5/.99 * (.8989 - .46) 
	= .46092 + .505 * .4398
	= .683

^^^ THIS LOOKS RIGHT

This is approximately the same value, .68, we got with the simpler formula. The difference comes from allowing people who downvoted B to still upvote A. This reduces the effect of C,
since it only applies to people who upvoted B. But then we add back the .00092 who downvoted B but still upvoted A. This .00092 were users that upvoted A and  didn't change their
vote after seeing B. The pool of users where B=0 changed after users saw B.

so cnt(A,B=0) before and cnt(A,B=0) after are different, unless we double count!


What if it is just

	People who upvoted A and downvoted B, plus people who upvoted A and upvoted B
	P(A,B=-1|B!=0) + S(B,Sc) * P(A,B=1|B!=0)
	P(A|B=-1)*P(B=-1|B!=0) + S(B,Sc) * P(A|B=1)*P(B=1|B!=0)
	= .00092 + .505 * .8989 = .455

So the C reverses the effect of B on A completely. Again we have a questionable causal assumption. We assume upvoting B caused upvoting A, and reducing upvotes of B reduced upvotes of A.
It could be a common cause, something that cause upvote of B and A (e.g. politics.)

But don't we build in this assumption with our assumption that P(A|B=1) = .908?

What if it is

	P(A,B=-1|B!=0)/S(B,Sc) + P(A,B=1|B!=0) * S(B,Sc)
	.00092 / .505 + .8989 * .505 = .456



Which implies some
people who downvoted B were convinced by B? .00092

Okay so using the same formula for the second scenario...

	P(A|not sB) = 46%
	P(A|sB) = 90%

	P(B|not sC) = 0.01
	P(B|sC) = .99


	P(A|B=0) = .46
	S(B,sC) = 99
	P(B=1|B!=0) = .01
	P(B=-1|B!=0) = .99
	
	P(A|B=1)=.092
	P(A|B=-1)=.908

	We get the last two by solving

		P(A|B!=0) = P(A|B=1)*P(B=1|B!=0) + P(A|B=-1)*P(B=-1|B!=0) = 90%
				  = x*.01 + .y*.99 = 
				  one solution here is 
				  X=.092=P(A|B=1)
				  y=.908=P(A|B=-1)

		P(A|B=1)*P(B=1|B!=0) + P(A|B=-1)*P(B=-1|B!=0) 
		.092*.01 + .908*(.99)

	  P(A|B=0) + P(A|B=-1)*P(B=-1|B!=0) + ( P(A|B=1)*P(B=1|B!=0) - P(A|B=0) ) 
	  = .46 + .00092 + (.8989 - .46)  = .90


Totel effect is

	.46 + effect of (seeing b and downvoting) +  effect of (seeing B and uvoting)

	P(A|B=0) + ( P(A|B!=0) - P(A|B=0) ) = .46 + (.9 - .46 ) = .9
	P(A|B=0) + ( P(A|B=1)*P(B=1|B!=0) + P(A|B=-1)*P(B=-1|B!=0) - P(A|B=0) ) = .46 + (.092*.01 + .908*(.99) - .46) 
    P(A|B=0) + P(A|B=-1)*P(B=-1|B!=0) + ( P(A|B=1)*P(B=1|B!=0) - P(A|B=0) ) = .46 + .908*(.99) + (.092*.01 - .46) 

discounting

	# P(A|B=0) + P(A,B=-1|B!=0) + S(B,Sc) * ( P(A,B=1|B!=0) - P(A|B=0) ) 
	# = .46 + .908*(.99) + 99 (.092*.01 - .46) = 4409 


Or what if it is
	P(A,B=-1|B!=0)/S(B,Sc) + P(A,B=1|B!=0) * S(B,Sc)
	= .46 + .908*(.99) / 99 + 99 (.092*.01 ) = .56 


	still to high 

What if it is:

