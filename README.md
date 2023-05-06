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
	just build
```

Or

```
	just watch
```

These commands run the distill build process (`rmarkdown::render_site()` in R), which will generate HTML files under docs/, which you can browse locally. The deploy workflow triggered automatically by git commit does the same thing.
