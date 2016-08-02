FROM alpine:3.4
MAINTAINER CPressland <mail@cpressland.io>

RUN addgroup -g 1550 apps && \
 adduser -S -H -u 1550 -G apps apps && \
 apk --no-cache add python git tini && \
 git clone https://github.com/theotherp/nzbhydra.git /usr/local/bin/nzbhydra/ && \
 chown -R apps:apps /usr/local/bin/nzbhydra/ && \
 mkdir -p /config && \
 chown -R apps:apps /config && \
 rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

EXPOSE 5050
USER apps
VOLUME /config
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/local/bin/nzbhydra/nzbhydra.py", "--nobrowser", "--config", "/config/nzbhydra.cfg", "--database", "/config/nzbhydra.db"]
