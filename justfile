
serve:
	nix-shell --command "Rscript -e 'blogdown::serve_site(browser = FALSE)'"

build:
	nix-shell --command "Rscript -e 'blogdown::build_site(build_rmd = \"newfile\")'"





