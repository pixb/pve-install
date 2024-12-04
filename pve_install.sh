#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if ! command -v sudo &> /dev/null; then
  echo -e "${COLOR_YELLOW}sudo is not install${COLOR_NC}"
  sudo apt update  && sudo apt install -y sudo
else
  echo -e "${COLOR_GREEN}sudo is installed${COLOR_NC}"
fi

if ! command -v zsh &> /dev/null; then
  echo -e "${COLOR_YELLOW}zsh is not install${COLOR_NC}"
  sudo apt update  && sudo apt install -y zsh
else
  echo -e "${COLOR_GREEN}sudo is installed${COLOR_NC}"
fi

if ! command -v git &> /dev/null; then
  echo -e "${COLOR_YELLOW}git is not install${COLOR_NC}"
  sudo apt update  && sudo apt install -y git
else
  echo -e "${COLOR_GREEN}git is installed${COLOR_NC}"
fi
if [ -d ${HOME}/dev/linux-demo ]; then
  echo -e "${COLOR_GREEN}${HOME}/dev/linux-demo is exists${COLOR_NC}"
else
  echo -e "${COLOR_GREEN}${HOME}/dev/linux-demo is not exists${COLOR_NC}"
  git clone git@github.com:pixb/linux-demo.git ${HOME}/dev/linux-demo
fi

if ! command -v rcm &> /dev/null; then
  echo -e "${COLOR_YELLOW}rcm is not install${COLOR_NC}"
  sudo apt update  && sudo apt install -y rcm
else
  echo -e "${COLOR_GREEN}rcm is installed${COLOR_NC}"
fi

if [ -d ${HOME}/.dotfiles ]; then
  echo -e "${COLOR_GREEN}${HOME}/.dotfiles is exists${COLOR_NC}"
else
  echo -e "${COLOR_GREEN}${HOME}/.dotfiles is not exists${COLOR_NC}"
  git clone git@github.com:pixb/.dotfiles.git ${HOME}/.dotfiles
fi
cd ${HOME}
rcup -t rcm
rcup
