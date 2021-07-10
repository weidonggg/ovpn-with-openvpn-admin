FROM node:10.24.1-alpine3.11 as builder

RUN set -ex; \
    # Install build tools
    apk add --no-cache git; \
    # Install bower
    npm install -g bower; \
    ## Clone openvpn-admin code
    mkdir /app; \
    cd /app; \
    git clone --depth=1 https://github.com/Chocobozzz/OpenVPN-Admin.git openvpn-admin; \
    cd openvpn-admin; \
    \
    # Install third parties
    bower --allow-root install --registry https://registry.npm.taobao.org

FROM php:7.4.21-fpm-alpine3.14 as prod

LABEL maintainer="Zhao Weidong <1993plus@gmail.com>"

RUN set -ex; \
    mkdir /app

WORKDIR /app

COPY COPY --from=0 /app/{ndex.php,sql,bower.json,.bowerrc,js,include,css} /app/

