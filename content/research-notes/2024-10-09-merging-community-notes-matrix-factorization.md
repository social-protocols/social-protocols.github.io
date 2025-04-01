# Merging Community Notes Matrix Factorization into the Global Brain

The primary goal of the global algorithm is to estimate *informed* opinion -- how users would vote on a item given they had considered all the comments on the item.

The goal of the Community Notes algorithm is to estimate *unbiased* opinion -- how users would vote if they were not influenced by polarization.

I realize that we could combine these into a single model and discover the informed and unbiased opinion using a single matrix factorization.

## Brief Review of Community Notes Model

The Community Notes algorithm is based on the idea that users votes on any item can be explained by:
  1. The user's polarity factor (roughly, how far left or right they are)
  2. The item's polarity factor (roughly, how strongly associated the item is with a left-wing or right-wing worldview)
  3. Some other factor about the user that cannot be explained away by polarity. We can call this the user's "friendliness" factor.
  4. Some other factor about the item cannot be explained away by polarity. We can call this the item's "common ground" factor.

For example, when a very right-wing user upvotes an item that supports a right-wing worldview, the vote can be "explained away" by their right wing worldview. But when a left-wing or neutral user upvotes the same item, and supposing that user does not have a high "friendliness" factor, then that vote cannot "explained away" any more. There must be something about that item itself that causes it to get lots of upvotes independently of the biases of the user. This is the "common ground" factor. This is the factor that Community Notes uses to identify "helpful" notes.

We can estimate all these factors by using something like matrix factorization to fit the data.

The model parameters is are:

- μᵢ = friendliness factor of user i
- μⱼ = common ground factor of item j
- wᵢ = polarity factor of user i
- xⱼ = common ground factor of user i

And the vote of user i on item j is predicted as:

$$
  ŷᵢⱼ = μᵢ + μⱼ + wᵢxⱼ
$$

The algorithm simply tries to find values of all these parameters that best fit the data (that best predict the actual votes yᵢⱼ).

The score of an item is its helpfulness factor:

$$
  scoreⱼ = μⱼ
$$

The score is equal to the estimated vote of a user with μᵢ=0 and wᵢ=0. That is, a neutral user, one that is not particularly "friendly" and neither left-wing nor right-wing.

## Merging the Global Brain and Community Notes Algorithm

The Global Brain algorithm can build on the community notes algorithm by adding a third factor: the information that a user has considered. Suppose we think users who have considered B may be more or less likely to upvote post A. So let's add another factor, "informedness", to the model. Let's define:

  - vᵢ the informedness factor of user i
  - zⱼ the informedness factor of post j

If a user has considered the B, their informedness factor is 1. The informedness factor of the post is how much being informed of B affects the votes on A.

Our new model is:

$$
  ŷᵢⱼ = μᵢ + μⱼ + wᵢxⱼ + vᵢzⱼ
$$

After fitting the data, our new score is:

$$
  scoreⱼ = μⱼ + zⱼ
$$

This is equal to the estimated vote of a user with μᵢ=0, wᵢ=0, and vᵢ=1. That is, **a neutral and informed user**.

## Comment Trees

Now in the Global Brain model, there is not just one piece of information. There is instead a tree of comments.

## Single Threads

First, consider a tree with one thread. Suppose $\overrightarrow{vᵢ}$ is a vector that represents whether or not each user has considered the item in each thread. 

For example, suppose we have a post A, with a comment B, and a reply to B, C. So the comment thread is B->C. Then $\overrightarrow{vᵢ}$ is a vector indicating which comments in the thread the user has considered. So for example, $\overrightarrow{vᵢ}$ might be (1,1) if the user has considered both comments.

So we just update our model to user vectors $\overrightarrow{vᵢ}$ and $\overrightarrow{zⱼ}$$.

$$
  ŷᵢⱼ = μᵢ + μⱼ + wᵢxⱼ + \overrightarrow{vᵢ}\overrightarrow{zⱼ}
$$

Then the score would be:

$$
  scoreⱼ = μⱼ + \overrightarrow{zⱼ}\overrightarrow{1}
$$

Where $\overrightarrow{1}$ is just a vector of 1s. So this is the estimated vote of a neutral user informed of each item in the thread.

## Multiple Threads

Suppose we have a post A with comments B1 and B2. So there are two separate threads, each one comment deep. Depending on which thread we choose, we will come up with a different score for A.

The Global Brain Algorithm algorithm combines multiple threads using a weighted average. In the current implementation, weight is based on relative entropy * upvotes. 

What do we do when a thread itself has multiple subthreads? For example, suppose the tree is:

           A
         ↙    ↘ 
        B1    B2
      ↙   ↘
    C1    C2

In this case, the algorithm scores each subtree (B1 and B2), and then takes a weighted average of each subtree.

To score subtree B1, the algorithm scores threads (B1,C1), and (B1,C2), takes a weighted average of these.

In this way, its possible to score arbitrarily large trees.

## Incremental Matrix Factorization

Now, this algorithm would end up factorizing a large matrix to fit the data many times: once for every single thread in the conversation tree. Matrix factorization can be slow, so this could be a problem. However, we can probably greatly reduce the amount of computation by running the model incrementally: fitting a smaller model with fewer factors, then fixing the parameters that have been found, adding another factor, and doing an incremental fit, which would be very fast.

For example, to score branch B1, we fit the data on a model with just thread B1 (ignoring children C1 and C2). This will give us a one-element vector $\overrightarrow{zⱼ}$ = $(Z_{B1})$ telling us how much B1 by itself affects votes on A. 

If we then fit the data again for the thread B1->C1, we will get a two-element vector $\overrightarrow{zⱼ}$ = $(Z_{B1}, Z_{C1})$. Now I believe $Z_{B1}$ will necessarily have to be the exact same value in both cases. That is because of the constraint that a user considers C1 or C2 only if they have considered B1, which constrains the possible values of $\overrightarrow{vᵢ}$ to (0,0), (1,0), and (1,1). And so $Z_{C1}$ is the incremental effect of C1.

This means that we can find $Z_{C1}$ by fitting the data incrementally. After obtaining $Z_{B1}$, we can fix its value, and run the model again to discover $Z_{C1}$. We can then run it again to discover $Z_{C2}$.

In fact, the other factors in the model, μᵢ, μⱼ, wᵢ, xⱼ, can also all be temporarily fixed. That is, first we run the regular community notes algorithm to estimate all the user and item biases. Then we fix these values, and run an incremental factorization to discover the informedness factors of the comments.


