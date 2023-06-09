let
pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/9ea6dd599d2781168e36486745b5d17e826ab015.tar.gz") {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      R
      hugo
      # rPackages.rmarkdown
      # rPackages.knitr
      # rPackages.distill
      # # rPackages.rcpp
      # rPackages.servr
      # rPackages.renv
      rPackages.yaml
      rPackages.blogdown
    ];
  }