#!/usr/bin/env bash

if [ ! -e /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg ]; then
  wget http://mirrors.ustc.edu.cn/proxmox/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg
fi

if [ ! -e /etc/apt/sources.list.d/pve-install-repo.list ]; then
  echo "deb http://mirrors.ustc.edu.cn/proxmox/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
fi

