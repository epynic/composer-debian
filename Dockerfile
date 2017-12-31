# start with the official Composer image and name it
FROM composer:latest AS composer

# continue with the official PHP image
FROM php:latest

# copy the Composer PHAR from the Composer image into the PHP image
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Required
RUN apt-get update && apt-get install -y curl git openssl zip unzip vim tree wget htop glances

# acpu
RUN pecl install apcu && docker-php-ext-enable apcu

# xdebug
RUN pecl install xdebug-2.6.0beta1 \
    && docker-php-ext-enable xdebug

RUN apt-get install -y libz-dev
RUN docker-php-ext-install zip

# Composer env
ENV COMPOSER_HOME /tmp
ENV COMPOSER_ALLOW_SUPERUSER 1

# Tools
RUN composer global require hirak/prestissimo

# Permission
RUN chmod -R 0777 /tmp
