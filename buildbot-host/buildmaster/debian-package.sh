#!/bin/sh
usage() {
  echo "Usage: debian-package.sh -w <workername> -v <version-string> -s <sanitized-version>"
  echo
  echo "Example: debian-package.sh -w debian-10 -v 2.6_git -s 2.6"
}

while getopts "hw:v:s:" arg; do
  case $arg in
    h)
      usage
      exit 0
      ;;
    w)
      WORKERNAME=$OPTARG
      ;;
    v)
      VER=$OPTARG
      ;;
    s)
      SV=$OPTARG
      ;;
  esac
done

if [ "$WORKERNAME" = "" ] || [ "$VER" = "" ] || [ "$SV" = "" ]; then
  usage
  exit 1
fi

tar -zxf openvpn-$VER.tar.gz
mv openvpn-$VER openvpn-$SV
tar -zcf openvpn_$SV.orig.tar.gz openvpn-$SV
tar -C openvpn-$SV -xvf debian.tar
rm -f debian.tar
mv debian-changelog openvpn-$SV/debian/changelog

CWD=`pwd`
cd openvpn-$SV
dpkg-buildpackage -d -S -uc
dpkg-buildpackage -b
cd $CWD

