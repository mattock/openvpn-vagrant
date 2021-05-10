#!/bin/sh
#
export DEBIAN_FRONTEND=noninteractive

# Install build dependencies
apt-get update

apt-get install -y -q --no-install-recommends \
autoconf \
automake \
build-essential \
cmake \
curl \
git \
libcmocka-dev \
libcmocka0 \
liblz4-dev \
liblzo2-dev \
libpam-dev \
libpkcs11-helper-dev \
libssl-dev \
libtool \
make \
python3-dev \
python3-pip \
python3-setuptools \
python3-wheel

rm -rf /var/lib/apt/lists/*
