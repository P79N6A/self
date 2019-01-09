import socket
import sys
import threading

def dd(addr):
    # time = 0
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # baseMsg = ''
    # for x in range(1):
    #     baseMsg += '0'

    while True:
        # time = time + 1
        # msg = baseMsg + " count: " + str(time)
        # sock.sendto( bytes(msg, encoding='utf8'), addr )
        # sock.sendto( bytes(baseMsg, encoding='utf8'), addr )
        sock.sendto( b'0', addr )

def mudd(addr):
    t_list = []
    for x in range(5):
        t_list.append( threading.Thread(target=dd, args=[addr]) )

    for t in t_list:
        t.start()

def getAddress():
    ip = input("remote ip (default: 127.0.0.1) : ")
    if ip=='':
        ip = '127.0.0.1'
    port = input("remote port (default: 80) : ")
    if port == '':
        port = 80
    elif not port.isdigit():
        print('please input the valid remote udp_server port: ')
        port = int(input("remote port: "))
    else:
        port = int(port)
    return (ip,port)

def main():
    addr = getAddress()
    print(addr)
    mudd(addr)
    


if __name__ == '__main__':
    main()
