import psutil
import time
def BytestoSize(b):
	b = b
	if b < 1024:
		b = str(b) + "B/s"
	elif b < 1024*1024:
		b = str(round(b/(1024),2)) + "KB/s"
	elif b < 1024*1024*1024:
		b = str(round(b/(1024*1024),2)) + "MB/s"
	elif b < 1024*1024*1024*1024:
		b = str(round(b/(1024*1024*1024),2)) + "GB/s"
	return b

def speed():
	rx0 = 0; tx0 = 0; rx1 = 0; tx1 = 0
	for name, stats in psutil.net_io_counters(pernic=True).items():
		if name == "lo" or name.find("tun") > -1:
			continue
		rx0 += stats.bytes_recv
		tx0 += stats.bytes_sent
	time.sleep(1)
	for name, stats in psutil.net_io_counters(pernic=True).items():
		if name == "lo" or name.find("tun") > -1:
			continue
		rx1 += stats.bytes_recv
		tx1 += stats.bytes_sent
	recv_rate = rx1 - rx0
	sent_rate = tx1 - tx0
	return recv_rate, sent_rate
	speed1=[]
	speed1.append(rx1 - rx0)
	speed1.append(tx1 - tx0)
	return speed1

recv_rate, sent_rate = speed()
recv_rate = BytestoSize(recv_rate)
sent_rate = BytestoSize(sent_rate)
print ("入站："+recv_rate, "出站："+sent_rate)
