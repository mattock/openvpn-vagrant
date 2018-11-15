#!/bin/sh
#
# Script to setup the environment for openvpn-build/generic and openvpn-build/windows-nsis 
#
# This script works on Ubuntu 16.04 and 18.04.

CODENAME=`lsb_release -cs`
BUILD_DEPS="mingw-w64 man2html dos2unix nsis unzip wget curl autoconf libtool gcc-arm-linux-gnueabi"
OSSLSIGNCODE_URL="http://sourceforge.net/projects/osslsigncode/files/latest/download"
OSSLSIGNCODE_PACKAGE="osslsigncode-latest.tar.gz"
OPENVPN_BUILD_URL="https://github.com/OpenVPN/openvpn-build.git"
MINGW_PACKAGES="mingw-w64 mingw-w64-common mingw-w64-i686-dev mingw-w64-x86-64-dev"
NSIS_PACKAGES="nsis nsis-common nsis-doc nsis-pluginapi"
GIT_PKG="git"

if [ "${CODENAME}" = "bionic" ]; then
    OSSLSIGNCODE_DEPS="libcurl-openssl1.0-dev libssl1.0-dev libcurl3 build-essential"
elif [ "${CODENAME}" = "xenial" ]; then
    OSSLSIGNCODE_DEPS="libssl-dev libcurl4-openssl-dev build-essential"
else
    echo "ERROR: unsupported OS or lsb-release package not installed! Run this on Ubuntu 16.04 or 18.04."
    exit 1
fi

check_if_root() {
    if ! [ `whoami` = "root" ]; then
            echo "ERROR: you must run this script as root!"
            exit 1
    fi
}

install_packages() {
    apt-get update
    if [ "${CODENAME}" = "bionic" ]; then
        apt-get -y remove libcurl curl
    fi
    apt-get -y install $BUILD_DEPS $GIT_PKG $GNUEABI_PKG $MINGW_PACKAGES $NSIS_PACKAGES
}

# osslsigncode is required for signing the binaries and installers
install_osslsigncode() {
    apt-get -y install $OSSLSIGNCODE_DEPS
    wget --quiet $OSSLSIGNCODE_URL -O $OSSLSIGNCODE_PACKAGE
    tar -zxf $OSSLSIGNCODE_PACKAGE
    cd osslsigncode-*
    ./configure
    make
    make install
    cd ..
}

clone_openvpn_build() {
    if ! [ -d "openvpn-build" ]; then
        git clone $OPENVPN_BUILD_URL
    fi
}

# Main script
check_if_root
install_packages
install_osslsigncode
clone_openvpn_build
