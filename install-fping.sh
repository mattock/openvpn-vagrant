#!/bin/sh

VERSION="4.0"
BASENAME="fping-$VERSION"
TARBALL="$BASENAME.tar.gz"

curl -O http://fping.org/dist/$TARBALL
tar -zxf $TARBALL
cd $BASENAME
./configure && make && make install
