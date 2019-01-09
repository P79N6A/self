```bash
# iptables -F
# iptables -F -t nat

# delete old rules
sed -i '/string/d' /etc/sysconfig/iptables
service iptables restart

iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|07|jiujcsw" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|07|cqjjlsy" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|08|dogtodog" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|10|kuaibaopay" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|08|mgldzcls" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|09|520siling" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|09|litluxury" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|wtdjs" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|04|sai8" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|wrvdmh" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|08|xinshiye" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|08|sy123888" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|07|yunpifu" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|sceyv" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|nm121" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|08|zhuyuanp" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|09|bugsevent" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|lqalm" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|11|sanitwealth" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|ourlj" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|v02u9" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|mekbet" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|xkhejx" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|81ngn1" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|zgclmw" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|uerzyr" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|wgewj" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|cuowog" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|jp236" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|sysapr" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|hnhgw" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|qhres" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|06|zmyuer" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|04|905w" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|10|coveredsys" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|05|syma" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|04|09mk" -j DROP
iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "|02|51|02|la" -j DROP
service iptables save
exit

```
