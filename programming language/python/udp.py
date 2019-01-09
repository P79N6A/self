import socket
import time
import sys
import logging

def udp_server(address):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind(address)
    print('udp_server bind at', address)
    while True:
        msg, addr = sock.recvfrom(8192)
        print(addr, msg)
        resp = time.strftime("%Y-%m-%d %H:%M:%S") + " server reply: udp connect success\n"
        # sock.sendto(resp.encode('ascii'), addr)
        sock.sendto( bytes(resp, encoding='utf8'), addr )

def udp_client(address):
    print('udp_client connect', address)
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    while True:
        msg = input("input message  : ")
        sock.sendto( bytes(msg, encoding='utf8'), address )
        msg, addr = sock.recvfrom(8192)
        print("remote message :", msg)
    # sock.connect(address)

def main():
    if len(sys.argv)==1:
        test_type = input("1 udp_server   2 udp_client   : ")
        if test_type == '1':
            ip = input("bind ip (default: 0.0.0.0) : ")
            if ip=='':
                ip='0.0.0.0'
            port = input("bind port: ")
            if not port.isdigit():
                print('please input the valid local udp_server port: ')
                port = input("bind port: ")
                udp_server((ip,int(port)))
            else:
                udp_server((ip,int(port)))
        elif test_type == '2':
            ip = input("remote ip (default: 127.0.0.1) : ")
            if ip=='':
                ip='127.0.0.1'
            port = input("remote port: ")
            if not port.isdigit():
                print('please input the valid remote udp_server port: ')
                port = input("remote port: ")
                udp_client((ip,int(port)))
            else:
                udp_client((ip,int(port)))


if __name__ == '__main__':
    # udp_server(('', 20000))
    main()
