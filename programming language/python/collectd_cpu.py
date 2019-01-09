#!/usr/bin/env python

import subprocess
import traceback


def get_cpu_usage():
    cmd = "grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}'"
    result = run(cmd)
    for line in result:
        try:
            usage = float(line)
            return usage
        except:
            raise Exception("Failed to parse cpu usage")


def run(cmd):
    try:
        result = []
        proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, close_fds=True)
        (stdout, stderr) = proc.communicate()
        output = stdout.split("\n")
        for line in output:
            if line == '':
                continue
            result.append(line)
        return result
    except Exception as err:
        raise Exception("failed to execute command: %s, reason: %s" % (' '.join(cmd), err.message))


class CPUStatMon(object):
    def __init__(self):
        self.plugin_name = "cpu_stat"
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
        self.log_verbose("Dispatching value plugin=%s, host=%s, type=%s, type_instance=%s, value=%s" %
                         (plugin, host, type, type_instance, str(value)))
        val = collectd.Values(type=type)
        val.plugin = plugin
        val.host = host
        val.type_instance = type_instance
        val.interval = self.interval
        val.values = [value]
        val.dispatch()
        self.log_verbose("Dispatched value plugin=%s, host=%s, type=%s, type_instance=%s, value=%s" %
                         (plugin, host, type, type_instance, str(value)))

    def read_callback(self):
        try:
            usage = get_cpu_usage()
            type = 'cpu_usage_percent'
            type_instance = "used"
            value = usage
            self.dispatch_value(self.plugin_name, self.hostname, type, type_instance, value)

        except Exception as exp:
            self.log_verbose(traceback.print_exc())
            self.log_verbose("plugin %s run into exception" % (self.plugin_name))
            self.log_verbose(exp.message)


if __name__ == '__main__':
    result = get_cpu_usage()
    print result

else:
    import collectd
    cpu_status_mon = CPUStatMon()
    collectd.register_config(cpu_status_mon.configure_callback)
    '''
    # register the init function
    collectd.register_init(cpu_status_mon.init)
    '''
    collectd.register_read(cpu_status_mon.read_callback)
