#!/bin/sh
#
export DEBIAN_FRONTEND=noninteractive

# Install dependencies
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
make
