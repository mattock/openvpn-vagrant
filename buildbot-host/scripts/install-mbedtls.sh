#!/bin/sh
#
# Build and install mbedtls
#
MBEDTLS_VERSION=2.2.1
PKG_NAME=mbedtls-$MBEDTLS_VERSION-apache.tgz

curl --remote-name --insecure https://tls.mbed.org/download/$PKG_NAME
tar -zvxf $PKG_NAME
cd mbedtls*
export SHARED=1
make clean
make
make install 
