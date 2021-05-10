#!/bin/sh
#
# Clean up all Docker stuff except for the volume, which we want to persist

BASEDIR=/vagrant/buildbot-host

for CONTAINER in buildmaster buildbot-worker-ubuntu-1804 buildbot-worker-ubuntu-2004 buildbot-worker-centos-8; do
  docker container stop $CONTAINER
  docker container rm $CONTAINER
done
