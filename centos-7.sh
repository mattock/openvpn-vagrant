#!/bin/sh

echo "Preparing OpenVPN build environment"
echo
yum -y install lzo-devel openssl-devel pam-devel pkcs11-helper-devel gnutls-devel autoconf libtool make cmake git fping net-tools
