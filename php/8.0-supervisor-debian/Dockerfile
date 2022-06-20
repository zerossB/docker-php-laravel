FROM php:8.0-fpm

ENV TZ=UTC

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential wget tzdata git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    libmariadb-dev sqlite3 libsqlite3-dev g++ libicu-dev libpq-dev libzip-dev zip zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libcurl4-openssl-dev

RUN cp /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone;

#RUN apk update && apk add --no-cache gcc bash tzdata libpng-dev oniguruma-dev openssl \
#    libxml2-dev libzip-dev mysql-client sqlite-dev curl-dev icu-dev g++ make autoconf nginx supervisor sudo; \
#    cp /usr/share/zoneinfo/$TZ /etc/localtime; \
#    echo $TZ > /etc/timezone;

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql pdo_sqlite mbstring exif pcntl bcmath gd curl zip intl

RUN pecl install xdebug-3.1.4;\
    docker-php-ext-enable xdebug;

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
    cp ./scripts/nginx.conf /etc/nginx/http.d/default.conf; \
    mkdir /etc/supervisor.d; \
    cp ./scripts/supervisor.ini /etc/supervisor.d; \
    chmod +x /usr/local/bin/entry-almobi;

EXPOSE 8000
EXPOSE 9001

ENTRYPOINT ["entry-almobi"]
