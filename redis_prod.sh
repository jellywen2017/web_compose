#!/bin/sh
#启动 redis
docker run --name prod_jelly_web_redis -p 6379:6379 -d -e REDIS_PASSWORD=redis_prod redis:4.0 sh -c 'exec redis-server --requirepass "$REDIS_PASSWORD"'
