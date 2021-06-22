ARG MY_NAME="buildmaster"
ARG MY_VERSION="v2.0.0"
ARG IMAGE=buildbot/buildbot-master:v3.1.0

FROM $IMAGE

LABEL maintainer="OpenVPN Community Project"

EXPOSE 8010/tcp
EXPOSE 9989/tcp

ENV BASEDIR=/var/lib/buildbot/masters/default
RUN mkdir -p $BASEDIR

# Required for latent docker buildslaves
RUN pip3 install docker
RUN set -ex; \
    apk add patch

COPY buildmaster/buildbot.tac $BASEDIR
COPY buildmaster/start_buildmaster.sh $BASEDIR
COPY buildmaster/master.cfg $BASEDIR
COPY buildmaster/master.ini $BASEDIR
COPY buildmaster/worker.ini $BASEDIR
COPY buildmaster/vstudio.py.patch $BASEDIR
COPY buildmaster/msbuild-x64.bat $BASEDIR
COPY buildmaster/msbuild-x64_x86.bat $BASEDIR
COPY buildmaster/msbuild-x64_arm64.bat $BASEDIR

RUN set -ex; \
    patch /usr/lib/python3.8/site-packages/buildbot/steps/vstudio.py $BASEDIR/vstudio.py.patch

COPY scripts/ensure-tun-is-present.sh $BASEDIR

WORKDIR $BASEDIR

CMD dumb-init $BASEDIR/start_buildmaster.sh
