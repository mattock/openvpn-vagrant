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
make \
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
timyxml2 \
tinyxml2-devel \
zlib-devel
