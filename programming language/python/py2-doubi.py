import re
import urllib2

def save(file):
    f=open("ss.html","w")
    f.write(file)
    f.close
    
url="https://www.dou-bi.co/sszhfx/"
web=urllib2.urlopen(url).read()
aim=re.findall(r"<table.*?table>",web,re.S)

# 编码不为utf8，可通过encode转换
# Aim=aim[0].encode("utf8")

Aim=aim[0]

save(Aim)
