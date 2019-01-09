#!/usr/bin/env bash
#
# Description: Auto test download & I/O speed script
#
# Copyright (C) 2015 - 2016 Teddysun <i@teddysun.com>
#
# Thanks: LookBack <admin@dwhd.org>
#
# URL: https://teddysun.com/444.html
#

if  [ ! -e '/usr/bin/wget' ]; then
    echo "Error: wget command not found. You must be install wget command at first."
    exit 1
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PLAIN='\033[0m'

next() {
    printf "%-70s\n" "-" | sed 's/\s/-/g'
}

speed_test_url() {
echo -n "Please enter the url you want to test:"
read url
curl ${url} > /dev/null
}

speed_test_v4() {
    local speedtest=$(wget --no-check-certificate -4O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
    local ipaddress=$(ping -c1 -n `awk -F'/' '{print $3}' <<< $1` | awk -F'[()]' '{print $2;exit}')
    local nodeName=$2
    printf "${YELLOW}%-32s${GREEN}%-24s${RED}%-14s${PLAIN}\n" "${nodeName}" "${ipaddress}" "${speedtest}"
}
speed_test_v6() {
    local speedtest=$(wget -6O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
    local ipaddress=$(ping6 -c1 -n `awk -F'/' '{print $3}' <<< $1` | awk -F'[()]' '{print $2;exit}')
    local nodeName=$2
    printf "${YELLOW}%-32s${GREEN}%-24s${RED}%-14s${PLAIN}\n" "${nodeName}" "${ipaddress}" "${speedtest}"
}
speed_v4_cachefly() {
    speed_test_v4 'http://cachefly.cachefly.net/100mb.test' 'CacheFly'
}
speed_v4_hk() {
    speed_test_v4 'http://speedtest.hkg02.softlayer.com/downloads/test100.zip' 'Softlayer, HK'
    speed_test_v4 'https://mirror.hk.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, HK'
    speed_test_v4 'http://lg.hkserverworks.com/100MB.test' 'Hkserverworks, HK'
    speed_test_v4 'http://hk4.lg.starrydns.com/100MB.test' 'StarryDns, HK'
    speed_test_v4 'http://hke.lg.hosthongkong.net/100MB.test' 'Hosthongkong, HK'
    speed_test_v4 'http://hk.edis.at/100MB.test' 'edis, HK'
}
speed_v4_sg() {
    speed_test_v4 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, SG'
    speed_test_v4 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, SG'
    speed_test_v4 'http://speedtest-sgp1.digitalocean.com/100mb.test' 'DigitalOcean, SG-1'
    speed_test_v4 'https://sgp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, SG'
    speed_test_v4 'https://mirror.sg.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, SG'
    speed_test_v4 'http://speedtest.c1.sin1.dediserve.com/100MB.test' 'Dediserve, SG'
    speed_test_v4 'http://singapore-lg.indovirtue.com/100MB.test' 'IndoVirtue, SG'
    speed_test_v4 'http://lg-sg.qhoster.com/100MB.test' 'qhoster, SG'
}
speed_v4_jp() {
    speed_test_v4 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP1'
    speed_test_v4 'http://speedtest.tokyo2.linode.com/100MB-tokyo2.bin' 'Linode, Tokyo, JP2'
    speed_test_v4 'http://speedtest.tok02.softlayer.com/downloads/test100.zip' 'Softlayer, Tokyo, JP'
    speed_test_v4 'http://hnd-jp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, JP'
    speed_test_v4 'http://jp1.lg.starrydns.com/100MB.test' 'StarryDns, JP'
    speed_test_v4 'http://jp2.lg.starrydns.com/100MB.test' 'StarryDns, JP'
    speed_test_v4 'http://jp.lg.2sync.org/100MB.test' '2sync, JP'
    speed_test_v4 'http://lg-jp.qhoster.com/100MB.test' 'qhoster, JP'
    speed_test_v4 'http://50.31.252.13/speedtest.256mb' 'VPS.NET, JP'
    # 失效 speed_test_v4 'http://tok1.lg.vpsto.com/100MB.test' 'VPS.TO, Tokyo, JP'
}
speed_v4_kr() {
    speed_test_v4 'http://kr.lg.2sync.org/100MB.test' '2sync, South Korea'
}
speed_v4_tw() {
    speed_test_v4 'http://lg.tw.psychz.net/200MB.test' 'psychz, Taipei, TW'
    speed_test_v4 'http://lg.serverfield.com.tw/100MB.test' 'serverfield, Taipei, TW'
    # speed_test_v4 'http://tw426-apol.host.dler.org/1g' 'Dler, Taipei Apol, TW'
    # speed_test_v4 'http://tw426-seednet.host.dler.org/1g' 'Dler, Taipei Seednet, TW'
    # speed_test_v4 'https://tw426-hinet.host.dler.org/1g' 'Dler, Taipei Hinet, TW'
}
speed_v4_us() {
    speed_test_v4 'http://speedtest.fremont.linode.com/100MB-fremont.bin' 'Linode, Fremont, CA'
    speed_test_v4 'http://speedtest.dal05.softlayer.com/downloads/test100.zip' 'Softlayer, Dallas, TX'
    speed_test_v4 'http://speedtest.sea01.softlayer.com/downloads/test100.zip' 'Softlayer, Seattle, WA'
    speed_test_v4 'http://speedtest-nyc1.digitalocean.com/100mb.test' 'DigitalOcean, NYC1'
    speed_test_v4 'http://speedtest-sfo1.digitalocean.com/100mb.test' 'DigitalOcean, SFO1'
    speed_test_v4 'http://speedtest-sfo2.digitalocean.com/100mb.test' 'DigitalOcean, SFO2'
}
speed_v4_eu() {
    speed_test_v4 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
    speed_test_v4 'http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin' 'Linode, Frankfurt, DE'
    speed_test_v4 'http://speedtest.fra02.softlayer.com/downloads/test100.zip' 'Softlayer, Frankfurt, DE'
    speed_test_v4 'http://speedtest-lon1.digitalocean.com/100mb.test' 'DigitalOcean, London-1, UK'
    speed_test_v4 'https://mirror.de.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Germany'
    speed_test_v4 'http://lg.lon.psychz.net/200MB.test' 'psychz, London, UK'
    speed_test_v4 'http://speedtest.c1.vie1.dediserve.com/100MB.test' 'Dediserve, Vienna, Austria, EU'
}
speed_v4_au() {
    speed_test_v4 'http://speedtest.syd01.softlayer.com/downloads/test100.zip' 'Softlayer, Sydney, Australia'
    speed_test_v4 'http://syd-au-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Sydney, Australia'
}
speed_v4_other() {
    speed_test_v4 'http://lgvn.greencloudvps.com/100MB.test' 'GreenCloudVPS, Hanoi, Vietnam'
    speed_test_v4 'https://www.here-host.com/looking-glass/100MB.test' 'HereHost, Sofia, Bulgaria'
    speed_test_v4 'http://lg.time4vps.eu/100MB.test' 'time4vps, Unknown, Lithuania'
    speed_test_v4 'http://lg.tw.psychz.net/200MB.test' 'psychz, Johannesburg, South Africa'
    speed_test_v4 'http://92.223.60.98/100MB.test' '50kvm, Khabarovsk, RU'
    speed_test_v4 'http://lg-nz.zappiehost.com/100MB.test' 'Zappiehost, New Zealand'
}
speed_v6_jp() {
    speed_test_v6 'http://speedtest.tok02.softlayer.com/downloads/test100.zip' 'Softlayer, Tokyo, JP'
    speed_test_v6 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP'
    speed_test_v6 'http://hnd-jp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Tokyo, JP'
    speed_test_v6 'http://lg-jp.qhoster.com/100MB.test' 'qhoster, JP'
}
speed_v6_sg() {
    speed_test_v6 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
    speed_test_v6 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
    speed_test_v4 'http://lg-sg.qhoster.com/100MB.test' 'qhoster, SG'
}
speed_v6_tw() {
    speed_test_v6 'http://lg.serverfield.com.tw/100MB.test' 'serverfield, Taipei, TW'
}
speed_v6_hk() {
    speed_test_v6 'http://lg.hkserverworks.com/100MB.test' 'hkserverworks, HK'
    speed_test_v6 'http://hk.edis.at/100MB.test' 'edis, HK'
}

speed_v4_asia() {
	speed_v4_cachefly
	speed_v4_hk
	speed_v4_sg
	speed_v4_jp
	speed_v4_tw
}
speed_v4_not_asia() {
	speed_v4_us
	speed_v4_eu
	speed_v4_au
	speed_v4_other
}
speed_v4_all() {
	speed_v4_asia
	speed_v4_not_asia
}
speed_v6_all() {
    speed_test_v6 'http://speedtest.atlanta.linode.com/100MB-atlanta.bin' 'Linode, Atlanta, GA'
    speed_test_v6 'http://speedtest.dallas.linode.com/100MB-dallas.bin' 'Linode, Dallas, TX'
    speed_test_v6 'http://speedtest.newark.linode.com/100MB-newark.bin' 'Linode, Newark, NJ'
    speed_test_v6 'http://speedtest.sjc03.softlayer.com/downloads/test100.zip' 'Softlayer, San Jose, CA'
    speed_test_v6 'http://speedtest.wdc01.softlayer.com/downloads/test100.zip' 'Softlayer, Washington, WA'
    speed_test_v6 'http://speedtest.par01.softlayer.com/downloads/test100.zip' 'Softlayer, Paris, FR'
    speed_test_v6 'http://lg-nz.zappiehost.com/100MB.test' 'Zappiehost, New Zealand'
}

origin_all() {
	ipv6=$( wget -qO- -t1 -T2 ipv6.icanhazip.com )
	clear
	next
	printf "%-32s%-24s%-14s\n" "Node Name" "IPv4 address" "Download Speed"
	speed_v4_all && next
	if [[ "$ipv6" != "" ]]; then
	    printf "%-32s%-24s%-14s\n" "Node Name" "IPv6 address" "Download Speed"
	    speed_v6 && next
	fi
}
origin_asia() {
	printf "%-32s%-24s%-14s\n" "Node Name" "IPv4 address" "Download Speed"
	speed_v4_asia && next
}
origin_not_asia() {
	printf "%-32s%-24s%-14s\n" "Node Name" "IPv4 address" "Download Speed"
	speed_v4_not_asia && next
}

echo -n "0:url 1:all 2:asia 3:not_asia"
read choice

case ${choice} in
	0)	speed_test_url
	;;
	1)	origin_all
	;;
	2)	origin_asia
	;;
	3)	origin_not_asia
esac
