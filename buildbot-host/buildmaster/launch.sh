#!/bin/sh
#
# Launch the buildmaster
TAG=$1

usage() {
    echo "Usage: ./launch.sh <tag>"
    exit 1
}

if [ "$1" = "" ]; then
    usage
fi

docker container stop buildmaster
docker container rm buildmaster

docker container run -it --name buildmaster --mount source=buildmaster,target=/var/lib/buildbot/masters/default/persistent --network buildbot-net --publish 8010:8010 --publish 9989:9989 openvpn_community/buildmaster:$TAG
