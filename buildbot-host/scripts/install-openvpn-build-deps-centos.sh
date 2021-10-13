#!/bin/sh
#
set -ex

# pkcs11-helper-dev is only available in the EPEL repository
yum -y install epel-release

yum -y install \
autoconf \
cmake3 \
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

# This is required for CentoOS 7 where "cmake" is missing, but "cmake3" is
# present.
test -e /usr/bin/cmake || ln -s /usr/bin/cmake3 /usr/bin/cmake
