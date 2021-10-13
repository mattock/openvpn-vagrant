#!/bin/sh
#
# Install buildbot
#
set -ex

BUILDBOT_VERSION=3.1.0

pip3 install --upgrade pip && \
pip --no-cache-dir install twisted[tls] && \
pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

useradd --create-home --home-dir=/var/lib/buildbot buildbot
