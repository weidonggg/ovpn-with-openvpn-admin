FROM kylemanna/openvpn:2.4

COPY bin/ovpn_genconfig /usr/local/bin/

RUN set -ex; \
    \
    ## Install php runtime.
    apk add --no-cache php-cli; \
    \
    # Create openvpn scripts directory.
    mkdir -p /etc/openvpn/scripts; \
    \
    chmod +x /usr/local/bin/ovpn_genconfig


COPY scripts/*.sh /etc/openvpn/scripts
