#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if [ -e /etc/modules ]; then
  if [ ! -e /etc/modules.bak ]; then
    cp /etc/modules /etc/modules.bak
  fi

  if ! grep -w "^vfio$" /etc/modules &> /dev/null; then 
    echo -e "${COLOR_YELLOW}vfio don't exists${COLOR_NC}"
    echo "vfio" >> /etc/modules 
  fi

  if ! grep -w "^vfio_iommu_type1$" /etc/modules &> /dev/null; then 
    echo -e "${COLOR_YELLOW}vfio_iommu_type1 don't exists${COLOR_NC}"
    echo "vfio_iommu_type1" >> /etc/modules 
  fi

  if ! grep -w "^vfio_pci$" /etc/modules &> /dev/null; then 
    echo -e "${COLOR_YELLOW}vfio_pci don't exists${COLOR_NC}"
    echo "vfio_pci" >> /etc/modules 
  fi

  if ! grep -w "^vfio_virqfd$" /etc/modules &> /dev/null; then 
    echo -e "${COLOR_YELLOW}vfio_virqfd don't exists${COLOR_NC}"
    echo "vfio_virqfd" >> /etc/modules 
  fi

fi
