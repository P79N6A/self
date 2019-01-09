#!/usr/local/bin/python3.6
#import sys
import psutil
import platform
import traceback
import time


first=True

i=0

rx0 = 0; tx0 = 0

myinterval=10

def run(cmd):
    print("i")

def get_current_traffic():
    global i
    i=i+1
    return i

def get_current_speed():
    global rx0, tx0, myinterval, first
    if first==True:
        for name, stats in psutil.net_io_counters(pernic=True).items():
            if name == "lo" or name.find("tun") > -1:
                continue
            rx0 += stats.bytes_recv
            tx0 += stats.bytes_sent
        #time.sleep(myinterval)
        first=False
    for name, stats in psutil.net_io_counters(pernic=True).items():
        if name == "lo" or name.find("tun") > -1:
            continue
        rx1 = stats.bytes_recv
        tx1 = stats.bytes_sent
    speed1=[]
    speed1.append( int((rx1 - rx0)/myinterval) )
    speed1.append( int((tx1 - tx0)/myinterval) )
    rx0=rx1
    tx0=tx1
    return speed1

class TrafficStatMon(object):
    def __init__(self):
        self.plugin_name = "traffic_stat"
        self.interval = 30
        self.hostname = None
        self.verbose_logging = False

    def log_verbose(self, msg):
        if not self.verbose_logging:
            return
        collectd.info('%s plugin [verbose]: %s' % (self.plugin_name, msg))

    '''
    to store/initialize the internal state like a socket connection
    def init(self):
        self.SOCKET_CONN = create_sockect_conn()
    '''

    def configure_callback(self, conf):
        for node in conf.children:
            val = str(node.values[0])
            if node.key == "HostName":
                self.hostname = val
            elif node.key == 'Interval':
                self.interval = int(float(val))
            elif node.key == 'Verbose':
                self.verbose_logging = val in ['True', 'true']
            elif node.key == 'PluginName':
                self.plugin_name = val
            else:
                collectd.warning('[plugin] %s: unknown config key: %s' % (self.plugin_name, node.key))

    def dispatch_value(self, plugin, host, type, type_instance, value):

        self.log_verbose(
                            "Dispatching value plugin=%s, host=%s, type=%s, type_instance=%s, value=%s" %
                            (plugin, host, type, type_instance, str(value))
                        )

        val = collectd.Values(type=type)
        val.plugin = plugin
        val.host = host
        val.type_instance = type_instance
        val.interval = self.interval
        val.values = [value]
        val.dispatch()

        self.log_verbose(
                            "Dispatched value plugin=%s, host=%s, type=%s, type_instance=%s, value=%s" %
                            (plugin, host, type, type_instance, str(value))
                        )
        #self.log_verbose("%s" % platform.python_version())

    def read_callback(self):
        try:
            usage = get_current_speed()
            #usage = [2,2]
            type = 'bytes'

            type_instance = "dl"
            value = usage[0]
            self.dispatch_value(self.plugin_name, self.hostname, type, type_instance, value)
            type_instance = "up"
            value = usage[1]
            self.dispatch_value(self.plugin_name, self.hostname, type, type_instance, value)

        except Exception as exp:
            self.log_verbose(traceback.print_exc())
            self.log_verbose("plugin %s run into exception" % (self.plugin_name))
            self.log_verbose(exp.message)


if __name__ == '__main__':
    result = get_current_speed()
    print(result)

else:
    import collectd

    traffic_status_mon = TrafficStatMon()

    collectd.register_config(traffic_status_mon.configure_callback)

    collectd.register_read(traffic_status_mon.read_callback)

