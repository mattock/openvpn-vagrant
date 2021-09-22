#!/bin/sh
#
# pkcs11-helper-dev is only available in the EPEL repository
#yum -y install epel-release

yum -y install \
autoconf \
cmake \
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
