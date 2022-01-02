FROM php:8.1.1-apache-buster

ENV ACCEPT_EULA="Y"

RUN apt-get update && \
    apt-get install -y gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update -y && \
    apt-get install -y msodbcsql17 unixodbc-dev && \
    pecl install sqlsrv-5.9.0 && \
    docker-php-ext-enable sqlsrv

RUN php -m
