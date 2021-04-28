#!/bin/sh
#
BASEDIR=/vagrant/buildbot-host

# Get configuration parameters
. $BASEDIR/params

docker image rm openvpn_community/buildbot-worker-ubuntu-1804:$WORKER_UBUNTU_1804_IMAGE_TAG
docker build -f Dockerfile -t openvpn_community/buildbot-worker-ubuntu-1804:$WORKER_UBUNTU_1804_IMAGE_TAG .
