## 自用

#### 安装vim、wget、bc
```bash
yum install wget vim bc -y
```

#### 测速
```bash
rm -rf speed.sh
wget https://raw.githubusercontent.com/max2max/self/master/tools/speedtest/speed.sh && bash speed.sh
```
#### 测路由
```bash
mkdir ./tracetmp && cd ./tracetmp
wget https://raw.githubusercontent.com/max2max/self/master/tools/speedtest/test-ip/all.sh
bash all.sh
```

#### Centos重装 (passwd：xiaofd.win)[装为Centos 6.9]
```bash
wget https://raw.githubusercontent.com/max2max/self/master/tools/centosnet.sh && bash centosnet.sh
```

#### Socket.py
```bash
wget -P /tmp https://raw.githubusercontent.com/max2max/self/master/programming%20language/python/sk.py
python /tmp/sk.py 80

# udp test
wget -P /tmp https://raw.githubusercontent.com/max2max/self/master/programming%20language/python/udp.py
python /tmp/udp.py
```

#### 小命令
```bash
# cpu test
time echo "scale=2500;4*a(1)" | bc -l -q

# 创建1G文件
dd if=/dev/zero of=1G.test bs=100M count=10

# tar打包多个文件
tar -cvf test.tar file1 file2 file3 ...

# yum卡住
killall -9 yum
rm -f /var/run/yum.pid

# pip ss
# pip安装的ss，100M带宽、单线程下载 cpu占用比ss-libev要低
yum install python-pip -y
pip install shadowsocks
ssserver -s 0.0.0.0 -p 80 -k freess -m aes-256-cfb -d start
sslocal -s ip -p 80 -l 1081 -b 127.0.0.1 -k passwd -d start
curl --socks5 127.0.0.1:1081 http://speedtest.london.linode.com/100MB-london.bin > /dev/null

# curl
curl -d "email=test1&passwd=test2" "testurl" -v -c cookies.txt
curl -b cookies.txt "testurl" -v
curl -b cookies.txt "http://127.0.0.1:81/user/sspwd" -d "sspwd=1" -X POST

# ps
ps -eo pcpu,pid,user,args,psr,comm | grep -v PID | sort -k 1 -rn | head -15
ps -o pid,time,psr,cmd -C python3.6 | grep -v CMD

# date
date -d "$(curl -s --head http://google.com | grep ^Date: | sed 's/Date: //g')"

# ssh
ssh -o ProxyCommand='nc -x 127.0.0.1:8888 %h %p' root@1.1.1.1
```
