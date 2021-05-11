FROM php:7.4-fpm-alpine

ENV TZ=UTC

# Install system dependencies
RUN apk update && apk add --no-cache gcc bash tzdata libpng-dev oniguruma-dev openssl \
    libxml2-dev libzip-dev mysql-client sqlite-dev curl-dev icu-dev g++ make autoconf; \
    cp /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone;

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql pdo_sqlite mbstring exif pcntl bcmath gd curl zip intl

RUN pecl install xdebug-3.0.3;\
    docker-php-ext-enable xdebug

# Dockerize Command
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www/html

RUN cp ./scripts/entrypoint.sh /usr/local/bin/entry-almobi
RUN chmod +x /usr/local/bin/entry-almobi

EXPOSE 8000
EXPOSE 9001
