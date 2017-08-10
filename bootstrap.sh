#!/bin/bash

docker build -t nextcloud-deploy .
docker run -d -it \
--name nextcloud \
--hostname hostname \
-e CERTBOT_DOMAIN=$1 \
-e CERTBOT_EMAIL=$2 \
-p 80:80 \
-p 443:443 \
-v nextcloud_home:/var/www/html \
-v nextcloud_apps:/var/www/html/custom_apps \
-v nextcloud_config:/var/www/html/config \
-v nextcloud_data:/var/www/html/data \
nextcloud-deploy
docker exec nextcloud /certbot.sh
