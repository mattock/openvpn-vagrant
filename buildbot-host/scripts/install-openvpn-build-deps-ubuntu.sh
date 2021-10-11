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
debhelper \
dh-autoreconf \
dh-strip-nondeterminism \
dpkg-dev \
dwz \
fakeroot \
fping \
g++ \
git \
groff-base \
intltool-debian \
iproute2 \
libcmocka-dev \
libcmocka0 \
libdebconfclient0 \
libdpkg-perl \
libfakeroot \
libfile-stripnondeterminism-perl \
liblz4-dev \
liblzo2-dev \
libpam-dev \
libpkcs11-helper-dev \
libssl-dev \
libtool \
make \
net-tools \
po-debconf \
python3-docutils \
python3-dev \
python3-pip \
python3-roman \
python3-setuptools \
python3-wheel

rm -rf /var/lib/apt/lists/*
