#!/bin/sh
#
export DEBIAN_FRONTEND=noninteractive

# Install build dependencies. Packages "fping" and "net-tools" are only
# required for t_client tests. Package "iproute2" is useful for debugging
# issues with Docker and OpenVPN.
apt-get update

apt-get install -y -q --no-install-recommends \
autoconf \
automake \
build-essential \
cmake \
curl \
fping \
git \
iproute2 \
libcmocka-dev \
libcmocka0 \
liblz4-dev \
liblzo2-dev \
libpam-dev \
libpkcs11-helper-dev \
libssl-dev \
libtool \
make \
net-tools \
python3-dev \
python3-pip \
python3-setuptools \
python3-wheel

rm -rf /var/lib/apt/lists/*
