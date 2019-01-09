# python 3
import subprocess
import re
import os
import sys

def check4(ip):
	if len(re.findall(":",ip)) == 0:
		return 4
	else:
		return 6

def checkfile(file):
	if os.path.isfile(file):
		print("文件存在\n")
	else:
		print("文件不存在！\n")
		os.system("pause")
		sys.exit()

def writeserver():
	file0 = open("server.txt", 'w')
	file0.write("")
	file0.close()
	file1 = open("gui-config.json", 'rb')
	data = file1.read()
	file1.close()
	server_raw = re.findall(b'"server" : "(.*?)",', data)
	for r in server_raw:
		r = r.decode('utf-8')
		if check4(r) == 4:
			file2 = open("server.txt", 'a')
			file2.write(r+"\n")
			file2.close()
		else:
			continue

def readserver():
	data = []
	file = open("server.txt", "r")
	for r in file.readlines():
		r = r.strip("\n")
		data.append(r)
	file.close()
	return data

def getping(ip):
	laytency = subprocess.Popen(["ping", "-n", "1", ip], stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding="gbk")
	try:
		stdout, stderr = laytency.communicate(timeout=2)
		if stdout.find("=") != -1:
			stdout = stdout.split("=")[2].split(" ")[0]
			return stdout
		else:
			laytency.kill()
			return stdout
	except subprocess.TimeoutExpired as e:
		laytency.kill()
		return "超时"

def gettcping(ip, port):
	laytency = subprocess.Popen([os.getcwd() + "\\tcping", "-n", "1", ip, port], stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding="gbk")
	try:
		stdout, stderr = laytency.communicate(timeout=2)
		if stdout.find("=") != -1:
			stdout = stdout.split("=")[1].split(" ")[0]
			return stdout
		else:
			laytency.kill()
			return stdout
	except subprocess.TimeoutExpired as e:
		laytency.kill()
		return "超时"

def testtcp():
	servers = readserver()
	for server in servers:
		print (server, "端口:", port, gettcping(server, port))

def testping():
	servers = readserver()
	for server in servers:
		print (server, "ping", getping(server))

print ("\n此程序会从gui-config.json获取测试服务器，请确保文件夹中存在此文件！")
print ("TCP端口测试依赖tcping.exe，请确保文件夹中存在此文件！\n")
print ("检查gui-config.json是否存在...")
checkfile("gui-config.json")

print ("检查tcping.exe是否存在...")
checkfile("tcping.exe")

test = input("输入0：测试ping\n输入1：测试tcping\n输入2：测试ping和tcping\n\n请输入您的测试项目：")

if test != "0" and test != "1" and test != "2":
	print ("请输入正确内容！")
if test == "1" or test == "2":
	port = input("请输入您的测试端口：")
	print ("")

writeserver()

if 'port' in dir():
	if test == "1":
		testtcp()
	elif test == "2":
		testtcp()
		testping()
else:
	print ("")
	testping()

os.system("pause")
