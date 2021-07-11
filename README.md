
官方文档：
https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md

* 初始化配置文件

```bash
docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM

# 选项参数

 # -u SERVER_PUBLIC_URL"
 # [-e EXTRA_SERVER_CONFIG ]"
 # [-E EXTRA_CLIENT_CONFIG ]"
 # [-f FRAGMENT ]"
 # [-n DNS_SERVER ...]"
 # [-p PUSH ...]"
 # [-r ROUTE ...]"
 # [-s SERVER_SUBNET]"
 # -2    Enable two factor authentication using Google Authenticator.
 # -a    Authenticate  packets with HMAC using the given message digest algorithm (auth).
 # -b    Disable 'push block-outside-dns'
 # -c    Enable client-to-client option
 # -C    A list of allowable TLS ciphers delimited by a colon (cipher).
 # -d    Disable default route
 # -D    Do not push dns servers
 # -k    Set keepalive. Default: '10 60'
 # -m    Set client MTU
 # -N    Configure NAT to access external server network
 # -t    Use TAP device (instead of TUN device)
 # -T    Encrypt packets with the given cipher algorithm instead of the default one (tls-cipher).
 # -z    Enable comp-lzo compression.
```

* 初始化服务端证书（CA）

```bash
docker-compose run --rm openvpn ovpn_initpki

 # nopass 参数使用无密码模式
```

* Fix ownership (depending on how to handle your backups, this may not be needed)

```bash
sudo chown -R $(whoami): ./openvpn-data
```

* Start OpenVPN server process

```bash
docker-compose up -d openvpn
```

* You can access the container logs with

```bash
docker-compose logs -f
```

* Generate a client certificate

```bash
export CLIENTNAME="your_client_name"
# with a passphrase (recommended)
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
# without a passphrase (not recommended)
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass
```

* Retrieve the client configuration with embedded certificates

```bash
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
```

* Revoke a client certificate

```bash
# Keep the corresponding crt, key and req files.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME
# Remove the corresponding crt, key and req files.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove
```

## Debugging Tips

* Create an environment variable with the name DEBUG and value of 1 to enable debug output (using "docker -e").

```bash
docker-compose run -e DEBUG=1 -p 1194:1194/udp openvpn
```
