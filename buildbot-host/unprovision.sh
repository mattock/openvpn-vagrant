#!/bin/sh
#
# Clean up all Docker stuff except for the volume, which we want to persist

BASEDIR=/vagrant/buildbot-host

# Get configuration parameters
. $BASEDIR/buildmaster/params

docker container stop buildmaster
docker container rm buildmaster
docker container stop buildbot-worker-ubuntu-2004
docker container rm buildbot-worker-ubuntu-2004
docker network rm buildbot-net
