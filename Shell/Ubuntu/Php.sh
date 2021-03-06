#!/bin/bash

###############
# Name: 安装 Php 多版本
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/VGuW5dDf > /tmp/Php && bash /tmp/Php
###############

### 导入密钥
apt-key list | grep "E5267A6C" > /dev/null 2>&1
[ $? -ne 0 ] && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

### 设置镜像源
PhpMirror=${PhpMirror:-"deb http://ppa.launchpad.net/ondrej/php/ubuntu/ $(lsb_release -sc) main"}
echo "${PhpMirror}" | tee /etc/apt/sources.list.d/php.list
apt-get -y update

### 设置变量
modules=(
    "cli" "common" "fpm" "dev" "mysql" "sqlite3" "curl" "gd" "mbstring" "json" "ldap" "opcache"
    "pgsql" "readline" "bcmath" "mcrypt" "soap" "zip" "xml"
)
versions=("5.6" "7.2")
packages=()
installs=()

### 获取安装的软件
for version in ${versions[@]}
do
    packages=(${packages[*]} "php${version}" "libapache2-mod-php${version}")
    for module in ${modules[@]}
    do
        packages=(${packages[*]} "php${version}-${module}")
    done
done

### 清理已经安装的软件和不存在的软件包
for package in ${packages[@]}
do
    dpkg -l ${package} > /dev/null 2>&1
    [ $? -eq 0 ] && continue
    apt-cache show ${package} > /dev/null 2>&1
    [ $? -ne 0 ] && continue
    installs=(${installs[*]} ${package})
done

### 安装软件
if [ ${#installs[@]} -ne 0 ]; then
    echo ">>> Installs: ${installs[*]}"
    apt-get install -y ${installs[*]}
    [ $? -ne 0 ] && exit 1
fi

### 选择主版本
[ "${PhpMainVersion}" == "" ] && PhpMainVersion=${versions[0]}

### 设置 Apache
apache2 -v > /dev/null 2>&1
if [ $? -eq 0 ]; then
    for version in ${versions[@]}
    do
        a2dismod "php${version}"
    done
    a2enmod php${PhpMainVersion}
    service apache2 restart
fi

# 设置 Cli
update-alternatives --set php /usr/bin/php${PhpMainVersion}
update-alternatives --set phpize /usr/bin/phpize${PhpMainVersion}
update-alternatives --set php-config /usr/bin/php-config${PhpMainVersion}

# 删除配置文件
rm -rf /etc/apt/sources.list.d/php.list
