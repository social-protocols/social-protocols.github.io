# Social Protocols Website

## Workflows

Execute the following to have a `ROOTDIR` environment variable available when you want to create paths:

```
$ ROOTDIR=$(pwd)
$ echo "ROOTDIR=${ROOTDIR}" >> .Renviron
```

Now you can refer to files with absolute paths:

```
file.path(ROOTDIR, "path", "to", "file")
```
