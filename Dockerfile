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
    bower --allow-root install; \
    mkdir -p dist; \
    cp -rf index.php sql bower.json .bowerrc js include css  ./dist/


#php:5.5-apache
FROM php:5.5-apache as prod

LABEL maintainer="Zhao Weidong <1993plus@gmail.com>"

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends libzip-dev; \
  \
  docker-php-ext-install pdo_mysql zip; \
  \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*

#WORKDIR /app

COPY --from=0 /app/openvpn-admin/dist/ /var/www/html/