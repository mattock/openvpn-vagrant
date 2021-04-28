#!/bin/sh
#
# startup script for purely stateless master

B=/var/lib/buildbot/masters/default

# Fixed buildbot master not start error in docker
rm -f $B/twistd.pid

#BUILDBOT_CONFIG_DIR=$B

# wait for db to start by trying to upgrade the master
until buildbot upgrade-master $B
do
    echo "Can't upgrade master yet. Waiting for database ready?"
    sleep 1
done

# we use exec so that twistd use the pid 1 of the container, and so that signals are properly forwarded
exec twistd -ny $B/buildbot.tac
