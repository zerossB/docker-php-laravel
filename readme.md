# Docker Php Laravel

A base project that serves for Laravel development projects

## How to build an image?

Just run the docker build command informing the folder where the Dockerimage is located and informing the version in the
TAG.

````bash
$ docker build . --file php/7.4/Dockerfile --tag anave/php-laravel:7.4
````

## How to publish the image?

After building the image, we will publish it on the Docker hub, for that use the command below informing the images
built previously.

```bash
$ docker push anave/php-laravel:7.4
```

## What does this image provide?

It uses the `php:8.1-fpm-alpine` base provided by the official PHP repository on the Docker HUB.

It uses Alpine Linux as a development base.

`Mysql`, `Sqlite`, `LibPng`, `Curl`, `XML`, `Zip` and others are already installed.

The PHP Extensions

- `pdo_mysql`
- `pdo_sqlite`
- `mbstring`
- `exif`
- `pcntl`
- `bcmath`
- `gd`
- `curl`
- `zip`
- `intl`
- `xdebug`
- `redis`

`dockerize` is already installed.

and `Composer` in the latest version.

## How to use OPCache for local development?

To use the image with OPCache active for production, just override the environment variable when running the image.

```ini
PHP_OPCACHE_VALIDATE_TIMESTAMPS = 1
```

The variables that are enabled for override are:

```Dockerfile
ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_REVALIDATE_FREQ=0
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=0
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES=10000
ENV PHP_OPCACHE_MEMORY_CONSUMPTION=192
ENV PHP_OPCACHE_MAX_WASTED_PERCENTAGE=10
ENV PHP_OPCACHE_INTERNED_STRINGS_BUFFER=16
```
