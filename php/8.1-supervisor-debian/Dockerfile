FROM php:8.1-fpm

ENV TZ UTC

ENV PHP_OPCACHE_ENABLE 1
ENV PHP_OPCACHE_REVALIDATE_FREQ 0
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS 0
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES 10000
ENV PHP_OPCACHE_MEMORY_CONSUMPTION 192
ENV PHP_OPCACHE_MAX_WASTED_PERCENTAGE 10
ENV PHP_OPCACHE_INTERNED_STRINGS_BUFFER 16

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends build-essential software-properties-common ca-certificates \
    wget tzdata git curl libpng-dev libonig-dev libxml2-dev zip unzip libmariadb-dev sqlite3 libsqlite3-dev g++  \
    libicu-dev libpq-dev libzip-dev zip zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libcurl4-openssl-dev \
    gnupg gnupg2 gnupg1 supervisor nginx cron

RUN cp /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone;

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql pdo_sqlite mbstring exif pcntl bcmath gd curl zip intl opcache

RUN pecl install -o -f redis; \
    rm -rf /tmp/pear; \
    docker-php-ext-enable redis;

# Dockerize Command
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www/html

RUN cp ./scripts/entrypoint.sh /usr/local/bin/entry-almobi; \
    cp ./scripts/nginx.conf /etc/nginx/sites-available/default; \
    cp ./scripts/supervisor.ini /etc/supervisor/supervisord.conf; \
    cp ./scripts/opcache.ini /usr/local/etc/php/conf.d/opcache.ini; \
    chmod +x /usr/local/bin/entry-almobi;

EXPOSE 8000
EXPOSE 9001

ENTRYPOINT ["entry-almobi"]
