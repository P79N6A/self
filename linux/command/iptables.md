#### 只允许指定ip连接指定端口
```bash
port=465
ip=192.168.1.1
iptables -I INPUT -p tcp --dport ${port} -j DROP
iptables -I INPUT -s $ip -p tcp --dport ${port} -j ACCEPT
```

#### 保存规则
```bash
# 修改 /etc/sysconfig/iptables 后直接重启，不需要 service iptables save
sed -i '/--dport 53 -m string --hex-string/d' /etc/sysconfig/iptables
service iptables restart
```
