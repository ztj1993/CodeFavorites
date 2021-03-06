#!/bin/bash

###############
# Name: 设置允许 Root SSH
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/Y1PxZtyb > /tmp/AllowRootSsh && bash /tmp/AllowRootSsh
###############

### 设置 Root 用户密码
[ "${RootNewPwd}" == "" ] && echo -en ">>> Please enter the new root user password: "
[ "${RootNewPwd}" == "" ] && read RootNewPwd

### 安装必要软件
apt-get install -y openssh-server
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1

### 设置允许 Root 登陆
sed -i "s@^#PermitRootLogin.*@PermitRootLogin yes@" /etc/ssh/sshd_config
sed -i "s@^PermitRootLogin.*@PermitRootLogin yes@" /etc/ssh/sshd_config
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
sed -i "s@^PasswordAuthentication.*@PasswordAuthentication yes@" /etc/ssh/sshd_config
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1

### 生成密钥
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure openssh-server
    [ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
fi

### 重启 SSH
/etc/init.d/ssh restart
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1

### 重置 Root 用户密码
[ -n "${RootNewPwd}" ] && echo root:${RootNewPwd} | chpasswd &&
[ $? -ne 0 ] && echo ">>>>>> Error:$(basename ${BASH_SOURCE[0]%.*}) - ($LINENO)" && exit 1
