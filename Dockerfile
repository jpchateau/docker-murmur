FROM ubuntu:15.10
MAINTAINER Jean-Philippe Chateau "contact@jpchateau.com"

# Murmur version to install
ENV version=1.2.15

# Make sure we don't get notifications we can't answer during building
ENV DEBIAN_FRONTEND noninteractive

# Download and install the required packages
RUN apt-get update \
    && apt-get install bzip2 -y 

VOLUME ["/data"]

# Download statically compiled murmur and install it to /opt/murmur
ADD https://github.com/mumble-voip/mumble/releases/download/${version}/murmur-static_x86-${version}.tar.bz2 /opt/

RUN bzip2 -d /opt/murmur-static_x86-${version}.tar.bz2 \
    && tar -xv -C /opt -f murmur-static_x86-${version}.tar \
    && mv /opt/murmur-static_x86-${version} /opt/murmur

COPY ./Resources/murmur.ini /etc/murmur.ini

# Forward apporpriate ports
EXPOSE 64738/tcp 64738/udp

# Run murmur
ENTRYPOINT ["/opt/murmur/murmur.x86", "-fg", "-v"]
CMD ["-ini", "/etc/murmur.ini"]
