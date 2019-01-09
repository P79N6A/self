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

get_opsy() {
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}

next() {
    printf "%-70s\n" "-" | sed 's/\s/-/g'
}

speed_test() {
    local speedtest=$(wget -4O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
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
speed() {
    speed_test 'http://cachefly.cachefly.net/100mb.test' 'CacheFly'
    speed_test 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP'
    speed_test 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, SG'
    speed_test 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
    speed_test 'http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin' 'Linode, Frankfurt, DE'
    speed_test 'http://speedtest.fremont.linode.com/100MB-fremont.bin' 'Linode, Fremont, CA'
    speed_test 'http://speedtest.dal05.softlayer.com/downloads/test100.zip' 'Softlayer, Dallas, TX'
    speed_test 'http://speedtest.syd01.softlayer.com/downloads/test100.zip' 'Softlayer, Sydney, Australia'
    speed_test 'http://speedtest.sea01.softlayer.com/downloads/test100.zip' 'Softlayer, Seattle, WA'
    speed_test 'http://speedtest.fra02.softlayer.com/downloads/test100.zip' 'Softlayer, Frankfurt, DE'
    speed_test 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, SG'
    speed_test 'http://speedtest.hkg02.softlayer.com/downloads/test100.zip' 'Softlayer, HK'
    speed_test 'http://speedtest-nyc1.digitalocean.com/100mb.test' 'DigitalOcean, NYC1'
    speed_test 'http://speedtest-sfo1.digitalocean.com/100mb.test' 'DigitalOcean, SFO1'
    speed_test 'http://speedtest-sfo2.digitalocean.com/100mb.test' 'DigitalOcean, SFO2'
    speed_test 'http://speedtest-sgp1.digitalocean.com/100mb.test' 'DigitalOcean, SG-1'
    speed_test 'http://speedtest-lon1.digitalocean.com/100mb.test' 'DigitalOcean, London-1, UK'
    speed_test 'https://sgp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, SG'
    speed_test 'http://hnd-jp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, JP'
    speed_test 'http://syd-au-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Sydney, Australia'
    speed_test 'https://mirror.sg.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, SG'
    speed_test 'https://mirror.hk.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, HK'
    speed_test 'https://mirror.de.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Germany'
    speed_test 'http://sg.lg.pzea.com/100MB.test' 'pzea.com, SG'
    speed_test 'http://hk.lg.pzea.com/100MB.test' 'pzea.com, HK'
    speed_test 'http://lgvn.greencloudvps.com/100MB.test' 'GreenCloudVPS, Hanoi, Vietnam'
    speed_test 'https://www.here-host.com/looking-glass/100MB.test' 'HereHost, Sofia, Bulgaria'
    speed_test 'http://tok1.lg.vpsto.com/100MB.test' 'VPS.TO, Tokyo, JP'
    speed_test 'http://lg.time4vps.eu/100MB.test' 'time4vps, Unknown, Lithuania'
    speed_test 'http://lg.tw.psychz.net/200MB.test' 'psychz, Taipei, TW'
    speed_test 'http://lg.tw.psychz.net/200MB.test' 'psychz, Johannesburg, South Africa'
    speed_test 'http://lg.lon.psychz.net/200MB.test' 'psychz, London, UK'
    speed_test 'http://92.223.60.98/100MB.test' '50kvm, Khabarovsk, RU'
    speed_test 'http://speedtest.c1.sin1.dediserve.com/100MB.test' 'Dediserve, SG'
    speed_test 'http://speedtest.c1.vie1.dediserve.com/100MB.test' 'Dediserve, Vienna, Austria, EU'
    speed_test 'http://singapore-lg.indovirtue.com/100MB.test' 'IndoVirtue, SG'
}
speed_v6() {
    speed_test_v6 'http://speedtest.atlanta.linode.com/100MB-atlanta.bin' 'Linode, Atlanta, GA'
    speed_test_v6 'http://speedtest.dallas.linode.com/100MB-dallas.bin' 'Linode, Dallas, TX'
    speed_test_v6 'http://speedtest.newark.linode.com/100MB-newark.bin' 'Linode, Newark, NJ'
    speed_test_v6 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
    speed_test_v6 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP'
    speed_test_v6 'http://speedtest.sjc03.softlayer.com/downloads/test100.zip' 'Softlayer, San Jose, CA'
    speed_test_v6 'http://speedtest.wdc01.softlayer.com/downloads/test100.zip' 'Softlayer, Washington, WA'
    speed_test_v6 'http://speedtest.par01.softlayer.com/downloads/test100.zip' 'Softlayer, Paris, FR'
    speed_test_v6 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
    speed_test_v6 'http://speedtest.tok02.softlayer.com/downloads/test100.zip' 'Softlayer, Tokyo, JP'
}
io_test() {
    (LANG=C dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END { print io}' | sed 's/^[ \t]*//;s/[ \t]*$//'
}
calc_disk() {
    local total_size=0
    local array=$@
    for size in ${array[@]}
    do
        [ "${size}" == "0" ] && size_t=0 || size_t=`echo ${size:0:${#size}-1}`
        [ "`echo ${size:(-1)}`" == "K" ] && size=0
        [ "`echo ${size:(-1)}`" == "M" ] && size=$( awk 'BEGIN{printf "%.1f", '$size_t' / 1024}' )
        [ "`echo ${size:(-1)}`" == "T" ] && size=$( awk 'BEGIN{printf "%.1f", '$size_t' * 1024}' )
        [ "`echo ${size:(-1)}`" == "G" ] && size=${size_t}
        total_size=$( awk 'BEGIN{printf "%.1f", '$total_size' + '$size'}' )
    done
    echo ${total_size}
}
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: '/cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
tram=$( free -m | awk '/Mem/ {print $2}' )
uram=$( free -m | awk '/Mem/ {print $3}' )
swap=$( free -m | awk '/Swap/ {print $2}' )
uswap=$( free -m | awk '/Swap/ {print $3}' )
up=$( awk '{a=$1/86400;b=($1%86400)/3600;c=($1%3600)/60} {printf("%d days, %d hour %d min\n",a,b,c)}' /proc/uptime )
load=$( w | head -1 | awk -F'load average:' '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//' )
opsy=$( get_opsy )
arch=$( uname -m )
lbit=$( getconf LONG_BIT )
kern=$( uname -r )
ipv6=$( wget -qO- -t1 -T2 ipv6.icanhazip.com )
disk_size1=($( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $2}' ))
disk_size2=($( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $3}' ))
disk_total_size=$( calc_disk ${disk_size1[@]} )
disk_used_size=$( calc_disk ${disk_size2[@]} )
clear
next
echo "CPU model            : $cname"
echo "Number of cores      : $cores"
echo "CPU frequency        : $freq MHz"
echo "Total size of Disk   : $disk_total_size GB ($disk_used_size GB Used)"
echo "Total amount of Mem  : $tram MB ($uram MB Used)"
echo "Total amount of Swap : $swap MB ($uswap MB Used)"
echo "System uptime        : $up"
echo "Load average         : $load"
echo "OS                   : $opsy"
echo "Arch                 : $arch ($lbit Bit)"
echo "Kernel               : $kern"
next
printf "%-32s%-24s%-14s\n" "Node Name" "IPv4 address" "Download Speed"
speed && next
if [[ "$ipv6" != "" ]]; then
    printf "%-32s%-24s%-14s\n" "Node Name" "IPv6 address" "Download Speed"
    speed_v6 && next
fi
