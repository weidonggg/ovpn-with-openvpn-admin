#!/bin/bash
echo 'start'
docker-compose run --rm \
    -e 'EASYRSA_CA_EXPIRE=36500' \
    -e 'EASYRSA_CERT_EXPIR=3650' \
    openvpn-server ovpn_initpki nopass
