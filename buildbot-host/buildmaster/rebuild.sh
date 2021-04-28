#!/bin/sh
#
# Clean up all Docker stuff except for the volume, which we want to persist

BASEDIR=/vagrant/buildbot-host

# Get configuration parameters
. $BASEDIR/params

docker image rm openvpn_community/buildbot-master:$BUILDMASTER_IMAGE_TAG
docker build -f Dockerfile -t openvpn_community/buildbot-master:$BUILDMASTER_IMAGE_TAG .
