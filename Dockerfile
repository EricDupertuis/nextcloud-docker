FROM php:apache

ENV CERTBOT_DOMAIN=""
ENV CERTBOT_EMAIL=""

RUN echo "deb http://ftp.debian.org/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list

RUN apt-get update

# Get certbot (Let's Encrypt client) from Jessie Backports

RUN apt-get install -t jessie-backports -y certbot

# Nextcloud req

RUN apt-get install -y \
	python-certbot-apache \
	wget \
	bzip2 \
	zip zlib1g-dev \
	php5-gd libpng-dev \
	php5-mysql \
  php5-pgsql \
  libpq-dev

# Install php extensions

RUN docker-php-ext-install zip gd mysqli pgsql pdo_mysql

WORKDIR /var/www/html

RUN wget "https://download.nextcloud.com/server/releases/latest.tar.bz2"
RUN tar -jxvf latest.tar.bz2 --strip-components=1
RUN rm latest.tar.bz2

COPY /certbot/certbot.sh /certbot.sh
COPY /certbot/certbot.cron /certbot.cron

RUN chmod u+x /certbot.sh
RUN chmod u+x /certbot.cron

RUN chown -R www-data /var/www/html

VOLUME /var/www/html/data
VOLUME /var/www/html/config

EXPOSE 80
EXPOSE 443
