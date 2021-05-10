#!/bin/sh
#
# Rebuild a buildmaster or buildbot worker container
IMAGE=$1
TAG=$2

usage() {
    echo "./rebuild.sh <image> <tag>"
    echo
    echo "Example:"
    echo "  ./rebuild.sh buildmaster v2.0.0"
    echo "  ./rebuild.sh buildbot-worker-ubuntu-2004 v1.0.0"
    echo
    exit 1
}


if [ "$1" = "" ]; then
    usage
fi

if [ "$2" = "" ]; then
    usage
fi

cat $IMAGE/Dockerfile.base snippets/Dockerfile.common > $IMAGE/Dockerfile

# Remove image with same name and tag, if found
docker image rm openvpn_community/$IMAGE:$TAG 2> /dev/null || true 
docker build -f $IMAGE/Dockerfile -t openvpn_community/$IMAGE:$TAG .
rm -f $IMAGE/Dockerfile
