FROM ubuntu:24.04@sha256:534baea6a22c03a63003dbc8dbe78fe34bc0d7e595d9a9dc9834884ff530eb55

ENV DEBIAN_FRONTEND=noninteractive

# glibc >= 2.38. just and git are the required agent tools; Hugo extended
# 0.131.0 matches CI so the static site can be built in this image.
# just comes from Ubuntu 24.04 universe (do not pipe just.systems install.sh).
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        just \
    && rm -rf /var/lib/apt/lists/*

ARG TARGETARCH=amd64
ARG HUGO_VERSION=0.131.0
# sha256 values from hugo_0.131.0_checksums.txt on the v0.131.0 GitHub release.
RUN set -eux; \
    case "${TARGETARCH}" in \
      amd64) hugo_arch=amd64; hugo_sha256=88ba12c62772469695bff0ee0a724bf12922995243ed866076b165ad409de901 ;; \
      arm64) hugo_arch=arm64; hugo_sha256=c880bf5edc178bc26c69385f527cc8b230de9174bafdb3e04ce5496dd668b397 ;; \
      *) echo "unsupported TARGETARCH=${TARGETARCH}" >&2; exit 1 ;; \
    esac; \
    tarball="hugo_extended_${HUGO_VERSION}_linux-${hugo_arch}.tar.gz"; \
    curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${tarball}" -o "/tmp/${tarball}"; \
    echo "${hugo_sha256}  /tmp/${tarball}" | sha256sum -c -; \
    tar -xzf "/tmp/${tarball}" -C /usr/local/bin hugo; \
    rm "/tmp/${tarball}"

USER ubuntu
