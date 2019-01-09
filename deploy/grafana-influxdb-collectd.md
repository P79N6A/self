### For centos 6.x

### 工作流程
```
collectd 1    |
              |
collectd 2    |    收集数据，上报到influxdb                          图形化显示
              |
collectd 3    | -------------------------->  influxdb ===========> grafana
              |
collectd 4    |
              |
collectd .... |

influxdb 和 grafana 可以放在别的服务器
```

### collectd 编译准备
```bash
yum install -y epel-release
yum -y groupinstall "Development Tools"
yum install -y vim git wget m2crypto autoconf automake libmcrypt xz screen openssl openssl-devel

# ping 插件编译需要
yum install liboping liboping-devel -y

# python 插件编译需要
yum install python-devel -y
```

### collectd 编译
#### 路径在 /opt/collectd-5.8.0
```bash
wget https://storage.googleapis.com/collectd-tarballs/collectd-5.8.0.tar.bz2 -P /tmp/
cd /tmp
tar -xjvf collectd-5.8.0.tar.bz2
cd collectd*
./configure --prefix=/opt/collectd-5.8.0
make -j2
make install

# 设置开机自启
wget https://raw.githubusercontent.com/max2max/self/master/deploy/collectd/init.d -O /etc/init.d/collectd
chmod +x /etc/init.d/collectd
chkconfig collectd on
# wget https://raw.githubusercontent.com/max2max/self/master/deploy/collectd/collectd.conf -P /etc/
cp /opt/collectd-5.8.0/etc/collectd.conf /etc/
sed -i "s/prog=.*$/prog=\"\/opt\/collectd-5.8.0\/sbin\/collectdmon\"/g" /etc/init.d/collectd

# 编辑配置文件
vim /etc/collectd.conf
# 955行，服务器地址改掉（这个地址是influxdb的ip地址）
# 注释1222-1234行，注释182行，这两个是python插件
# 177行和1124-1132行，这是ping插件，有需要可以取消注释
# interval 是监控执行间隔
# 开启日志
cat >> /etc/collectd.conf <<EOF
LoadPlugin logfile
<Plugin logfile>
        LogLevel info
        File "/var/log/collectd/collectd.log"
        Timestamp true
        PrintSeverity false
</Plugin>
EOF

# 开启 ping插件
# 如果ping频率低于 全局间隔10，则会取10秒内的值取均值
cat >> /etc/collectd.conf <<EOF
LoadPlugin ping
<Plugin ping>
       Host "202.101.224.69"
       Interval 10
       Timeout 0.9
       TTL 255
#       SourceAddress "1.2.3.4"
       Device "eth0"
       MaxMissed -1
</Plugin>
EOF

# 设置全局 Interval 间隔
cat >> /etc/collectd.conf <<EOF
Interval     10
EOF

# 设置上报数据的服务器ip
sed -i "s/^\s<Server/#<Server/g" /etc/collectd.conf
sed -i "s/^\sServer.*$/Server \"127.0.0.1\" \"25826\"/g" /etc/collectd.conf
sed -i "s/^\s<\/Server/#<\/Server/g" /etc/collectd.conf

# 控制
service collectd start|restart|stop|status
```

### influxdb 安装
#### 类似mysql，是一种存储数据的数据库，grafana从influxdb获取数据
```bash
wget https://dl.influxdata.com/influxdb/releases/influxdb-1.4.2.x86_64.rpm
yum localinstall influxdb-1.4.2.x86_64.rpm

mkdir /usr/local/share/collectd
wget https://raw.githubusercontent.com/collectd/collectd/master/src/types.db -P /usr/local/share/collectd/

# 编辑配置文件
vim /etc/influxdb/influxdb.conf
# 搜索25826，database
# 相关设置如下
# enabled = true
# bind-address = "127.0.0.1:25826"
# database = "collectd"
# typesdb = "/usr/local/share/collectd/types.db"

# 如
sed -i 's|^\[\[collectd\]\]|[[collectd]]\n   bind-address = ":25826"\n   database = "collectd"\n   typesdb = "/usr/local/share/collectd"\n|g' /etc/influxdb/influxdb.conf

# 查看日志
tail -f /var/log/influxdb/influxd.log
# 运行
service influxdb start|restart|stop|status

# 数据库设置
## 本地连接数据库（类比mysql -uroot -ppassword）
influx
## 创建数据库
create database collectd
## 创建用户
create user ops with password '123123'
## 赋予权限
grant ALL PRIVILEGES on collectd to ops;
## 选中数据库
use collectd
## 查看测量指标（类比mysql的表）
show measurements
## 查询
select * from memory_value
```

### grafana安装
#### 参考 https://grafana.com/grafana/download
```bash
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.1.4-1.x86_64.rpm 
yum localinstall grafana-5.1.4-1.x86_64.rpm -y

chkconfig grafana-server on

# 状态控制
service grafana-server {start|stop|restart|force-reload|status}

# 浏览器打开 http://localhost:3000

# http端口 3000
# 用户 admin/admin
# 配置文件 /etc/grafana/grafana.ini
# 日志 /var/log/grafana
```
