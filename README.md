# pve config script

first clone repo

```c
git clone https://github.com/pixb/pve-install.git
```

use `root` user exec

## 1.pve_source_config.sh

- configure ceph.list to ustc soruce
- configure pve-enterprise.list to tsinghua soruce

```c
bash pve_source_config.sh
apt update -y
apt upgrade -y
```
## 2.install base package

```c
bash pve_init.sh
```
## 3.config vimrc

```c
bash vim_config.sh
```

## 4.install neovim

```c
bash neovim_install.sh
```

## 5.核显直通

```c
bash iommu_grub_open.sh
bach blacklist_add.sh
```
