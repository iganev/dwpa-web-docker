FROM php:8.3-fpm-alpine AS build

# Building hcxtools

RUN apk update && apk add git gcc musl-dev make autoconf automake libssl3 openssl-dev zlib zlib-dev libcurl curl-dev pkgconf

COPY hcxtools /src/hcxtools
WORKDIR /src/hcxtools

RUN make -j $(nproc)

# Building rkg

RUN apk add g++ cmake qt5-qtbase-dev

COPY routerkeygenPC /src/rkg
WORKDIR /src/rkg/cli

RUN qmake
RUN make

FROM php:8.3-fpm-alpine AS runtime

RUN apk update && apk add libssl3 zlib libcurl qt5-qtbase

COPY --from=build /src/hcxtools/hcxeiutool /tools/hcxeiutool
COPY --from=build /src/hcxtools/hcxhash2cap /tools/hcxhash2cap
COPY --from=build /src/hcxtools/hcxhashtool /tools/hcxhashtool
COPY --from=build /src/hcxtools/hcxpcapngtool /tools/hcxpcapngtool
COPY --from=build /src/hcxtools/hcxpmktool /tools/hcxpmktool
COPY --from=build /src/hcxtools/hcxpsktool /tools/hcxpsktool
COPY --from=build /src/hcxtools/hcxwltool /tools/hcxwltool
COPY --from=build /src/hcxtools/whoismac /tools/whoismac
COPY --from=build /src/hcxtools/wlancap2wpasec /tools/wlancap2wpasec
COPY --from=build /src/rkg/cli/routerkeygen-cli /tools/routerkeygen-cli

CMD sh