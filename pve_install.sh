#!/usr/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if ! command -v git &>/dev/null; then
  echo -e "${COLOR_YELLOW}git is not install${COLOR_NC}"
  sudo apt update && sudo apt install -y git
else
  echo -e "${COLOR_GREEN}git is installed${COLOR_NC}"
fi
if [ -d ${HOME}/dev/linux-demo ]; then
  echo -e "${COLOR_GREEN}${HOME}/dev/linux-demo is exists${COLOR_NC}"
else
  echo -e "${COLOR_GREEN}${HOME}/dev/linux-demo is not exists${COLOR_NC}"
  git clone git@github.com:pixb/linux-demo.git ${HOME}/dev/linux-demo
fi

if ! command -v rcup &>/dev/null; then
  echo -e "${COLOR_YELLOW}rcm is not install${COLOR_NC}"
  sudo apt update && sudo apt install -y rcm
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

# proxy
#http_proxy=http://192.168.123.187:10809
#https_proxy=http://192.168.123.187:10809
#ftp_proxy=http://192.168.123.187:10809
#export http_proxy
#export ftp_proxy
#export https_proxy

if [ -d ${HOME}/.pyenv ]; then
  echo -e "${COLOR_GREEN}pyenv is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}pyenv is not install${COLOR_NC}"
  git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv
  export PATH=$HOME/.pyenv/bin:$PATH
  eval "$(pyenv init -)"
fi
if command -v python3 >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}$(python3 --version) is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW} python3 is not install${COLOR_NC}"
  pyenv install 3.13.0
  pyenv global 3.13.0
fi

# install neovim
# Download latest neovim release from GitHub releases and pipe it to tar to extract it to /usr
if command -v nvim >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}neovim is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}neovim is not install${COLOR_NC}"
  curl -sL https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.tar.gz |
    sudo tar -xzf - --strip-components=1 --overwrite -C /usr
fi

if command -v node >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}nodejs is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}nodejs is not install${COLOR_NC}"
  sudo apt install -y nodejs
fi

if command -v npm >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}npm is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}npm is not install${COLOR_NC}"
  sudo apt install -y npm
  sudo npm install -g neovim
fi

if command -v fd >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}fd is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}fd is not install${COLOR_NC}"
  sudo apt install -y fd-find
fi
if command -v yarn >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}yarn is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}yarn is not install${COLOR_NC}"
  sudo apt install -y yarn
  sudo yarn global add neovim
fi

if command -v rg >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}ripgrep is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}ripgrep is not install${COLOR_NC}"
  sudo apt install -y ripgrep
fi

if command -v lazygit >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}lazygit is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}lazygit is not install${COLOR_NC}"
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
fi

if [ -d ${HOME}/.config/nvim ]; then
  echo "${COLOR_GREEN}${HOME}/.config/nvim is exists${COLOR_NC}"
else
  echo "${COLOR_YELLOW}${HOME}/.config/nvim is not exists${COLOR_NC}"
  git clone https://github.com/pixb/nvimlua.git ${HOME}/.config/nvim
fi

if [ -d ${HOME}/dev/vimrc ]; then
  echo "${COLOR_GREEN}${HOME}/dev/vimrc is exists${COLOR_NC}"
else
  echo "${COLOR_YELLOW}${HOME}/dev/vimrc is not exists${COLOR_NC}"
  git clone git@github.com:pixb/vimrc.git ${HOME}/dev/vimrc
  ln -sf ${HOME}/dev/vimrc/vimrc ${HOME}/.vimrc
fi
