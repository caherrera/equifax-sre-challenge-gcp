FROM bitnami/laravel:10.3.3
COPY ./src /app
RUN apt-get update && apt-get install -y postgresql-client php-pgsql
RUN apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN echo "extension=pdo_pgsql" >> /opt/bitnami/php/etc/conf.d/pdo_pgsql.ini
RUN echo "extension=pgsql" >> /opt/bitnami/php/etc/conf.d/pgsql.ini
RUN composer install
