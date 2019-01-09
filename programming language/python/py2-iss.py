import re
import urllib2

def save(file):
    f=open("ss.html","w")
    f.write(file)
    f.close
    
url="http://www.ishadowsocks.me/"
web=urllib2.urlopen(url).read()
aim=re.findall(r'<section id="free">.*?</section>',web,re.S)
save(aim[0])

# 中文匹配
fwqdz="服务器地址".decode("gbk")
aim=re.findall(ur"服务器地址:(.*?)</h4>",web.decode("utf8"))
print aim
print aim[0]
print aim[1]
print aim[2]
Aim0=aim[0].encode("utf8")
save(Aim0)
