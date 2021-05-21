#!/bin/sh
#
# Launch a static buildbot worker
DIR=$1

usage() {
    echo "./launch.sh <dir>"
    echo
    echo "Example:"
    echo "  ./launch.sh buildbot-worker-ubuntu-2004"
    echo
    exit 1
}

if [ "$1" = "" ]; then
    usage
fi

# Get image name and version
IMAGE=`grep MY_NAME $DIR/Dockerfile.base|awk 'BEGIN { FS = "\"" }; { print $2 }'`
TAG=`grep MY_VERSION $DIR/Dockerfile.base|awk 'BEGIN { FS = "\"" }; { print $2 }'`

docker container stop $IMAGE
docker container rm $IMAGE
docker container run -it --name $IMAGE --network buildbot-net --env-file=$DIR/env openvpn_community/$IMAGE:$TAG
