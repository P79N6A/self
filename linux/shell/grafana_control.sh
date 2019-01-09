#!/bin/bash

function service_control() {
    service_name=$1
    read -p "1 [start] | 2 [stop] | 3 [restart]  " action
    case $action in
        1)
        action='start'
        ;;
        2)
        action='stop'
        ;;
        3)
        action='restart'
        ;;
    esac
    service $service_name $action
}

function service_choose() {
    read -p "1 [collectd] | 2 [influxdb] | 3 [grafana]  " services

    case $services in
        1)
        service_name='collectd'
        ;;
        2)
        service_name='influxdb'
        ;;
        3)
        service_name='grafana'
        ;;
        4)
        ;;
    esac
}

function view_log() {
    service_name=$1
    case $service_name in
        'collectd')
        tail -f /var/log/collectd/collectd.log
        ;;
        'influxdb')
        tail -f /var/log/influxdb/influxd.log
        ;;
        'grafana')
        tail -f /var/log/grafana
        ;;
    esac
}

function edit_conf() {
    service_name=$1
    case $service_name in
        'collectd')
        vim /etc/collectd.conf
        ;;
        'influxdb')
        vim /etc/influxdb/influxdb.conf
        ;;
        'grafana')
        tail -f /var/log/grafana
        ;;
    esac
}

read -p '1 [control] | 2 [view log] | 3 [edit_conf]  ' action

case $action in
    1)
    action='service_control'
    ;;
    2)
    action='view_log'
    ;;
    3)
    action='edit_conf'
    ;;
esac

service_choose

$action $service_name
