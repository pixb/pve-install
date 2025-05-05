#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

function apt_install() {
  if command -v "$1" &>/dev/null; then
    echo -e "${COLOR_GREEN}$1 is installed${COLOR_NC}"
  else
    echo -e "${COLOR_YELLOW}$1 is not install${COLOR_NC}"
    sudo apt install "$1" -y
  fi
}

apt_install zlib1g-dev
apt_install libssl-dev
apt_install libffi-dev
apt_install libbz2-dev
apt_install libncurses5-dev
apt_install libreadline-dev
apt_install libsqlite3-dev
apt_install liblzma-dev

if [ -d "${HOME}"/.pyenv ]; then
  echo -e "${COLOR_GREEN}pyenv is installed${COLOR_NC}"
  export PATH=$HOME/.pyenv/bin:$PATH
  eval "$(pyenv init -)"
  pyenv install 3.13.0
  pyenv global 3.13.0
else
  echo -e "${COLOR_YELLOW}pyenv is not install${COLOR_NC}"
  git clone https://github.com/pyenv/pyenv.git "${HOME}"/.pyenv
  export PATH=$HOME/.pyenv/bin:$PATH
  eval "$(pyenv init -)"
  pyenv install 3.13.0
  pyenv global 3.13.0
fi
if command -v python3 >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}$(python3 --version) is installed${COLOR_NC}"
  if [ -d "${HOME}/.venv" ]; then
    echo -e "${COLOR_GREEN}${HOME}/.venv is exists.${COLOR_NC}"
    source "${HOME}/.venv/bin/activate"
  else
    echo -e "${COLOR_YELLOW}${HOME}/.venv is not exists.${COLOR_NC}"
    python3 -m venv "${HOME}/.venv"
    source "${HOME}/.venv/bin/activate"
  fi
else
  echo -e "${COLOR_YELLOW} python3 is not install${COLOR_NC}"
  pyenv install 3.13.0
  pyenv global 3.13.0
fi
