FROM ubuntu:xenial
MAINTAINER CPressland <mail@cpressland.io>

ADD root /

RUN addgroup --gid 1550 apps && \
 adduser --system --no-create-home --uid 1550 --gid 1550 apps && \
 apt-get update && \
 apt-get -y upgrade && \
 apt-get -y install curl git python && \
 curl -L 'https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz' -o /tmp/s6-overlay-amd64.tar.gz && \
 tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
 git clone https://github.com/theotherp/nzbhydra.git /usr/local/bin/nzbhydra/ && \
 chown -R apps:apps /usr/local/bin/nzbhydra/ && \
 apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/init"]
