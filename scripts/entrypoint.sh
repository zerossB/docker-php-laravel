#!/bin/bash

if [[ -z "${ENVIRONMENT}" ]]; then
    echo "Runing web application: local development"
    composer install --optimize-autoloader
    php artisan migrate
    php artisan migrate --env=testing
    php artisan serve --host=0.0.0.0 --port=8000
else
    echo "Runnig without application: ${ENVIRONMENT}"
    composer install --optimize-autoloader --no-dev
    php artisan migrate --force
    php artisan optimize
    php artisan serve --host=0.0.0.0 --port=8000
    php artisan up
fi
