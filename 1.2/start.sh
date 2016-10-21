#!/bin/bash

set -e

if [ ! -f /data/murmur.log ]
then
    touch /data/murmur.log
fi

if [ ! -f /data/murmur.ini ]
then
    cp murmur.ini.sample /data/murmur.ini
fi

./murmur.x86 -fg -v -ini /data/murmur.ini