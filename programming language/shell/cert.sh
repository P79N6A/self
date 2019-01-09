#!/bin/bash

basePath="/etc/letsencrypt/live"
logFile="/var/log/cert_renew.log"

email=""

domain=""
domain2=""
# 0 1 */7 * * shell.sh >/dev/null 2>&1

function renew() {
    nginx -s stop
    /usr/bin/certbot certonly --standalone --email $email -d $domain -d $domain2
    nginx
}

function newLog() {
    # strToAdd=$2
    # $1 => info error warn
    # $2 => message
    nowDate=$(date '+%Y-%m-%d %H:%M:%S')
    echo $nowDate" "$1" "$2 >> $logFile
}

function main() {
    nowTime=$(date +%s)

    cd $basePath"/"$domain
    endDate=$(openssl x509 -in cert.pem -noout -enddate | sed 's/^.*=//g')
    endTime=$(date -d "$endDate" +%s)
    # month 2592000
    endTime=$(expr $endTime - 2592000)
    if [[ $nowTime -gt $endTime ]];then
        newLog "error" "cert expired, going to renew"
        renew
    else
        newLog "info " "cert valid"
    fi
}

main
