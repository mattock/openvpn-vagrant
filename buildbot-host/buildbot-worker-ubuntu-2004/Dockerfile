FROM buildbot/buildbot-worker:v3.1.0

MAINTAINER OpenVPN Community Project

COPY buildbot.tac /buildbot/

USER root

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /buildbot

# Install setup scripts shared by multiple containers
COPY scripts /buildbot/scripts/

RUN ls -la /buildbot

RUN set -ex; \
    /buildbot/scripts/install-openvpn-build-deps-ubuntu.sh; \
    rm -rf /buildbot/scripts
