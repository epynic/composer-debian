# start with the official Composer image and name it
FROM composer:latest AS composer

# continue with the official PHP image
FROM php:latest

# copy the Composer PHAR from the Composer image into the PHP image
COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1