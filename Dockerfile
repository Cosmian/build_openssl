FROM ubuntu:22.04 AS builder

LABEL version="0.1.0"
LABEL name="OpenSSL for Linux ARM64"

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENSSL_DIR=/usr/local/openssl
ENV OPENSSL_VERSION=3.2.0

WORKDIR /root

RUN apt-get update \
  && apt-get install --no-install-recommends -qq -y \
  curl \
  build-essential \
  libssl-dev \
  ca-certificates \
  libclang-dev \
  libsodium-dev \
  pkg-config \
  git \
  wget \
  && apt-get -y -q upgrade \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY . /root/build_openssl

WORKDIR /root/build_openssl

ARG TARGETPLATFORM
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then export ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then export ARCHITECTURE=arm; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then export ARCHITECTURE=aarch64; else export ARCHITECTURE=amd64; fi \
  && mkdir -p $OPENSSL_DIR \
  && bash /root/build_openssl/.github/scripts/local_ossl_instl.sh

