#!/bin/bash
if [ ! -f "./all.ip" ]
then
    wget https://raw.githubusercontent.com/max2max/self/master/tools/speedtest/test-ip/all.ip
fi
if [ ! -f "/usr/local/bin/besttrace" ]
then
    wget https://raw.githubusercontent.com/max2max/self/master/tools/besttrace -O /usr/local/bin/besttrace
    chmod +x /usr/local/bin/besttrace
fi
echo -n "1:ping  2:trace"
read choice

pingme() {
cat ./all.ip | while read line
    do
        ip=`echo $line | awk '{print $1}'`
        describtion=`echo $line | awk '{print $2}'`
        laytency=`ping -c 1 $ip | sed -n '2p' | awk -F ' |=' '{print $10"ms"}'s `
        echo -e "\033[34m $laytency \033[0m" "\033[32m $describtion \033[0m" "$ip"
    done
}

trace() {
    cat all.ip | while read line
    do
        ip=`echo $line | awk '{print $1}'`
        echo "Traceroute to $ip :" >> trace.log
        besttrace -n -q 1 $ip | grep -v 'traceroute to' | awk '{print $7$8$9" ("$5") ["$3$4"] "}' | tee -a trace.log
    done
}

case $choice in
    1)    pingme
    ;;
    2)    trace
esac
