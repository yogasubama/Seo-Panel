FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libonig-dev \
    zip unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql curl mbstring

RUN a2enmod rewrite

RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' >> /etc/apache2/apache2.conf

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod 666 /var/www/html/config/sp-config.php \
    && chmod 777 /var/www/html/tmp

EXPOSE 80
