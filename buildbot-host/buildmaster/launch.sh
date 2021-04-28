#!/bin/sh
#
# Launch the buildmaster
BASEDIR=/vagrant/buildbot-host

# Get configuration parameters
. $BASEDIR/params

docker container stop buildmaster
docker container rm buildmaster

docker container run --name buildmaster --mount source=buildmaster,target=/var/lib/buildbot/masters/default/persistent --network buildbot-net --publish 8010:8010 --publish 9989:9989 openvpn_community/buildbot-master:$BUILDMASTER_IMAGE_TAG
