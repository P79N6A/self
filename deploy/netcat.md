### 编译
```bash
cd /tmp
wget https://github.com/max2max/self/raw/master/src/netcat-0.7.1.tar.gz
tar -xzvf netcat-0.7.1.tar.gz
cd netcat-0.7.1
./configure && make && make install
```

### 调试
```bash
a机器上运行：

nc -ul 1080

或：netcat -ul -p 1080

#使用udp模式监听1080 端口

b机器上运行：

nc -u x.x.x.x 1080

或：netcat -u x.x.x.x 1080

若正常，两者可通信
```
