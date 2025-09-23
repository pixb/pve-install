#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

# gpg
# backup gpg
if [ ! -e /etc/apt/trusted.gpg.d.bak.ori ]; then
  echo -e "${COLOR_YELLOW}trusted.gpg.d.bak.ori don't exists, create it.${COLOR_NC}"
  cp -r /etc/apt/trusted.gpg.d /etc/apt/trusted.gpg.d.bak.ori
fi

# download gpg
# wget https://mirrors.ustc.edu.cn/proxmox/debian/proxmox-release-trixie.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-trixie.gpg
# wget https://mirrors.ustc.edu.cn/proxmox/debian/pve/dists/trixie/Release.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-trixie.gpg
wget https://enterprise.proxmox.com/debian/proxmox-release-trixie.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-trixie.gpg

APT_SOURCES_DIR="/etc/apt/sources.list.d"
USTC_CEPH_SOURCE="deb https://mirrors.ustc.edu.cn/proxmox/debian/ceph-quincy bookworm no-subscription"
USTC_ENTERPRISE_SOURCE="deb https://mirrors.tuna.tsinghua.edu.cn/proxmox/debian trixie pve-no-subscription"

# ceph source
if [ ! -e ${APT_SOURCES_DIR}/ceph.list.bak ]; then
  echo -e "${COLOR_YELLO}ceph.list backup file don't exists. create it.${COLOR_NC}"
  mv ${APT_SOURCES_DIR}/ceph.list ${APT_SOURCES_DIR}/ceph.list.bak
else
  echo -e "${COLOR_GREEN} ceph.list backup file exists. configure new ceph.list${COLOR_NC}"
fi
echo "${USTC_CEPH_SOURCE}" > ${APT_SOURCES_DIR}/ceph.list

# pve enterprise source
if [ -e ${APT_SOURCES_DIR}/pve-enterprise.list ]; then
  echo -e "${COLOR_YELLO}pve-enterprise.list backup file create it.${COLOR_NC}"
  mv ${APT_SOURCES_DIR}/pve-enterprise.list ${APT_SOURCES_DIR}/pve-enterprise.list.bak
fi

# pve enterprise source
if [ -e ${APT_SOURCES_DIR}/pve-enterprise.sources ]; then
  echo -e "${COLOR_YELLO}pve-enterprise.sources backup file create it.${COLOR_NC}"
  mv ${APT_SOURCES_DIR}/pve-enterprise.sources ${APT_SOURCES_DIR}/pve-enterprise.sources.bak
fi

# pve-enterprise.list.dpkg-dist
if [ -e /etc/apt/sources.list.d/pve-enterprise.list.dpkg-dist ]; then
  mv /etc/apt/sources.list.d/pve-enterprise.list.dpkg-dist /etc/apt/sources.list.d/pve-enterprise.list.dpkg-dist.bak
fi
apt install ca-certificates -y
update-ca-certificates

