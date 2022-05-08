---
title: How to create ecommerce website use Laravel 9, VueJs, Docker, Supervisord,
  Brooadcast and Redis Queue (part 1)
---

# Introdution
Create an E-Commerce website with laravel 9 and VueJs :
- Dockerize setup all in one
- API integration.
- Redis for queue job in concurrency request.
- Supervisor manage queue job(Laravel horizon).
- Laravel Broadcast event to observe status of serve and update to client.
- Deploy website to AWS EC2.

Checkout source code on my [git](https://github.com/zmerrychristmas/Ecommerce-website-by-Laravel-and-VueJs-api-integration-with-event-handle)

# Part 1 Install

## Dockerize setup all in one

## Docker Install


## Laravel with VueJs, Redis, Supervisod, and Horizon install

## Redis Install

## Pusher Install

## Complete Dockerfile and .yml file
```dockerfile
FROM php:8.0-fpm
 
# Copy composer.lock and composer.json into the working directory
COPY composer.lock composer.json /var/www/html/
 
# Set working directory
WORKDIR /var/www/html/
 
# Install dependencies for the operating system software
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    libzip-dev \
    unzip \
    git \
    libonig-dev \
    curl \
    build-essential \
    openssl \
    libssl-dev curl \
    supervisor \
    software-properties-common 
 
RUN groupadd dev
# node install

ENV NODE_VERSION=15.14.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/usr/local/nvm/.nvm
RUN mkdir /usr/local/nvm
RUN mkdir /usr/local/node
RUN chown -R root:dev /usr/local/nvm
RUN chmod -R 775 /usr/local/nvm
RUN chown -R root:dev /usr/local/node
RUN chmod -R 775 /usr/local/node
RUN cp -R /root/.nvm/ /usr/local/nvm/
ENV NVM_DIR=/usr/local/nvm/.nvm
RUN export NVM_DIR=/usr/local/nvm/.nvm
RUN . "/usr/local/nvm/.nvm/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "/usr/local/nvm/.nvm/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "/usr/local/nvm/.nvm/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/usr/local/nvm/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version


# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Install extensions for php
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl 
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN pecl install redis \
    && docker-php-ext-enable redis
 
# Install composer (php package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
 
# Copy existing application directory contents to the working directory
COPY . /var/www/html

ENV ENABLE_CRONTAB 1
ENV ENABLE_HORIZON 1
ENTRYPOINT ["sh", "/var/www/html/docker-entrypoint.sh"]

COPY ./supervisor.d/*.* /etc/supervisor/conf.d/

RUN composer install
RUN composer dump-autoload
RUN chmod 777 install.sh

RUN ["/bin/bash", "-c", "./install.sh"]

# Assign permissions of the working directory to the www-data user
RUN chown -R www-data:www-data \
        /var/www/html/storage \
        /var/www/html/bootstrap/cache
RUN chmod -R 777 /var/www/html/storage

EXPOSE 9000

CMD supervisord -n -c /etc/supervisor/supervisord.conf

# Expose port 9000 and start php-fpm server (for FastCGI Process Manager)
# CMD ["php-fpm"]

```

Service distributed by `docker-compose.yml`
```yml
version: '2.0'
services:
 
  #PHP Service
  app:
    build:
      context: .
      dockerfile: Dockerfile
    image: cloudsigma.com/php
    container_name: app
    restart: unless-stopped
    tty: true
    environment:
      SERVICE_NAME: app
      SERVICE_TAGS: dev
    working_dir: /var/www/html/
    volumes:
      - ./:/var/www/html/
      - ./php/laravel.ini:/usr/local/etc/php/conf.d/laravel.ini
    networks:
      - app-network
 
  #Nginx Service
  webserver:
    image: nginx:alpine
    container_name: webserver
    restart: unless-stopped
    tty: true
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./:/var/www/html/
      - ./nginx/conf.d/:/etc/nginx/conf.d/
    networks:
      - app-network
 
  #MySQL Service
  db:
    image: mysql:5.7.32
    container_name: db
    restart: unless-stopped
    tty: true
    ports:
      - "3306:3306"
    environment:
      MYSQL_DATABASE: lecommerce
      MYSQL_ROOT_PASSWORD: 123456
      SERVICE_TAGS: dev
      SERVICE_NAME: mysql
    volumes:
      - dbdata:/var/lib/mysql/
      - ./mysql/my.cnf:/etc/mysql/my.cnf
    networks:
      - app-network
  redis:
    image: redis:alpine
    container_name: redis
    ports:
      - "6379:6379"
    volumes:
      - cache_data:/data
    networks:
      - app-network
#Docker Networks
networks:
  app-network:
    driver: bridge
#Volumes
volumes:
  dbdata:
    driver: local
  cache_data:
    driver: local
```
`docker-entrypoint.sh`

Introduction of Docker ENTRYPOINT. Docker entrypoint is a Dockerfile directive or instruction that is used to specify the executable which should run when a container is started from a Docker image. It has two forms, the first one is the 'exec' form and the second one is the 'shell' form.
I was used a PHP-FPM based image, this file was useful when use Ubuntu image or deploy to Linux based system:
```sh
#!/bin/sh
set -e

# Enable Laravel schedule
if [[ "${ENABLE_CRONTAB:-0}" = "1" ]]; then  
  echo "* * * * * php /var/www/html/artisan schedule:run >> /dev/null 2>&1" >> /etc/crontabs/www-data
fi

exec "$@"
```

## Part 2
