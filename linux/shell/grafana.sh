#!/bin/bash

collectd_path=/opt/collectd-5.8.0
influxdb_ip='127.0.0.1'

function checksys() {
    echo 
}

function collectd() {
    yum install -y epel-release
    yum -y groupinstall "Development Tools"
    yum install -y vim git wget m2crypto autoconf automake libmcrypt xz screen openssl openssl-devel liboping liboping-devel python-devel python-pip
    pip install psutil
    wget https://storage.googleapis.com/collectd-tarballs/collectd-5.8.0.tar.bz2 -P /tmp/
    cd /tmp
    tar -xjvf collectd-5.8.0.tar.bz2
    cd collectd*
    ./configure --prefix=/opt/collectd-5.8.0
    make -j2
    make install
    wget https://raw.githubusercontent.com/max2max/self/master/deploy/collectd/init.d -O /etc/init.d/collectd
    chmod +x /etc/init.d/collectd
    chkconfig collectd on
    cp /opt/collectd-5.8.0/etc/collectd.conf /etc/
    sed -i "s/prog=.*$/prog=\"\/opt\/collectd-5.8.0\/sbin\/collectdmon\"/g" /etc/init.d/collectd
    mkdir /var/log/collectd/
    cat >> /etc/collectd.conf <<EOF
LoadPlugin logfile
<Plugin logfile>
        LogLevel info
        File "/var/log/collectd/collectd.log"
        Timestamp true
        PrintSeverity false
</Plugin>
EOF
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
    cat >> /etc/collectd.conf <<EOF
Interval     10
EOF
    cat >> /etc/collectd.conf <<EOF
LoadPlugin python
<Plugin python>
    ModulePath "/opt/collectd_py_plugin/"
    LogTraces true
#   Interactive true
    Import "traffic_stat"
#
    <Module traffic_stat>
        Interval 30
        HostName "hkt 112"
        Verbose false
        PluginName "python_speed"
    </Module>
</Plugin>
EOF
    mkdir /opt/collectd_py_plugin/
    wget -O /opt/collectd_py_plugin/traffic_stat.py https://raw.githubusercontent.com/max2max/self/master/programming%20language/python/collectd/traffic_stat.py
    sed -i "s/^\s<Server/#<Server/g" /etc/collectd.conf
    sed -i "s/^\sServer.*$/Server \"$influxdb_ip\" \"25826\"/g" /etc/collectd.conf
    sed -i "s/^\s<\/Server/#<\/Server/g" /etc/collectd.conf
    service collectd start
}

function influxdb() {
    wget https://dl.influxdata.com/influxdb/releases/influxdb-1.4.2.x86_64.rpm
    yum localinstall influxdb-1.4.2.x86_64.rpm -y

    mkdir /usr/local/share/collectd
    wget https://raw.githubusercontent.com/collectd/collectd/master/src/types.db -P /usr/local/share/collectd/

    sed -i 's|^\[\[collectd\]\]|[[collectd]]\n   enabled = true\n   bind-address = ":25826"\n   database = "collectd"\n   typesdb = "/usr/local/share/collectd"\n|g' /etc/influxdb/influxdb.conf

    chkconfig influxdb on
    service influxdb start
}

function grafana() {
    wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.1.4-1.x86_64.rpm 
    yum localinstall grafana-5.1.4-1.x86_64.rpm -y

    chkconfig grafana-server on

    service grafana-server start
}

function all() {
    collectd
    influxdb
    grafana
}

function main() {
    echo
    read -p "--------------------------------------------
    The shell is for centos 6.x only!
--------------------------------------------

1: collectd  2: influxdb  3: grafana
4: all in one vps  5: only collectd and influxdb  | " action
    case $action in
        1)
        echo
        collectd
        ;;
        2)
        echo
        influxdb
        ;;
        3)
        echo
        grafana
        ;;
        4)
        echo
        all
        ;;
        5)
        echo
        collectd
        influxdb
        ;;
        *)
        echo
        echo "WTF?"
        ;;
    esac
}

main
echo
