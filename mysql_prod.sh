#!/bin/sh
#启动 mysql
docker run --name prod_jelly_web_mysql -p 3306:3306 -v /data/docker/mysql/3306:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mysql_prod -d mysql:5.7

#启动后 直接用 root/mysql_prod 即可登录修改
