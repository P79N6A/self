import socket
import sys

# print(sys.argv[0], sys.argv[1])
# print(type(int(sys.argv[1])))

ip_port = ('0.0.0.0', int(sys.argv[1]))

print("bind at "+str(ip_port))

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(ip_port)
s.listen(5)
while True:
	conn, addr = s.accept()
	data = conn.recv(1024)
	# pointer=10240
	print(addr[0], addr[1], data)
	'''
	with open("1G.test","rb") as f:
		f_data=f.read(pointer)
		f.close
	'''
	f_data=b'1'
	for i in range(10240):
		f_data+=b'1'
	while f_data:
		try:
			conn.sendall(f_data)
			'''
			with open("1G.test","rb") as f:
				f_data=f.read(pointer)
				f.close
			pointer += pointer
			'''
		except Exception as e:
			print(e)
			break
	conn.close()
