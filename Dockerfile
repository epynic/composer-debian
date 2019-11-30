FROM composer:latest AS composer

# continue with the official PHP image
FROM php:7.4

# copy the Composer PHAR from the Composer image into the PHP image
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Required
RUN apt-get update && apt-get install --no-install-recommends -y curl git \
    openssl zip unzip wget libzip-dev && rm -rf /var/lib/apt/lists/*

# apcu
RUN pecl install apcu && docker-php-ext-enable apcu

# zip
RUN docker-php-ext-install zip

# Composer env
ENV COMPOSER_HOME /tmp
ENV COMPOSER_ALLOW_SUPERUSER 1

# Permission
RUN chmod -R 0777 /tmp
