#!/bin/sh
#
# Build and install stable version of asio
#
set -ex

if [ "$1" = "" ]; then
    echo "ERROR: must provide asio Git ref (branch, tag) as the first parameter!"
    exit 1
fi

ASIO_REF=$1

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
