FROM php:5.6-apache
 
ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt update  && \
    apt dist-upgrade -y

# Install useful tools
RUN apt install -y wget \
    curl git nano zip

# Libs
RUN apt install -y zip libicu57 libicu-dev libzip4 libzip-dev curl libcurl3 libcurl4-gnutls-dev  ca-certificates gnupg wget build-essential

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    composer self-update 1.10.26

RUN pecl channel-update pecl.php.net && pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug

# PHP Extensions
RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install curl && \
    docker-php-ext-install zip && \
    docker-php-ext-install -j$(nproc) intl && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install gettext && \
    docker-php-ext-install calendar && \
    docker-php-ext-install exif  

# Cleanup
RUN rm -rf /usr/src/*  

# Enable apache modules
RUN a2enmod rewrite headers
RUN a2enmod rewrite