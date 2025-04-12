#!/bin/env bash

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

GRUB_NEW_INFO="quiet intel_iommu=on iommu=pt pcie_acs_override=downstream video=efifb:off,vesafb:off"

if [ ! -e /etc/default/grub.bak ]; then
  echo -e "${COLOR_YELLOW}grub bak file don't exists. create it.${COLOR_NC}"
  cp /etc/default/grub /etc/default/grub.bak
else
  echo -e "${COLOR_GREEN}grub bak file exists.${COLOR_NC}"
fi

if [ -e /etc/default/grub ]; then
  echo -e "${COLOR_GREEN}grub file open iommu.${COLOR_NC}"
  sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT="\).*\(".*\)/\1quiet intel_iommu=on iommu=pt pcie_acs_override=downstream video=efifb:off,vesafb:off\2/' /etc/default/grub
fi
