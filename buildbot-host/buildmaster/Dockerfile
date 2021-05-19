ARG MY_NAME="buildmaster"
ARG MY_VERSION="v2.0.0"
ARG IMAGE=buildbot/buildbot-master:v3.1.0

FROM $IMAGE

LABEL maintainer="OpenVPN Community Project"

EXPOSE 8010/tcp
EXPOSE 9989/tcp

ENV BASEDIR=/var/lib/buildbot/masters/default
RUN mkdir -p $BASEDIR

COPY buildmaster/start_buildmaster.sh $BASEDIR
COPY buildmaster/master.cfg $BASEDIR
COPY buildmaster/master.ini $BASEDIR
COPY buildmaster/worker.ini $BASEDIR
COPY buildmaster/buildbot.tac $BASEDIR

# Required for latent docker buildslaves
RUN pip3 install docker

WORKDIR $BASEDIR

CMD dumb-init $BASEDIR/start_buildmaster.sh
