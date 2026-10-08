set shell := ["bash", "-euo", "pipefail", "-c"]

# List recipes
default:
    @just --list

# Local Hugo server with live reload
serve:
    hugo server

# Production build into public/
build:
    hugo --minify

# Every CI gate (production Hugo build)
check: build
