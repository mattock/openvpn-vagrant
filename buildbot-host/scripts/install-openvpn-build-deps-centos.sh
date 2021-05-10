#!/bin/sh
#
# pkcs11-helper-dev is only available in the EPEL repository
yum -y install epel-release

yum -y install \
autoconf \
cmake \
gnutls-devel \
libtool \
pkcs11-helper-devel \
lzo-devel \
make \
openssl-devel \
pam-devel \
python36-devel \
python3-pip \
python3-setuptools \
python3-wheel
