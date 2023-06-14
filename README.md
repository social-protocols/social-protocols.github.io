# Social Protocols Website

This website is built using [Distill for R Markdown](https://rstudio.github.io/distill/).

## Workflows

### Set Up Environment

Execute the following to have a `ROOTDIR` environment variable available when you want to create paths:

```
$ ROOTDIR=$(pwd)
$ echo "ROOTDIR=${ROOTDIR}" >> .Renviron
```

Now you can refer to files with absolute paths:

```
file.path(ROOTDIR, "path", "to", "file")
```

### Running Locally through nix

```
	just serve
```

### Bugs

For some reason, changes to .Rmd files don't get picked up automatically when running 'just serve', but changes to .md files to.

If however if you do the following,

```
   > nix-shell
   > R
   > source("serve.R") 
```

You get some warning messages, but changes to .Rmd files to get picked up. However, it produces some Permission Denied warning messages that seem to be ignorable.

## Notes on Publishing Posts to Social Networks 

## Update the Summary

- Take a part of the first Paragraph to use as the summary. The default summary is not always great (it may include the first heading in the article, and cut off in an odd place). The summary is displayed on the home page and Twitter previews. We will also copy and paste in when publishing below.

### Twitter:

- make sure the Twitter Card displays properly (image and summary)

### Mastodon:

- manually copy image and summary (Mastodon doesn't load Twitter card preview)

### Medium:

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
  - Under advanced settings, and click "This story was originally published elsewhere". Enter the social protocols URL for the story.
- Publish
  - It will ask for topics. Choose topics used in other posts. Currently: Social Media, Collective Intelligence, Attention Economy, Group Dynamics, Systems Thinking

### Substack:

- Create new article
- Enter subtitle
- Enter author in subtitle space below title
- Update Settings:
  - Copy summary into Social Preview
  - Choose tags. Same tags as other posts.
  - SEO Settings
    - Copy summary to SEO Description
