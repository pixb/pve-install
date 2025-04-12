#!/bin/env bash

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if [ -e /etc/modprobe.d/blacklist.conf ]; then
  if [ ! -e /etc/modprobe.d/blacklist.conf ]; then
    mv /etc/modprobe.d/blacklist.conf /etc/modprobe.d/blacklist.conf.bak
  fi
else
  cp ./config/blacklist.conf //etc/modprobe.d/
fi
