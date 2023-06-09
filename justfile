
serve:
	nix-shell --pure --command "Rscript serve.R"

build:
	nix-shell --command "Rscript -e 'blogdown::build_site(build_rmd = \"newfile\")'"





