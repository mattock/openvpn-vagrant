FROM buildbot/buildbot-master:v3.1.0

MAINTAINER OpenVPN Community Project

EXPOSE 8010/tcp
EXPOSE 9989/tcp

ENV BASEDIR=/var/lib/buildbot/masters/default
RUN mkdir -p $BASEDIR

COPY start_buildmaster.sh $BASEDIR
COPY master.cfg $BASEDIR
COPY buildbot.tac $BASEDIR

WORKDIR $BASEDIR

CMD dumb-init $BASEDIR/start_buildmaster.sh
