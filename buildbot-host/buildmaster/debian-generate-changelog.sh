#!/bin/sh
#
# Generate Debian-compatible changelog file
#

usage() {
    echo "debian-generate-changelog.sh <sanitized-version>"
    echo
    echo "Example: debian-generate-changelog.sh 2.6"
    echo
}

if [ "$1" = "" ]; then
    usage
    exit
fi

SV=$1

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#SV="2.6"
UNIXTIME=`date '+%s'`
TIME=`date '+%a, %e %b %Y %I:%M:%S %z'`
AUTHOR="Samuli Seppänen <samuli@openvpn.net>"

cp debian-changelog.tmpl debian-changelog

sed -i "s/xVERSIONx/$SV/1" debian-changelog
sed -i "s/xUNIXTIMEx/$UNIXTIME/1" debian-changelog
sed -i "s/xTIMEx/$TIME/1" debian-changelog
sed -i "s/xAUTHORx/$AUTHOR/1" debian-changelog

cat debian-changelog
