#!/bin/sh
#
# Standalone script to set up an Ubuntu buildbot worker using files from
# openvpn-vagrant/buildbot-host
#
BUILDBOT_HOST_DIR="${BUILDBOT_HOST_DIR:-/vagrant/buildbot-host}"

# Install build dependencies for OpenVPN
mkdir -p /buildbot
cd /buildbot
$BUILDBOT_HOST_DIR/scripts/install-openvpn-build-deps-ubuntu.sh

# Set up buildbot worker
$BUILDBOT_HOST_DIR/scripts/install-buildbot.sh
cp $BUILDBOT_HOST_DIR/buildbot.tac /buildbot/
mkdir -p /home/buildbot
