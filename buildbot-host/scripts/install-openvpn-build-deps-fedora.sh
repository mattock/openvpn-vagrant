#!/bin/sh
#
set -ex

yum -y install \
autoconf \
cmake \
gcc \
gcc-c++ \
git \
gnutls-devel \
libtool \
lz4-devel \
lzo-devel \
make \
openssl-devel \
pam-devel \
pkcs11-helper-devel \
python3-devel \
python3-pip \
python3-setuptools \
python3-wheel
