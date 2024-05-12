FROM bitnami/laravel:10.3.3
COPY ./src /app
RUN composer install
