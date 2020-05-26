FROM php:7.3-fpm

LABEL maintainer="yasuoyuhao@gmail.com"

# Copy composer.lock and composer.json
# COPY composer.lock composer.json /var/www/

# Set working directory
# WORKDIR /var/www

# install npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    default-mysql-client \
    libpng-dev \
    libzip-dev \
    libonig-dev \
    libldap2-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    nodejs

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install ldap

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
# COPY docker /var/www

# Copy existing application directory permissions
# COPY --chown=www:www docker /var/www

# Change current user to www
# USER www

# Expose port 9000 and start php-fpm server
# EXPOSE 9000
# CMD ["php-fpm"]