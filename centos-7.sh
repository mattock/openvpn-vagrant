#!/bin/sh

echo "Preparing OpenVPN 2 build environment"
echo
yum -y install lzo-devel openssl-devel pam-devel pkcs11-helper-devel gnutls-devel autoconf libtool make cmake git net-tools
echo
echo "Preparing OpenVPN 3 build enviroment"
echo
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y mbedtls-devel glib2-devel jsoncpp-devel libuuid-devel lz4-devel gcc-c++ git autoconf automake make pkgconfig

echo "Ensure that fping is in root user's PATH"
echo "export PATH=$PATH:/usr/local/sbin" >> /etc/bashrc
