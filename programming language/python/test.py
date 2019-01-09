import socket
import requests
import json
import re

ip_port = ('127.0.0.1', 80)
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(ip_port)
s.listen(5)

class MainThread(threading.Thread):

	def __init__(self, obj):
		threading.Thread.__init__(self)
		self.obj = obj

	def run(self):
		self.obj.thread_db(self.obj)

	def stop(self):
		self.obj.thread_db_stop()

#base_url="https://test.org"
https://test.org/
adsf=2
#req=requests.session()

#text=req.get(base_url).text
#data_web=bytes(text,encoding="utf-8")

while True:
	conn, addr = s.accept()
	data_0 = conn.recv(1024)
	data = str(re.findall(b"GET /(.*?) HTTP/1\.1\r",data_0)[0], encoding="utf-8")
	print(addr[0], addr[1], data_0, data)
	try:
		req_0=requests.get("https://"+data).text
		req_0=re.sub("\"/", "\"/test.org/", req_0)
		print(req_0)
		print(re.findall("\"/(.*?)\"", req_0))
		req=bytes(req_0, encoding="utf-8")
		conn.sendall(req)
	except Exception as e:
		pass
	conn.close()
