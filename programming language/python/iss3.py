#著作权归作者所有。
#商业转载请联系作者获得授权，非商业转载请注明出处。
#作者：DIYgod
#链接：http://blog.9ishell.com/archives/149
#来源：Anotherhome Created on 2016年6月9日
#@author: seth
#脚本用于python3

import urllib.request
import re

url = 'https://www.ishadowsocks.me/'
request = urllib.request.Request(url)
request = urllib.request.urlopen(request)
pageHtml = request.read().decode('UTF-8')
request.close()
r = re.compile(r'<h4>(A|B|C)服务器地址:(.*?)</h4>(.*?)<h4>端口:(\d+?)</h4>(.*?)<h4>(A|B|C)密码:(.*?)</h4>(.*?)<h4>加密方式:(.*?)</h4>',re.S)
list =r.findall(pageHtml)
for i in range(0,3):
    print('服务器地址： %s' % list[i][1])
    print('端口：      %s' % list[i][3])
    print('密码：      %s' % list[i][6])
    print('加密方式：  %s' % list[i][8])
    print('\000')
