```bash
## redirect single ip-tcp traffic
iptables -t nat -N SHADOWSOCKS
iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-port 1081
iptables -t nat -A PREROUTING -p tcp -d 123.123.123.123 -j SHADOWSOCKS

## redirect all ip-tcp traffic
iptables -t nat -N SHADOWSOCKS
iptables -t nat -A SHADOWSOCKS -d 123.123.123.123 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 240.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-ports 1081
iptables -t nat -A OUTPUT -p tcp -j SHADOWSOCKS

## save and restart
service iptables save
service iptables restart
```