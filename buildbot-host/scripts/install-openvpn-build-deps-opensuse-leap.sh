#!/bin/sh
#
set -ex

zypper install -y \
asio-devel \
autoconf \
autoconf-archive \
automake \
bzip2 \
cmake \
curl \
gcc \
gcc-c++ \
git \
glib2-devel \
gnutls-devel \
gzip \
jsoncpp-devel \
kernel-devel \
libcap-ng-devel \
liblz4-devel \
libxml2-devel \
libtool \
libselinux-devel \
libuuid-devel \
lzo-devel \
make \
mbedtls-devel \
openssl-devel \
pam-devel \
pkcs11-helper-devel \
pkgconf \
polkit \
python3-devel \
python3-dbus-python \
python3-docutils \
python3-gobject \
python3-Jinja2 \
python3-pip \
python3-pyOpenSSL \
python3-setuptools \
python3-wheel \
tinyxml2-devel

# Hack to ensure that kernel headers can be found from a predictable place
# Right now kernel headers are not usable with ovpn-dco, so this is here mostly
# for documentation purposes.
ln -s /usr/src/linux /buildbot/kernel-headers
