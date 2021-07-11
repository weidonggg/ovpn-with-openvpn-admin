#!/bin/bash
echo 'start'
# OVPN_OTP_AUTH=1 Google Auth.
 docker-compose run --rm \
     -e 'OVPN_PORT=2298' \
     openvpn-server ovpn_genconfig \
     -u 'udp://OVPN.EXAMPLE.COM:2298' \
     -n '223.5.5.5' \
     -n '119.29.29.29' \
     -s '10.8.2.0/24' \
     -p 'route 192.168.255.0 255.255.255.0' \
     -k '10 120' \
     -C 'AES-256-CBC' \
     -e 'reneg-sec 18000' \
     -e 'script-security 3' \
     -e 'verify-client-cert require' \
     -e 'username-as-common-name' \
     -e 'auth-user-pass-verify scripts/login.sh via-env' \
     -e 'max-clients 50' \
     -e 'client-connect scripts/connect.sh' \
     -e 'client-disconnect scripts/disconnect.sh' \
     -E 'persist-key' \
     -E 'persist-tun' \
     -E 'max-routes 10000' \
     -E 'auth-user-pass' \
     -E 'auth-nocache' \
     -z