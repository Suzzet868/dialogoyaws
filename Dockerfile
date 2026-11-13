FROM php:8.2-apache

RUN docker-php-ext-install mysqli \
    && a2enmod headers

WORKDIR /var/www/html

COPY *.php *.html ./
COPY assets/ ./assets/
COPY admin/*.php ./admin/
COPY admin/build/ ./admin/build/
COPY admin/src/partials/ ./admin/src/partials/
COPY admin/delete-confirm.css admin/delete-confirm.js ./admin/

EXPOSE 80
