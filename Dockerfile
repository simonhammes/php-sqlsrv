FROM php:8.3-apache-bookworm

ENV ACCEPT_EULA="Y"

RUN apt-get update && \
    apt-get install -y gnupg && \
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && \
    curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update -y && \
    apt-get install -y msodbcsql18 unixodbc-dev && \
    pecl install sqlsrv-5.12.0 && \
    docker-php-ext-enable sqlsrv

RUN php -m
