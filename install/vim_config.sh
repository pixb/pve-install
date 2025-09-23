#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if [ -d "./res/vimrc" ]; then
  echo -e "${COLOR_GREEN}echo vimrc is exists${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}echo vimrc is not exists${COLOR_NC}"
  git clone https://github.com/pixb/vimrc.git "./res/vimrc"
fi

if [ -e "./res/vimrc/vimrc" ]; then
  ln -sf "${HOME}/dev/pve-install/res/vimrc/vimrc" "${HOME}"/.vimrc
fi
