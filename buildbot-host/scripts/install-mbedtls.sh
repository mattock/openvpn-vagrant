#!/bin/sh
#
# Build and install mbedtls
#
set -ex

MBEDTLS_VERSION=2.2.1
PKG_NAME=mbedtls-$MBEDTLS_VERSION-apache.tgz

CWD=`pwd`

curl --remote-name --insecure https://tls.mbed.org/download/$PKG_NAME
tar -zvxf $PKG_NAME
cd mbedtls-$MBEDTLS_VERSION
export SHARED=1
make clean
make
make install

# On Alpine Linux ldconfig fails so we don't run it
test -d /etc/apk || ldconfig

cd $PWD
rm -rf mbedtls-$MBEDTLS_VERSION
