#!/usr/bin/env bash

# if [ ! -e /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg ]; then
#   wget http://mirrors.ustc.edu.cn/proxmox/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg
# fi
# 
# if [ ! -e /etc/apt/sources.list.d/pve-install-repo.list ]; then
#   echo "deb http://mirrors.ustc.edu.cn/proxmox/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
# fi
# 
# if [ ! -e /etc/apt/sources.list.d/pve-no-subscription.list.bak ]; then
#   mv /etc/apt/sources.list.d/pve-no-subscription.list /etc/apt/sources.list.d/pve-no-subscription.list.bak
# fi
# 
# if [ -e /etc/apt/sources.list.d/ceph.list ]; then
#   mv /etc/apt/sources.list.d/ceph.list /etc/apt/sources.list.d/ceph.list.bak
# fi
# echo "deb https://mirrors.ustc.edu.cn/proxmox/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list
DEBIAN_PVE_NO_SUBSCRIPTION="deb https://mirrors.ustc.edu.cn/proxmox/debian/pve trixie pve-no-subscription"
echo "${DEBIAN_PVE_NO_SUBSCRIPTION}" > 	/etc/apt/sources.list.d/pve-no-subscription.list

cat << _EOF_ > /etc/apt/sources.list
deb https://mirrors.ustc.edu.cn/debian trixie main contrib non-free
deb https://mirrors.ustc.edu.cn/debian trixie-updates main contrib non-free
deb https://mirrors.ustc.edu.cn/debian-security trixie-security main contrib non-free
_EOF_
