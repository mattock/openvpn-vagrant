#!/bin/sh

echo "Preparing OpenVPN build environment"
echo
apt-get -y install liblzo2-dev libssl-dev libpam-dev libpkcs11-helper1-dev libtool autoconf make cmake git fping net-tools liblz4-dev
