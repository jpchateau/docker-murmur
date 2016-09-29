# Docker-Murmur

[![@jpchateau on Twitter](http://img.shields.io/badge/twitter-%40jpchateau-blue.svg?style=flat)](https://twitter.com/jpchateau) [![Build Status](https://travis-ci.org/jpchateau/docker-murmur.svg?branch=master)](https://travis-ci.org/jpchateau/docker-murmur) [![](https://images.microbadger.com/badges/version/jpchateau/murmur.svg)](https://microbadger.com/images/jpchateau/murmur "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jpchateau/murmur.svg)](https://microbadger.com/images/jpchateau/murmur)

Murmur is a VoIP server for Mumble.

## About this image

This image intends to be stable and light.  
It is based on the latest stable debian release.
It provides additional configuration.

* [Mumble 1.2.17](https://wiki.mumble.info/wiki/Main_Page)

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
docker run -d --name murmur -p 64738:64738 -p 64738:64738/udp -v ~/path/to/data:/data jpchateau/murmur
```

The mounted volume contains your server data (configuration and logs).


## Changelog

See the original changelog here: http://blog.mumble.info/mumble-1-2-17
