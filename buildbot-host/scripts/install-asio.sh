#!/bin/sh
#
# Build and install stable version of asio
#
set -ex

ASIO_REF="asio-1-18-2"

CWD=`pwd`

git clone https://github.com/chriskohlhoff/asio.git
cd asio/asio
git checkout $ASIO_REF
autoreconf -vi
./configure
make
make install

cd $CWD
rm -rf asio
