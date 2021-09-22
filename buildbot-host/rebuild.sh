#!/bin/sh
#
# Rebuild a buildmaster or buildbot worker container
DIR=$1

usage() {
    echo "./rebuild.sh <dir>"
    echo
    echo "Example:"
    echo "  ./rebuild.sh buildmaster"
    echo "  ./rebuild.sh buildbot-worker-ubuntu-2004"
    echo
    exit 1
}


if [ "$DIR" = "" ]; then
    usage
fi

if ! [ -d "$DIR" ]; then
    echo "ERROR: directory ${DIR} not found!"
    exit 1
fi

DYNAMIC_DOCKERFILE="no"

if [ -f "${DIR}/Dockerfile.base" ]; then
  echo "Constructing Dockerfile"
  DYNAMIC_DOCKERFILE="yes"
  cat $DIR/Dockerfile.base snippets/Dockerfile.common > $DIR/Dockerfile
elif [ -f "${DIR}/Dockerfile" ]; then
  echo "Using static Dockerfile"
else
  echo "ERROR: must have Dockerfile or Dockerfile.base to build!"
  exit 1
fi

# Get image name and version
IMAGE=`grep MY_NAME $DIR/Dockerfile|awk 'BEGIN { FS = "\"" }; { print $2 }'`
TAG=`grep MY_VERSION $DIR/Dockerfile|awk 'BEGIN { FS = "\"" }; { print $2 }'`

# Remove image with same name and tag, if found
docker build -f $DIR/Dockerfile -t openvpn_community/$IMAGE:$TAG .

if [ "${DYNAMIC_DOCKERFILE}" = "yes" ]; then
  rm -f $DIR/Dockerfile
fi
