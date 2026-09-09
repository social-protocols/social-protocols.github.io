# AGENTS.md

Instructions for any coding agent (human-assisted or autonomous) working in this repository.

Keep this file **agent-general**. Tool-specific setup (Cursor Cloud `environment.json`, session-start hooks, IDE-only notes) belongs under `.cursor/`, not here.

## Trunk

The integration branch this repo fast-forwards onto is `main`. Everywhere this file says **trunk**, that means `main`. Per-repo exceptions belong in the install notes / `.cursor/trunk`, not in this line.

## Merge

Squash the PR to **one commit**, then **fast-forward** onto `main`. That squash commit **is** HEAD of `main`.

- No merge commits
- Rebase-merge is **not** the path (it keeps N commits)
- GitHub’s “Squash and merge” is the button
- **Do not merge** unless Jonathan explicitly says so for that PR (`gh pr merge --squash` is still a merge)
- Never `gh pr merge --merge`. Do not `--rebase` unless he says so for that PR

The squash SHA differs from the PR head. Treat the **code** as identical. Do not write SHA-dependent tests.

## CI and deploy

Test on the PR (the code that becomes `main`). After squash+FF, **deploy immediately**. Do **not** re-run format/compile/test on push to `main` (that is how a post-merge red happens after deploy already shipped). `main` workflows may deploy. Those deploy workflows need `concurrency: group: deploy-production` and `cancel-in-progress: true` so two pushes cannot race and land the older SHA last.

Branch protection must **require** those PR checks so untested code cannot merge.

When CI fails on a PR, notify or resume the agent that owns that branch. Do not poll. Do not merge to “fix” CI.

## GitHub settings (human, once per repo)

Settings → General → Pull Requests:

- Allow merge commits: **off**
- Allow squash merging: **on**
- Allow rebase merging: **off**

Settings → Branches → rule on `main`:

- Require linear history: **on**
- Require the PR checks before merge

Bots do not flip admin settings from the shared ops computer.

## Git hooks

If this repo has `.githooks`, environment setup must set `core.hooksPath=.githooks`. Do **not** `git commit` or `git push --no-verify` unless Jonathan says so. CI is the backstop, not the only gate.

## Incomplete work

The Bot that owns this repo owns open PRs, CI, merge conflicts, and drafts. Check at the weekday 8:56 America/Denver run and whenever a signal arrives. Act without waiting to be nudged. Stay silent if nothing is new.

When `main` moves: rebase remaining **non-parked** feature/`cursor/*` PRs. Skip PRs Jonathan has parked (do not nag, do not rebase).

## Do not

- Put tokens, keys, or secrets in this repo, in docs, or in chat
- Merge, spend, publish, or send external mail unless Jonathan says so
- Enable a live bot or production flag unless he says so

## Project

Hugo org site for [social-protocols.org](https://social-protocols.org/), deployed to GitHub Pages. Theme is hugo-lithium (`themes/hugo-lithium/`).

[Quality News](https://news.social-protocols.org/) is a separate app (same domain property in GSC; repo [social-protocols/quality-news](https://github.com/social-protocols/quality-news)). It is not this Hugo tree; this site only links to it.

Do not draft new posts or rewrite Jonathan’s voice. Take markdown he wrote, open PRs, and wait for his yes before merge.

This repo has no `.githooks`.

### Build and deploy

From `README.md` / `justfile`:

- `just serve` — `hugo server` with live reload at http://localhost:1313/
- `just build` — `hugo --minify` into `public/`

`devbox.json` provides `hugo` and `just`. `.envrc` loads that via direnv.

CI is `.github/workflows/build.yml` (**Build & Publish**): Hugo **0.131.0** extended, then `hugo --minify`. Runs on pull requests and on push to `main`. Deploy to the `gh-pages` branch (folder `public/`) runs only on push to `main`.
