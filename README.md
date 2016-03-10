docker-murmur
=============

A murmur (mumble server) image for docker.

## Build

```bash
git clone git@github.com:jpchateau/docker-murmur.git
cd docker-murmur
docker build -t jpchateau/docker-murmur .
```

## Usage

```bash
mkdir /home/$USER/murmur
docker run -d --name murmur -p 64738:64738 -p 64738:64738/udp -v /home/$USER/murmur:/data jpchateau/docker-murmur
```
