#!/bin/sh
#########################################################################
# 初始化docker以外的东西
# 要在当前目录运行 如 ./stop.sh dev
# 支持 dev test beta prod
#########################################################################


if [ $# -lt 1 ]; then
	echo "Please Refer the ENV \n";
	exit;
fi
ENV=$1;

#stop docker-compose
/usr/local/bin/docker-compose -f docker-compose_$ENV.yml down

