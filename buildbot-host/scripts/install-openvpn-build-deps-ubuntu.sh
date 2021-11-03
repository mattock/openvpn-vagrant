#!/bin/sh
#
set -ex

export DEBIAN_FRONTEND=noninteractive

# Install build dependencies. Packages "fping" and "net-tools" are only
# required for t_client tests. Package "iproute2" is useful for debugging
# issues with Docker and OpenVPN.
apt-get update

apt-get install -y -q --no-install-recommends \
autoconf \
autoconf-archive \
automake \
build-essential \
cmake \
curl \
debhelper \
dh-autoreconf \
dh-strip-nondeterminism \
dpkg-dev \
dwz \
fakeroot \
fping \
g++ \
git \
groff-base \
intltool-debian \
iproute2 \
libjsoncpp1 \
libcap-ng-dev \
libcmocka-dev \
libcmocka0 \
libdebconfclient0 \
libdpkg-perl \
libfakeroot \
libfile-stripnondeterminism-perl \
libglib2.0-dev \
libjsoncpp-dev \
liblz4-dev \
liblzo2-dev \
libpam-dev \
libpkcs11-helper-dev \
libssl-dev \
libtool \
libtinyxml2-dev \
libxml2-utils \
make \
net-tools \
pkg-config \
po-debconf \
policykit-1 \
python3 \
python3-docutils \
python3-dev \
python3-dbus \
python3-docutils \
python3-jinja2 \
python3-minimal \
python3-pip \
python3-roman \
python3-setuptools \
python3-wheel \
uuid-dev

rm -rf /var/lib/apt/lists/*
