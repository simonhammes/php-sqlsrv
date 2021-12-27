FROM php:7.4-apache-bullseye

ENV ACCEPT_EULA="Y"

RUN apt-get update && \
    apt-get install -y gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update -y && \
    apt-get install -y msodbcsql17 unixodbc-dev && \
    pecl install sqlsrv-5.10.0 && \
    docker-php-ext-enable sqlsrv

RUN php -m
