FROM ubuntu:15.10
MAINTAINER Jean-Philippe Chateau "contact@jpchateau.com"

# Murmur version
ENV version=1.2.15

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
RUN wget -O /murmur.tar.bz2 https://github.com/mumble-voip/mumble/releases/download/${version}/murmur-static_x86-${version}.tar.bz2 \
    && bzip2 -d /murmur.tar.bz2 \
    && tar -xvf /murmur.tar \
    && mv /murmur-static_x86-${version} /murmur \
    && rm /murmur.tar

COPY ./Resources/murmur.ini /murmur.ini.sample
COPY ./Resources/start.sh /start

# Fix all permissions
RUN chmod +x /start

CMD ["/start"]
