build:
	nix-shell --command "Rscript -e 'rmarkdown::render_site()'"

watch:
	find . -name '*.Rmd' | entr -nrc nix-shell --command "Rscript -e 'rmarkdown::render_site()'"
