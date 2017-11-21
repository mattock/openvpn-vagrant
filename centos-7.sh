#!/bin/sh

echo "Preparing OpenVPN build environment"
echo
yum -y install lzo-devel openssl-devel pam-devel pkcs11-helper-devel gnutls-devel autoconf libtool make cmake git net-tools

echo "Ensure that fping is in root user's PATH"
echo "export PATH=$PATH:/usr/local/sbin" >> /etc/bashrc
