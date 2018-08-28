#!/bin/bash

###############
# Name: 制作本地源
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/BFLKMuNv > /tmp/AptMirror && bash /tmp/AptMirror
###############

### 设置本地源路径
[ "${AptMirrorBasePath}" == "" ] && echo -en ">>> Please enter the base path: "
[ "${AptMirrorBasePath}" == "" ] && read AptMirrorBasePath
AptMirrorBasePath=${AptMirrorBasePath:-/var/spool/apt-mirror}

### 安装软件
type apt-mirror > /dev/null 2>&1
[ $? -ne 0 ] && sudo apt-get install -y apt-mirror

### 设置配置文件
echo "
set base_path ${AptMirrorBasePath}
set run_postmirror 0
set nthreads 20
set _tilde 0
" | sudo tee /etc/apt/mirror.list

### 设置文件存储路径
[ ! -d ${AptMirrorBasePath} ] && sudo mkdir -p ${AptMirrorBasePath}
[ ! -d ${AptMirrorBasePath}/mirror ] && sudo cp -fR /var/spool/apt-mirror/* ${AptMirrorBasePath}

##########################################################

[ ${AptMirrorSkip} ] && exit 0

### 设置远程源路径
[ "${AptMirrorBaseDeb}" == "" ] && echo -en ">>> Please enter the apt mirror uri: "
[ "${AptMirrorBaseDeb}" == "" ] && read AptMirrorBaseDeb
[ "${AptMirrorBaseDeb}" == "" ] && exit 0

### 设置镜像源
echo "${AptMirrorBaseDeb}" | sudo tee -a /etc/apt/mirror.list

### 克隆镜像
sudo apt-mirror

### 移除镜像源
sed "/${AptMirrorBaseDeb//\//\\\/}/,+2d" /etc/apt/mirror.list
   