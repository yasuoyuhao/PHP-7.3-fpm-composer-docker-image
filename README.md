# PHP7.3-fpm-composer

`docker build -t docker.io/yasuoyuhao/php-fpm-composer:7.3.1 -t docker.io/yasuoyuhao/php-fpm-composer .`

Example Use:

```
FROM yasuoyuhao/php-fpm-composer:7.3.1

# Use npm
RUN npm install

# Set working directory
COPY ./php/local.ini /usr/local/etc/php/conf.d/local.ini
WORKDIR /var/www

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

COPY . /var/www/

RUN chmod -R 777 /var/www/

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
```