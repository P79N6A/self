### 映射ip
```bash
sed -i 's/^net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
sysctl -p

A_VPS_IP=104.248.139.241
B_VPS_IP=68.183.218.63

# configure in A_VPS
iptunnel add shc mode ipip local $A_VPS_IP remote $B_VPS_IP ttl 255
ip addr add 192.168.100.1/30 dev shc
ip link set shc up

# configure in B_VPS
iptunnel add shc mode ipip local $B_VPS_IP remote $A_VPS_IP ttl 255
ip addr add 192.168.100.2/30 dev shc
ip link set shc up

# configure in A_VPS
iptables -t nat -A POSTROUTING -s 192.168.100.0/30 -j SNAT --to-source $A_VPS_IP
iptables -t nat -A PREROUTING -d $A_VPS_IP -j DNAT --to-destination 192.168.100.2
iptables -A FORWARD -d 192.168.100.2 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# configure in B_VPS
echo '100 shc' >> /etc/iproute2/rt_tables
ip rule add from 192.168.100.0/30 table shc
ip route add default via 192.168.100.1 table shc

###################
##### A => B ######
###################
```

### 将 B_VPS 作为网关
```bash
# configure in A_VPS
route delete default gw <ip address>
route add default gw 192.168.100.2

# configure in B_VPS
iptables -t nat -A POSTROUTING -o eth0 -s 192.168.100.0/24 -j MASQUERADE
```
