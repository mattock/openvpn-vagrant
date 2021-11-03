#!/bin/sh
#
# Upgrade package cache and do a system upgrade
#
set -ex

yes|pacman -Syu

# Install build dependencies
pacman -S --noconfirm \
autoconf \
automake \
cmake \
curl \
gcc \
git \
gnutls \
libtool \
lz4 \
lzo \
make \
openssl \
pam \
pkcs11-helper \
python \
python-pip \
python-setuptools \
python-wheel
