let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      R
      # rPackages.rmarkdown
      # rPackages.knitr
      # rPackages.distill
      # # rPackages.rcpp
      # rPackages.servr
      rPackages.blogdown
    ];
  }