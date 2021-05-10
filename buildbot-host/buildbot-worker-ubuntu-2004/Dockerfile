FROM ubuntu:20.04

MAINTAINER OpenVPN Community Project
COPY buildbot.tac /buildbot/
USER root
WORKDIR /buildbot

COPY scripts/install-openvpn-build-deps-ubuntu.sh /buildbot/


RUN set -ex; \
    /buildbot/install-openvpn-build-deps-ubuntu.sh; \
    rm -f install-openvpn-build-deps-ubuntu.sh

COPY scripts/install-mbedtls.sh /buildbot/
RUN set -ex; \
    /buildbot/install-mbedtls.sh; \
    rm -f /buildbot/install-mbedtls.sh

RUN set -ex; \
    rm -rf /buildbot/scripts
