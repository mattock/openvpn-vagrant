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
    if ! [ "$1" = "-f" ]; then
        echo "ERROR: this script will temporarily remove curl to enable building of"
        echo "osslsigncode which requires OpenSSL 1.0 development libraries. While"
        echo "curl will be reinstalled later, its removal may have unwanted side-"
        echo "effects. It is thus recommended to run this script only on a dedicated"
        echo "build host, e.g. inside Vagrant:"
        echo
        echo "https://github.com/OpenVPN/openvpn-vagrant"
        echo
        echo "You can proceed by running this script with the -f option:"
        echo
        echo "./setup-generic-buildsystem.sh -f"
        echo
        exit 1
    fi

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

    # Remove curl to enable installation of openssl 1.0 devel package
    if [ "${CODENAME}" = "bionic" ]; then
        apt-get -y remove libcurl4 curl
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

    # Reinstall curl
    if [ "${CODENAME}" = "bionic" ]; then
        apt-get -y install libcurl4 curl
    fi
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
