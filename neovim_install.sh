#!/bin/bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if [ ! -d ./res ]; then
	mkdir -p ./res
fi

curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o ./res/nvim.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf ./res/nvim.tar.gz
ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim
