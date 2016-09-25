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

ENV MURMUR_VERSION=1.2.16

# Make sure we don't get notifications we can't answer during building
ENV DEBIAN_FRONTEND noninteractive

VOLUME ["/data"]

# Forward apporpriate ports
EXPOSE 64738/tcp 64738/udp

# Download and install the required packages
RUN apt-get update \
    && apt-get install apt-utils -y \
    && apt-get install wget -y \
    && apt-get install bzip2 -y

# Download and install murmur
RUN wget -O /murmur.tar.bz2 https://github.com/mumble-voip/mumble/releases/download/$MURMUR_VERSION/murmur-static_x86-$MURMUR_VERSION.tar.bz2 \
    && bzip2 -d /murmur.tar.bz2 \
    && tar -xvf /murmur.tar \
    && mv /murmur-static_x86-$MURMUR_VERSION /murmur \
    && rm /murmur.tar

COPY ./config/murmur.ini /murmur.ini.sample
COPY ./start.sh /start

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/start"]