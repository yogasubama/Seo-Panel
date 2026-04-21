FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libonig-dev \
    zip unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql curl mbstring \
    && rm -rf /var/lib/apt/lists/*

RUN a2dismod mpm_event mpm_worker mpm_prefork 2>/dev/null; \
    a2enmod mpm_prefork rewrite

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod 666 /var/www/html/config/sp-config.php \
    && chmod 777 /var/www/html/tmp

EXPOSE 80

CMD ["apache2-foreground"]
