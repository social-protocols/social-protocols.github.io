# Social Protocols Website

This website is built using [Hugo](https://gohugo.io/) and automatically deployed to GitHub Pages.

## Development

### Running Locally

The easiest way to run the site locally is using [just](https://github.com/casey/just):

```bash
just serve
```

This runs `hugo server` which starts a local development server with live reload at `http://localhost:1313/`.

Alternatively, if you have Hugo installed, you can run directly:

```bash
hugo server
```

### Building

To build the site for production:

```bash
just build
```

This runs `hugo --minify` and generates static files in the `public/` directory.

## Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the `main` branch. See `.github/workflows/build.yml` for the deployment configuration.

- **Hugo Version**: 0.131.0 (extended)
- **Target Branch**: `gh-pages`
- **Live Site**: https://social-protocols.org/

## Theme

The site uses a customized version of the [hugo-lithium](https://github.com/yihui/hugo-lithium) theme located in `themes/hugo-lithium/`.

## Content Structure

- `content/articles/` - Main articles and blog posts
- `content/research-notes/` - Research notes and exploratory write-ups
- `content/about.md` - About page
- `content/_index.md` - Homepage

## Notes on Publishing Posts to Social Networks

### Update the Summary

- Take a part of the first paragraph to use as the summary. The default summary is not always great (it may include the first heading in the article, and cut off in an odd place). The summary is displayed on the home page and Twitter previews. We will also copy and paste it when publishing below.

### Twitter

- Make sure the Twitter Card displays properly (image and summary)

### Mastodon

- Manually copy image and summary (Mastodon doesn't load Twitter card preview)

### Medium

- Create new Article
- Enter the Title
- Copy and paste the featured image and post content from social-protocols.org
- Clean Up:
  - Remove extra spaces below headings
  - Remove dates and read time
  - Add author name
  - Add alt text to the featured image (if it has any)
- Update Settings
  - Update the SEO title to "{Article Title} | Social Protocols"
  - Under advanced settings, click "This story was originally published elsewhere". Enter the social protocols URL for the story.
- Publish
  - It will ask for topics. Choose topics used in other posts. Currently: Social Media, Collective Intelligence, Attention Economy, Group Dynamics, Systems Thinking

### Substack

- Create new article
- Enter subtitle
- Enter author in subtitle space below title
- Update Settings:
  - Copy summary into Social Preview
  - Choose tags. Same tags as other posts.
  - SEO Settings
    - Copy summary to SEO Description

## Further Documentation

For more detailed Hugo documentation and guidance, see [issue #9](https://github.com/social-protocols/social-protocols.github.io/issues/9).
