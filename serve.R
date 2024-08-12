

options(
  # to disable knitting Rmd files on save, set this option to FALSE
  blogdown.knit.on_save = TRUE,

  # build .Rmd to .md; to build to .html (via Pandoc), set this option to 'html'
  blogdown.method = 'markdown',
  blogdown.hugo.version = '0.131.0',
  blogdown.hugo.server = c('-D', '-F', '--navigateToChanged', '--disableFastRender')

)


blogdown::serve_site(browser = FALSE)
