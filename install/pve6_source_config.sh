#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'


APT_SOURCES_DIR="/etc/apt/sources.list.d"
USTC_CEPH_SOURCE="deb https://mirrors.ustc.edu.cn/proxmox/debian/ceph-quincy buster no-subscription"
USTC_ENTERPRISE_SOURCE="deb https://mirrors.tuna.tsinghua.edu.cn/proxmox/debian buster pve-no-subscription"

# backup /etc/apt/sources.list.d
if [ ! -e "${APT_SOURCES_DIR}.ori" ]; then
  echo -e "back ${APT_SOURCES_DIR}"
  cp -r ${APT_SOURCES_DIR} "${APT_SOURCES_DIR}.ori"
fi

# remove pve-enterprise.list
if [ -e "${APT_SOURCES_DIR}/pve-enterprise.list" ]; then
	rm -rf "${APT_SOURCES_DIR}/pve-enterprise.list"
fi

# backup /etc/apt/sources.list
if [ ! -e /etc/apt/sources.list.ori ]; then
 cp /etc/apt/sources.list /etc/apt/sources.list.ori
fi

cat << _EOF_ > /etc/apt/sources.list
deb http://archive.debian.org/debian/ buster main contrib non-free
deb http://archive.debian.org/debian buster-updates main contrib non-free
# deb http://archive.debian.org/debian-security buster-security main contrib non-free
_EOF_


# echo "deb https://mirrors.ustc.edu.cn/proxmox/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list
DEBIAN_PVE_NO_SUBSCRIPTION="deb https://mirrors.ustc.edu.cn/proxmox/debian/pve buster pve-no-subscription"
echo "${DEBIAN_PVE_NO_SUBSCRIPTION}" > 	/etc/apt/sources.list.d/pve-no-subscription.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1140AF8F639E0C39
