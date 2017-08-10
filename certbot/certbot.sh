#!/bin/bash
if [ -z  ${CERTBOT_EMAIL} ] || [ -z ${CERTBOT_DOMAIN} ]
then
    echo "Email and domain needed for CERTBOT"
else
  echo "Creating let's encrypt certificate"
  certbot --apache -m ${CERTBOT_EMAIL} -d ${CERTBOT_DOMAIN} --redirect --agree-tos --non-interactive
  echo "Creating a cron task to renew the certificate"
  mv /certbot.cron /etc/cron.daily/certbot
	echo "Success"
fi
