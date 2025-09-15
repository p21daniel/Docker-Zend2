FROM php:5.6-fpm-alpine

WORKDIR /usr/share/nginx/html

RUN apk update && apk upgrade
RUN apk add build-base linux-headers wget curl git nano zip bash
RUN apk add libzip-dev icu-dev libcurl curl-dev libxml2 libxml2-dev oniguruma-dev libpng-dev autoconf

RUN docker-php-ext-install mysqli pdo pdo_mysql zip intl sockets curl xml mbstring gd
RUN docker-php-ext-enable pdo_mysql zip intl opcache

RUN pecl install xdebug-2.5.4
RUN pecl install redis-4.3.0
RUN docker-php-ext-enable xdebug redis
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["php-fpm"]