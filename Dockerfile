FROM php:8.3-apache-bookworm

ENV ACCEPT_EULA="Y"

RUN apt-get update && \
    apt-get install -y gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc > /etc/apt/trusted.gpg.d/microsoft.asc && \
    curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update -y || true && \
    cat /etc/apt/sources.list.d/mssql-release.list && \
    # TODO: Remove workaround
    sed -i 's/ signed-by=\/usr\/share\/keyrings\/microsoft-prod.gpg//g' /etc/apt/sources.list.d/mssql-release.list && \
    apt-get install -y msodbcsql18 unixodbc-dev && \
    pecl install sqlsrv-5.10.0 && \
    docker-php-ext-enable sqlsrv

RUN php -m
