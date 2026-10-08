FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# glibc >= 2.38. just and git are the required agent tools; Hugo extended
# 0.131.0 matches CI so the static site can be built in this image.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh \
    | bash -s -- --to /usr/local/bin

ARG HUGO_VERSION=0.131.0
RUN curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz" \
    | tar -xz -C /usr/local/bin hugo

USER ubuntu
