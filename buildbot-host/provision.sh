#!/bin/sh
#
# Provision a Docker host for running Buildbot master and workers

BASEDIR=/vagrant/buildbot-host
VOLUME_DIR=/var/lib/docker/volumes/buildmaster/_data/
WORKER_PASSWORD=vagrant

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

# Ensure that "vagrant" user can run Docker commands
usermod -a -G docker vagrant

# Ensure that docker is listening on TCP port (for launching latent docker
# buildslaves)
mkdir -p /etc/systemd/system/docker.service.d
cat > /etc/systemd/system/docker.service.d <<EOL
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H fd:// --containerd=/run/containerd/containerd.sock
EOL

# Ensure that Docker daemon is IPv6-enabled. This is required for t_client
# tests where OpenVPN server pushes IPv6 information to the newly built OpenVPN
# client.
cat > /etc/docker/daemon.json <<EOL
{
    "ipv6": true,
    "fixed-cidr-v6": "fd00::/80"
}
EOL

systemctl daemon-reload
systemctl restart docker
