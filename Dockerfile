FROM ubuntu:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dean Holland <speedster@haveacry.com>" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Haveacry/docker-bedrock" \
      org.label-schema.build-date=$BUILD_DATE

ADD start.sh /root/start.sh
ADD update.sh /root/update.sh

RUN sed -i -e "s/archive\.ubuntu\.com/au\.archive\.ubuntu\.com/g" /etc/apt/sources.list && \
    DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    cron \
    ffmpeg \
    openssl \
    wget \
    libcgi-pm-perl \
    libmojolicious-perl \
    liblwp-protocol-https-perl \
    libxml-simple-perl \
    libxml-libxml-perl && \
    chmod 755 /root/start.sh && \
    chmod 755 /root/update.sh && \
    echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" > /root/cron.tab && \
    echo "@hourly /root/get_iplayer --refresh 2>&1" >> /root/cron.tab && \
    echo "@hourly /root/get_iplayer --pvr 2>&1" >> /root/cron.tab && \
    echo "@daily /root/update.sh 2>&1" >> /root/cron.tab && \
    crontab /root/cron.tab && \
    rm -f /root/cron.tab

VOLUME /root/.get_iplayer
VOLUME /root/output

LABEL issues_get_iplayer="Comments/issues for get_iplayer: https://forums.squarepenguin.co.uk"
LABEL issues_kolonuk/get_iplayer="Comments/issues for this Dockerfile: https://github.com/speedst3r/get_iplayer-docker/issues"
LABEL maintainer="Dean Holland <speedster@haveacry.com>"

EXPOSE 8181:8181

ENTRYPOINT ["/bin/bash", "/root/start.sh"]
