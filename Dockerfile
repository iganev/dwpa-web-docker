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

COPY --from=build /src/hcxtools/hcxpcapngtool /usr/local/bin/hcxpcapngtool
COPY --from=build /src/rkg/cli/routerkeygen-cli /usr/local/bin/routerkeygen-cli

RUN docker-php-ext-install mysqli

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY --chown=root:root php.ini "$PHP_INI_DIR/conf.d/project.ini"

COPY --chown=root:root dwpa/web /srv/app

WORKDIR /srv/app

RUN chown www-data:www-data cap dict

VOLUME [ "/srv/app/cap", "/srv/app/dict" ]

CMD [ "docker-php-entrypoint", "php-fpm"]