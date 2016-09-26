# Docker-Murmur

[![](https://images.microbadger.com/badges/version/jpchateau/murmur.svg)](https://microbadger.com/images/jpchateau/murmur "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jpchateau/murmur.svg)](https://microbadger.com/images/jpchateau/murmur "Get your own image badge on microbadger.com")

## About Murmur

Murmur is a VoIP server for Mumble.

## About this image

This image intends to be stable and light.  
It is based on the latest stable debian release.

### Build

```bash
docker pull jpchateau/murmur
```
or
```bash
git clone git@github.com:jpchateau/docker-murmur.git
cd docker-murmur
docker build -t jpchateau/murmur .
```

### Usage

```bash
mkdir ~/murmur
docker run -d --name murmur -p 64738:64738 -p 64738:64738/udp -v ~/murmur:/data jpchateau/murmur
```

The mounted volume contains your server data (configuration and logs).
