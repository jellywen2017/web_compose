#!/bin/sh
#########################################################################
# File Name: start.sh
# Author: jellywen
# Email:  jellywen@koudailc.com
# Version:
# Created Time: 2018/05/19
#########################################################################

#指定php环境为 dev
sed -i "s/env = test/env = prod/g" /usr/local/php/etc/php.ini

Nginx_Install_Dir=/usr/local/nginx
DATA_DIR=/data/www

set -e
chown -R www.www $DATA_DIR

#创建nginx 日志目录
mkdir -p /usr/local/nginx/logs

mkdir -p /data/logs
chown www:www /data/logs

#启用www用户
usermod -s /bin/bash www
#修改www的主目录
usermod -d /home/www www

mkdir -p /home/www/.ssh
chown www:www -R /home/www
chmod 700 /home/www/.ssh
#chmod 600 /home/www/.ssh/id_rsa

mkdir -p /root/.ssh

#允许以下公钥登陆
#jelly
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9OrMoS+jMc6Rv78YsGLkug5Wjde1/w9c97ujz9bV0tJXo/lCZ6fsgLwwaKkl0hnSKzWMSii8wDmfpMXcZzJcsxp1VJeZqDv/5Q/CfjmpLkAuXHhyCUNID/WpBvWG6sXO102unkJQTDPDHZj4tiiQpMx0wgD+eHhCwyZwS8hul9/7vjeqXZ98d76M88UN1EKoJrBMmtfPqORn848WLNt971cZ7rLcDqP96SXIjd6CYO2vivy8rvS8AZOqObS+EBzRaYqiQVvQgENDTqplkyEKwazgovTkP6U6TpjfIQlk8Bk6Xn7uL/dSyDrlXD0M+145jFinGFFJX/uOQ8mVi8K63 jellywen@koudailc.com" >> /root/.ssh/authorized_keys

#修复中文乱码(直接登录)
echo "export LC_ALL=zh_CN.utf8" >> /root/.bash_profile

chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

rm -rf /etc/ssh/ssh_host_rsa_key
rm -rf /etc/ssh/ssh_host_ecdsa_key
rm -rf /etc/ssh/ssh_host_ed25519_key

ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
/usr/sbin/sshd

#修复中文乱码
localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 
export LC_ALL=zh_CN.utf8

#增加软连接
rm -rf /usr/local/bin/php
ln -s /usr/local/php/bin/php /usr/local/bin/php

#校准时间
\cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# #安装logtail华东2区
# wget http://logtail-release-sh.vpc100-oss-cn-shanghai.aliyuncs.com/linux64/logtail.sh; chmod 755 logtail.sh; sh logtail.sh install cn_shanghai_vpc
# touch /etc/ilogtail/users/1913515450663617
# touch /etc/ilogtail/user_defined_id
# #kd_credit 用户自定义标识
# echo "jelly_web" >> /etc/ilogtail/user_defined_id
# #启动服务
# /etc/init.d/ilogtaild start

#启动crond 放在修改时区后 否则要重启
/usr/sbin/crond start

#更新git时不会提示yes/no
echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 

#开启nginx php-fpm 服务
/usr/bin/supervisord -n -c /etc/supervisord.conf
