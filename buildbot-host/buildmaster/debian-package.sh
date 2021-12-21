#!/bin/sh
set -ex

usage() {
  echo "Usage: debian-package.sh -w <workername>"
  echo
  echo "Example: debian-package.sh -w debian-10"
}

while getopts "hw:c:s:" arg; do
  case $arg in
    h)
      usage
      exit 0
      ;;
    w)
      WORKERNAME=$OPTARG
      ;;
  esac
done

TBV=`./debian-get-openvpn-version-tarball.py`
SV=`./debian-get-openvpn-version-sanitized.py`

if [ "$WORKERNAME" = "" ] || [ "$TBV" = "" ] || [ "$SV" = "" ]; then
  usage
  exit 1
fi

tar -zxf openvpn-$TBV.tar.gz
mv openvpn-$TBV openvpn-$SV
tar -zcf openvpn_$SV.orig.tar.gz openvpn-$SV
tar -C openvpn-$SV -xvf debian.tar
rm -f debian.tar
./debian-generate-changelog.sh $SV
mv debian-changelog openvpn-$SV/debian/changelog

CWD=`pwd`
cd openvpn-$SV
dpkg-buildpackage -d -S -uc
dpkg-buildpackage -b
cd $CWD

