FROM ubuntu:18.04

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    ; \
    rm -rf /var/lib/apt/lists/*

ENV BUILDBOT_VERSION 3.1.0
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

USER root
ARG DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update; \
    apt-get install -y -q --no-install-recommends \
    build-essential \
    git \
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

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
