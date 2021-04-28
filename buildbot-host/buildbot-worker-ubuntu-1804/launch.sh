#!/bin/sh
#
NAME=buildbot-worker-ubuntu-1804
docker container stop $NAME
docker container rm $NAME
docker container run --name $NAME --network buildbot-net --env-file=env openvpn_community/$NAME:v1.0.0
