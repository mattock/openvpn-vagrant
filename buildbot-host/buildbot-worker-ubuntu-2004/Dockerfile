FROM buildbot/buildbot-worker:v3.1.0

MAINTAINER OpenVPN Community Project

COPY buildbot.tac /buildbot/

USER root
ARG DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update; \
    apt-get install -y -q --no-install-recommends \
    build-essential \
    liblzo2-dev \
    liblz4-dev \
    libssl-dev \
    libpam-dev \
    libpkcs11-helper-dev \
    libtool \
    automake \
    autoconf \
    make \
    cmake \
    libcmocka-dev \
    libcmocka0
