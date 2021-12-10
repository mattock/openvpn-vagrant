#!/bin/sh
#
set -ex

# Required to install some openvpn3-linux dependencies
yum -y install yum-utils
yum-config-manager --set-enabled powertools

# pkcs11-helper-dev is only available in the EPEL repository
yum -y install epel-release

yum -y install \
autoconf \
autoconf-archive \
automake \
bzip2 \
cmake3 \
elfutils-libelf-devel \
gcc \
gcc-c++ \
git \
glib2-devel \
gnutls-devel \
jsoncpp-devel \
libcap-ng-devel \
libtool \
libuuid-devel \
libxml2 \
lz4-devel \
lzo-devel \
kernel-devel \
make \
mbedtls-devel \
openssl-devel \
pam-devel \
pkcs11-helper-devel \
pkgconfig \
polkit \
python3-devel \
python3-dbus \
python3-docutils \
python3-gobject \
python3-jinja2 \
python3-pip \
python3-pyOpenSSL \
python3-setuptools \
python3-wheel \
selinux-policy-devel \
tinyxml2 \
tinyxml2-devel \
zlib-devel

# Hack to ensure that kernel headers can be found from a predictable place
ln -s /usr/src/kernels/$(ls /usr/src/kernels|head -n 1) /buildbot/kernel-headers
