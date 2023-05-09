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
