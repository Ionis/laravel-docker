# Используем PHP с FPM, основанный на Alpine Linux
FROM php:8.2-fpm-alpine

# Установка зависимостей и инструментов
RUN apk update && apk add --no-cache \
    git \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql gd

#COPY ./_docker/app/php.ini /usr/local/etc/php/conf.d/php.ini

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Создание необходимых директорий с назначением прав
#RUN mkdir -p /var/www/laravel/storage /var/www/laravel/bootstrap/cache \
#    && chown -R www-data:www-data /var/www/laravel/storage /var/www/laravel/bootstrap/cache

# Установка рабочей директории
WORKDIR /var/www/laravel

# Увеличение тайм-аута Composer
RUN composer config --global process-timeout 1200