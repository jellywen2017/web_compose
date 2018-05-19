#!/bin/sh
#########################################################################
# 初始化docker以外的东西
# 要在当前目录运行 如 ./init.sh dev
# 支持 dev test beta prod
#########################################################################


if [ $# -lt 1 ]; then
	echo "Please Refer the ENV dev or test or beta or prod \n";
	exit;
fi
ENV=$1; 

#docker 入口脚本增加可执行权限
chmod +x ./web/start_$ENV.sh


#启动docker-compose
/usr/local/bin/docker-compose -f docker-compose_$ENV.yml up -d

