#!/bin/bash

# 添加 udp2raw
# add_udp ssrport udp2raw_listen_port
# add_udp 1001 1002
function add_udp() {
	ssrport=$1
	udp2raw_listen_port=$2
	if [ ! -z $1 ] && [ ! -z $2 ];then
		nohup udp2raw -s -l 0.0.0.0:$udp2raw_listen_port -r 127.0.0.1:$ssrport  -a -k passwd --raw-mode faketcp > /root/udp.log 2>&1 &
	fi
}


function check_udp() {
	port=$1
	if [ ! -z $1 ];then
		result=`ps x | grep -v "grep" | grep "udp2raw" | grep $1`
	else
		result=`ps x | grep -v "grep" | grep "udp2raw"`
	fi
	if [ "$result" ];then
		echo $result
	fi
}

function kill_udp() {
	port=$1
	if [ ! -z $1 ];then
		ps x | grep -v "grep" | grep "udp2raw" | grep $1 | awk '{print $1}' | xargs kill -9
	else
		killall udp2raw
	fi
}


function main() {
	read -p "1: add_udp
2: check_udp
3: kill_udp
4: exit the shell
请输入您的选择：" choice

	case $choice in
		1)  read -p "输入您要添加的端口(ssr udp2raw)：" port_1_ssr port_1_udp2raw_listen
			if [ ! -z $port_1_ssr ] && [ ! -z $port_1_udp2raw_listen ];then
				add_udp $port_1_ssr $port_1_udp2raw_listen
			fi
			;;
		2)  read -p "输入您要检查的端口(默认检查全部)：" port_2
			check_udp $port_2;;
		3)  read -p "输入您要杀掉的端口(默认不杀)：" port_3
			if [ ! -z $port_3 ];then
				kill_udp $port_3
			fi;;
		4) echo "Exit...";;
		*) main;;
	esac
}

main
