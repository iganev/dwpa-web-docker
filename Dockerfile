# Prepare base image
FROM php:8.3-fpm-alpine AS base

RUN apk update && apk add libssl3 zlib libcurl qt5-qtbase

# Prepare compilation tasks
FROM base as build

# Building hcxtools
RUN apk add gcc musl-dev make autoconf automake openssl-dev zlib-dev curl-dev pkgconf

COPY hcxtools /src/hcxtools
WORKDIR /src/hcxtools

RUN make -j $(nproc)

# Building rkg
RUN apk add g++ cmake qt5-qtbase-dev

COPY routerkeygenPC /src/rkg
WORKDIR /src/rkg/cli

RUN qmake
RUN make

# Prepare runtime
FROM base AS runtime

# Copy binaries
COPY --from=build /src/hcxtools/hcxpcapngtool /usr/local/bin/hcxpcapngtool
COPY --from=build /src/rkg/cli/routerkeygen-cli /usr/local/bin/routerkeygen-cli

# Setup php
RUN docker-php-ext-install mysqli

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY --chown=root:root .docker/php.ini "$PHP_INI_DIR/conf.d/project.ini"

# Copy sources
COPY --chown=root:root dwpa/web /srv/app
COPY --chown=root:root dwpa/help_crack /srv/app/hc

# Setup CRON
COPY --chown=root:root .docker/app-cron /etc/cron.d/app-cron
RUN chmod 0644 /etc/cron.d/app-cron
RUN crontab -u www-data /etc/cron.d/app-cron

# Finalize
WORKDIR /srv/app

VOLUME [ "/srv/app/cap", "/srv/app/dict" ]

RUN chown -R www-data:www-data cap dict
RUN chmod -R 664 cap dict

COPY --chown=root:root ./.docker/entrypoint.sh /srv/app/entrypoint.sh
RUN chmod +x /srv/app/entrypoint.sh

#CMD [ "docker-php-entrypoint", "php-fpm"]
CMD [ "/bin/sh", "./entrypoint.sh"]