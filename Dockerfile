FROM php:7.4-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . .
RUN composer install

EXPOSE 8000

RUN cp .env.example .env && \
    php artisan key:generate && \
    php artisan migrate

CMD php artisan serve --host=0.0.0.0
