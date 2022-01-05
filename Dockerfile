FROM php:7.2.2-apache
WORKDIR /var/www/html

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN a2enmod rewrite

COPY . .
EXPOSE 80

