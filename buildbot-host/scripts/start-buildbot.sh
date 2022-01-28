#!/bin/sh
#
# Small script for launching buildbot worker outside of Docker
#
BUILDMASTER="${BUILDMASTER:-192.168.58.114}"
WORKERNAME="${WORKERNAME:-ubuntu-2004-vm-static}"
WORKERPASS="${WORKERPASS:-vagrant}"

export BUILDMASTER
export WORKERNAME
export WORKERPASS

cd /buildbot
twistd3 --pidfile --nodaemon --python=buildbot.tac
