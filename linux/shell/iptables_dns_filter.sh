#!/bin/bash

list=(
awqsaged
bugsevent
biochempop
coveredsys
cqjjlsy
cuowog
cnshef
chuanxianwanguan
dogtodog
fecjf
feipukeplus
fendoutime
guaas
hnhgw
jiujcsw
jp236
kuaibaopay
ktvgz
litluxury
lqalm
lixiqin
mekbet
mgldzcls
nm121
ourlj
qhres
qvzve
r35xy
sai8
sanitwealth
sceyv
shayugg
sy123888
syma
sysapr
tuitui9999
uerzyr
v02u9
wgewj
wrvdmh
wtdjs
wonwg
wzhuze
wxgctz
wwetjy
xinshiye
xkhejx
xmgsjd
yunpifu
ydqzkj
yootui19999
zgclmw
zhuyuanp
zmyuer
09mk
1801lm
185ba
81ngn1
520siling
905w
9xzj
)

list2=(
51.la
)

str0='iptables -A OUTPUT -p udp --dport 53 -m string --algo bm --hex-string "'
str1='" -j DROP'

function clear_string_rules() {
    sed -i '/--dport 53 -m string --hex-string/d' /etc/sysconfig/iptables
    service iptables restart
}

function save_string_rules() {
    service iptables save
    service iptables restart
}

function get_string_str() {
    str=$1
    str_num=${#str}
    if [[ $str_num -lt 10 ]];then
        str_num="0$str_num"
    fi
    echo "|$str_num|$str"
}

function set_list_rules() {

    for str in ${list[@]}
    do
        string_str=$(get_string_str $str)
        command="$str0$string_str$str1"
        echo $command
        $command
    done
}

function set_list2_rules() {

    for item in ${list2[@]}
    do
        string_str=''
        OLD_IFS="$IFS"
        IFS="."
        array=($item)
        IFS="$OLD_IFS"
        for str in ${array[@]}
        do
            string_str="$string_str$(get_string_str $str)"
        done
        command="$str0$string_str$str1"
        echo $command
        $command
    done

}

function main() {
    clear_string_rules

    set_list_rules

    set_list2_rules

    save_string_rules
}

main
