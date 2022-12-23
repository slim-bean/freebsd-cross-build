#FROM ubuntu:20.04
FROM golang:1.19-buster

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  clang \
  make \
  file \
  curl \
  ca-certificates \
  git \
  texinfo \
  xz-utils \
  wget \
  pkg-config

COPY freebsd-toolchain.sh /tmp/
RUN /tmp/freebsd-toolchain.sh x86_64

ENV \
    AR=x86_64-unknown-freebsd12-ar \
    CC=x86_64-unknown-freebsd12-clang \
    CX=x86_64-unknown-freebsd12-clang++ \
    GOOS=freebsd \
    GOARCH=amd64 \
    CGO_ENABLED=1 \
    PATH="/go/bin/${GOOS}_${GOARCH}:${PATH}"

ENV HOSTS=x86_64-unknown-freebsd
