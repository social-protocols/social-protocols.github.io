
serve:
	hugo server

build:
	nix-shell --command "Rscript -e 'blogdown::build_site(build_rmd = \"newfile\")'"





