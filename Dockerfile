FROM alpine:3.17

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

COPY . /trojan
RUN cd /trojan && cmake . && make -j$(nproc) && strip -s trojan \
    && mv trojan /usr/local/bin \
    && apk del .build-deps

WORKDIR /config

CMD ["trojan", "config.json"]

