#!/bin/sh
#
# Ensure that the container has a tun device. Package "iproute2" is required
# for this to work.
#
if ! [ -f "/dev/net/tun" ] && [ -f "/.dockerenv" ]; then
  mkdir /dev/net
  mknod /dev/net/tun c 10 200
  ip tuntap add mode tap tap
fi
