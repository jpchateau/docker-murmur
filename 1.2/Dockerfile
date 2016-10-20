FROM debian:jessie

MAINTAINER Jean-Philippe Chateau "contact@jpchateau.com"

ENV GOSU_VERSION 1.9

RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

ENV MURMUR_VERSION 1.2.17

WORKDIR /tmp

RUN set -x \
    && apt-get update && apt-get install -y apt-utils wget bzip2 && rm -rf /var/lib/apt/lists/* \
    && wget -O murmur.tar.bz2 https://github.com/mumble-voip/mumble/releases/download/$MURMUR_VERSION/murmur-static_x86-$MURMUR_VERSION.tar.bz2 \
    && tar -xvjf murmur.tar.bz2 \
    && rm murmur.tar.bz2 \
    && apt-get purge -y --auto-remove apt-utils wget bzip2 \
    && mv murmur-static_x86-$MURMUR_VERSION murmur

VOLUME ["/data"]

EXPOSE 64738/tcp 64738/udp

COPY config/murmur.ini murmur/murmur.ini.sample
COPY docker-entrypoint.sh /
COPY start.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/start.sh"]