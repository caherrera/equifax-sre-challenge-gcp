FROM bitnami/laravel:10.3.3
COPY ./src /app
RUN apt-get update && apt-get install -y pgsql-client php-pgsql
RUN apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN composer install
