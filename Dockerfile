FROM php:7.4-apache-bullseye

ENV ACCEPT_EULA="Y"

# Workaround for Microsoft driver not available for Debian Bullseye (11)
RUN apt-get -y update \
    && apt-get -y install equivs \
    && echo 'Package: multiarch-support-dummy\nProvides: multiarch-support\nDescription: Fake multiarch-support' > multiarch-support-dummy.ctl \
    && equivs-build multiarch-support-dummy.ctl 
    && dpkg -i multiarch-support-dummy*.deb 
    && rm multiarch-support-dummy*.* \
    && apt-get -y purge equivs \
    && apt-get -y autoremove 
    && apt-get clean \
    && curl -sSLf -o /etc/apt/trusted.gpg.d/microsoft.asc https://packages.microsoft.com/keys/microsoft.asc \
    && curl -sSLf -o /etc/apt/sources.list.d/mssql-release-10.list https://packages.microsoft.com/config/debian/10/prod.list \
    && apt-get -y update

RUN apt-get update && \
    apt-get install -y gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update -y && \
    apt-get install -y msodbcsql17 unixodbc-dev && \
    pecl install sqlsrv-5.10.0 && \
    docker-php-ext-enable sqlsrv

RUN php -m
