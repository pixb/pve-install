#!/usr/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if ! command -v sudo &> /dev/null; then
    echo -e "${COLOR_YELLOW}sudo is not install${COLOR_NC}"
    apt update  && apt install -y sudo
else
    echo -e "${COLOR_GREEN}sudo is installed${COLOR_NC}"
fi

if ! command -v zsh &> /dev/null; then
    echo -e "${COLOR_YELLOW}zsh is not install${COLOR_NC}"
    apt update  && apt install -y zsh
else
    echo -e "${COLOR_GREEN}sudo is installed${COLOR_NC}"
fi

if ! command -v git &> /dev/null; then
    echo -e "${COLOR_YELLOW}git is not install${COLOR_NC}"
    apt update  && apt install -y git
else
    echo -e "${COLOR_GREEN}git is installed${COLOR_NC}"
fi

if ! command -v vim &> /dev/null; then
    echo -e "${COLOR_YELLOW}vim is not install${COLOR_NC}"
    apt update  && apt install -y vim
else
    echo -e "${COLOR_GREEN}vim is installed${COLOR_NC}"
fi
