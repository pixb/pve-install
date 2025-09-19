#!/bin/env bash

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if [ -e ./res/pvetools8 ]; then
  rm -rf ./res/pvetools8
fi

git clone https://gitee.com/fanjinhong/pvetools8.git ./res/pvetools8
