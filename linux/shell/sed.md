### 删除匹配行
```bash
cat /etc/sysconfig/iptables | sed '/--dport 53 -m string --hex-string/d'
```

### 匹配数字
```bash
# 不支持 \d
echo '....
...
...' \
| sed 's/iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|[0-9][0-9]|//g' \
| sed 's/" -j DROP//g' \
| sort -n
```
