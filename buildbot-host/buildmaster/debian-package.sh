#!/bin/sh
set -e

usage() {
  echo "Usage: debian-package.sh -w <workername> -c <committish> -s <sanitized-version>"
  echo
  echo "Example: debian-package.sh -w debian-10 -v 2.6_git -s 2.6"
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
    c)
      COMM=$OPTARG
      ;;
    s)
      SV=$OPTARG
      ;;
  esac
done

if [ "$WORKERNAME" = "" ] || [ "$COMM" = "" ] || [ "$SV" = "" ]; then
  usage
  exit 1
fi

tar -zxf openvpn-$COMM.tar.gz
mv openvpn-$COMM openvpn-$SV
tar -zcf openvpn_$SV.orig.tar.gz openvpn-$SV
tar -C openvpn-$SV -xvf debian.tar
rm -f debian.tar
mv debian-changelog openvpn-$SV/debian/changelog

CWD=`pwd`
cd openvpn-$SV
dpkg-buildpackage -d -S -uc
dpkg-buildpackage -b
cd $CWD

