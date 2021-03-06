#!/bin/bash

###############
# Name: 制作本地源
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/BFLKMuNv > /tmp/AptMirror && bash /tmp/AptMirror
###############

### 设置本地源路径
[ "${AptMirrorPath}" == "" ] && echo -en ">>> Please enter the apt local path: "
[ "${AptMirrorPath}" == "" ] && read AptMirrorPath
AptMirrorPath=${AptMirrorPath:-/var/spool/apt-mirror}

### 安装软件
type apt-mirror > /dev/null 2>&1
[ $? -ne 0 ] && apt-get install -y apt-mirror

### 设置配置文件
echo "
set base_path ${AptMirrorPath}
set run_postmirror 0
set nthreads 20
set _tilde 0
" | tee /etc/apt/mirror.list

### 设置文件存储路径
[ ! -d ${AptMirrorPath} ] && mkdir -p ${AptMirrorPath}
[ ! -d ${AptMirrorPath}/mirror ] && cp -fR /var/spool/apt-mirror/* ${AptMirrorPath}

##########################################################

[ ${AptMirrorSkip} ] && exit 0

### 设置远程源路径
[ "${AptMirrorDeb}" == "" ] && echo -en ">>> Please enter the deb: "
[ "${AptMirrorDeb}" == "" ] && read AptMirrorDeb
[ "${AptMirrorDeb}" == "" ] && exit 0

### 设置镜像源
echo "${AptMirrorDeb}" | tee -a /etc/apt/mirror.list

### 克隆镜像
apt-mirror

### 移除镜像源
sed "/${AptMirrorDeb//\//\\\/}/,+2d" /etc/apt/mirror.list
   