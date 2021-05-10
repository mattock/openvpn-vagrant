#!/bin/sh
#
# Launch a buildmaster or buildbot worker
IMAGE=$1
TAG=$2

usage() {
    echo "./launch.sh <image> <tag>"
    echo
    echo "Example:"
    echo "  ./launch.sh buildbot-worker-ubuntu-2004 v3.1.0"
    echo
    exit 1
}

if [ "$1" = "" ]; then
    usage
fi

if [ "$2" = "" ]; then
    usage
fi

docker container stop $IMAGE
docker container rm $IMAGE
docker container run --name $IMAGE --network buildbot-net --env-file=$IMAGE/env openvpn_community/$IMAGE:$TAG
