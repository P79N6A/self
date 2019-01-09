# 测试用

# 参考一：http://xuqunxiong.com/archives/666.html

# 参考二：https://github.com/Nyr/openvpn-install

# 注意：google cloud engine须将ip设为内网ip


ip=188.166.154.191
port=443
yum -y update
yum install epel-release -y
yum -y groupinstall "Development Tools"
yum install -y pam-devel.i686 openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig
yum install openvpn wget ca-certificates -y
wget -c https://github.com/OpenVPN/easy-rsa/releases/download/3.0.1/EasyRSA-3.0.1.zip && unzip EasyRSA-3.0.1 && mv EasyRSA-3.0.1 easy-rsa && cp -Rf /root/easy-rsa /etc/openvpn/
cp /etc/openvpn/easy-rsa/vars.example /etc/openvpn/easy-rsa/vars
echo 'set_var EASYRSA_REQ_COUNTRY    "CN"' >> /etc/openvpn/easy-rsa/vars
echo 'set_var EASYRSA_REQ_PROVINCE   "Beijing"' >> /etc/openvpn/easy-rsa/vars
echo 'set_var EASYRSA_REQ_CITY       "Beijing"' >> /etc/openvpn/easy-rsa/vars
echo 'set_var EASYRSA_REQ_ORG        "adultv"' >> /etc/openvpn/easy-rsa/vars
echo 'set_var EASYRSA_REQ_EMAIL      "test@test.tk"' >> /etc/openvpn/easy-rsa/vars
echo 'set_var EASYRSA_REQ_OU         "test"' >> /etc/openvpn/easy-rsa/vars
cd /etc/openvpn/easy-rsa
./easyrsa init-pki
./easyrsa build-ca    # 加个nopass，就是不设置pem密码

# 输入pem密码，再次输入，再回车

./easyrsa gen-req server1 nopass

# 回车

./easyrsa sign server server1 nopass

# 输入yes，输入pem密码

./easyrsa gen-dh
mkdir /root/client
cp -Rf /root/easy-rsa /root/client/
cd /root/client/easy-rsa
./easyrsa init-pki
./easyrsa gen-req client1 nopass

# 回车

cd /etc/openvpn/easy-rsa
./easyrsa import-req /root/client/easy-rsa/pki/reqs/client1.req client1
./easyrsa sign client client1

# 输入yes，输入pem密码

cp /etc/openvpn/easy-rsa/pki/ca.crt /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/private/server1.key /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/issued/server1.crt /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/dh.pem /etc/openvpn
cp /etc/openvpn/easy-rsa/pki/ca.crt /root/client
cp /etc/openvpn/easy-rsa/pki/issued/client1.crt /root/client
cp /root/client/easy-rsa/pki/private/client1.key /root/client

mkdir -p /usr/local/openvpn/log
cp /etc/openvpn/server.conf /etc/openvpn/server.conf.example
rm -rf /etc/openvpn/server.conf

echo "local $ip
port $port" >> /etc/openvpn/server.conf

echo 'proto udp
dev tun
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server1.crt
key /etc/openvpn/server1.key
dh /etc/openvpn/dh.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
duplicate-cn
keepalive 10 120
comp-lzo
max-clients 100
persist-key
persist-tun
log /usr/local/openvpn/log/openvpn.log
log-append /usr/local/openvpn/log/openvpn.log
status /usr/local/openvpn/log/openvpn-status.log
verb 3' >> /etc/openvpn/server.conf

sed -i '/net.ipv4.ip_forward/s/0/1/g' /etc/sysctl.conf
sysctl -p

iptables -F
iptables -t nat -A POSTROUTING -o eth0 -s 10.8.0.0/24 -j MASQUERADE
/etc/init.d/iptables save
/etc/init.d/iptables restart

chkconfig openvpn on
service openvpn start

echo "client
dev tun
proto udp
remote $ip $port
resolv-retry infinite
nobind
persist-key
persist-tun
redirect-gateway def1
sndbuf 0
rcvbuf 0
key-direction 1
setenv opt block-outside-dns
comp-lzo
verb 3" >> /etc/openvpn/client.ovpn

echo "<ca>" >> /etc/openvpn/client.ovpn
cat /root/client/ca.crt >> /etc/openvpn/client.ovpn
echo "</ca>" >> /etc/openvpn/client.ovpn
echo "<cert>" >> /etc/openvpn/client.ovpn
cat /root/client/client1.crt >> /etc/openvpn/client.ovpn
echo "</cert>" >> /etc/openvpn/client.ovpn
echo "<key>" >> /etc/openvpn/client.ovpn
cat /root/client/client1.key >> /etc/openvpn/client.ovpn
echo "</key>" >> /etc/openvpn/client.ovpn
