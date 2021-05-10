#!/bin/sh
#
# Provision a Docker host for running Buildbot master and workers

BASEDIR=/vagrant/buildbot-host
VOLUME_DIR=/var/lib/docker/volumes/buildmaster/_data/

# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
apt-get update
apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io

CWD=`pwd`

# Create network for buildmaster and the workers
docker network create --driver bridge buildbot-net

# Create volume for storing buildmaster's sqlite database and passwords
docker volume create buildmaster

# Add secrets
mkdir -p $VOLUME_DIR/secrets
chmod 700 $VOLUME_DIR/secrets
echo $WORKER_PASSWORD > $VOLUME_DIR/secrets/worker-password
chmod 600 $VOLUME_DIR/secrets/*
