# web_compose
个人网站docker compose
centos7 php7 nginx

=====执行初始步骤=====

1.服务器上clone代码
git clone git@github.com:jellywen2017/web_compose.git

2.进入web_compose目录 初始化容器
./init.sh prod

3.初始化mysql容器
./mysql_prod.sh

4.初始化redis容器
./redis_prod.sh

5.进入容器
docker exec -it jelly-web-prod bash

8.增加拉取gitlab代码私钥(方便后续在容器里直接拉取github上代码)
su www
touch /home/www/.ssh/id_rsa
chmod 600 /home/www/.ssh/id_rsa
echo "个人git私钥" >> /home/www/.ssh/id_rsa


