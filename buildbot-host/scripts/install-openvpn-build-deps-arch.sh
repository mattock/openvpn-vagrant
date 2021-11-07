#!/bin/sh
#
# Upgrade package cache and do a system upgrade
#
set -ex

yes|pacman -Syu

# Install build dependencies
pacman -S --noconfirm \
asio \
autoconf \
autoconf-archive \
automake \
bzip2 \
cmake \
curl \
dbus-python \
gcc \
git \
glib2 \
gnutls \
jsoncpp \
libcap-ng \
libtool \
lz4 \
lzo \
make \
mbedtls \
openssl \
pam \
pkcs11-helper \
pkgconf \
polkit \
python \
python-gobject \
python-pip \
python-setuptools \
python-wheel \
tinyxml2 \
zlib
