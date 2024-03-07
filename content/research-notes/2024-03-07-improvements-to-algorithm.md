# Improvements to Scoring Algorithm

- Fix algorithm for 3-level arguments (post->note->subnote): estimate $`P(A|C)`$ using tallies for A given considered C.
- Better heuristic for top note: $informedVotes × relativeEntropy$
- [Adjustment for Informed Vote Selection Bias](2024-03-07-adjustment-for-informed-vote-selection-bias.md)
- Adjustment for Entrenchment Bias: Users' informed votes influenced by whether they voted on post before voting on note
- Implement/Improve support formula (use $`P(note|subnote)`$ to inform prior for $`P(post|subnote)`$:
	- deal with probabilities below 0 or about 1
	- improvements based on notes in [2024-03-05-support-formula-derivation.md](https://github.com/social-protocols/internal-wiki/blob/main/pages/research-notes/2024-03-05-support-formula-derivation.md)
- Reversion Constant: Better prior for informed probability by assuming informed probability tends to regress to the mean.
- Thomson Sampling
- Integrate MCMC sampling instead of using the Bayesian Averaging approximation
- Better solution for duplicates using the "great aunt" rule

