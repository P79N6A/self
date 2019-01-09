import re
import urllib2
import time

def getpage(url,url2):
    path = "qidian" + str(url2) + ".html"
    web=urllib2.urlopen(url).read()
    aim=re.findall('\<div class\=\"all\-book\-list\"\>.*?(\<ul.*?\/ul\>).*?\<div class\=\"page\-box cf\"\>',web,re.S)
    aim=aim[0]
    aim=re.sub(r'<div class="book-img-box">.*?</div>',"",aim,20,re.S)
    aim=re.sub(r"<img.*?>","",aim,20,re.S)
    aim=re.sub(r'href="//',r'href="http://',aim)
    open(path,"w").write(aim)
    open(path).close()

def loop():
    url2 = 1
    url = "http://a.qidian.com/?size=4&sign=-1&tag=-1&chanId=-1&subCateId=-1&orderId=5&update=-1&page=" + str(url2) + "&month=-1&style=1&action=0&vip=-1"
    while (url2<101):
        getpage(url,url2)
        print url2
        url2 = url2 + 1
        url = "http://a.qidian.com/?size=4&sign=-1&tag=-1&chanId=-1&subCateId=-1&orderId=5&update=-1&page=" + str(url2) + "&month=-1&style=1&action=0&vip=-1"
        time.sleep(5)

b=1
while (b==1):
    loop()
    time.sleep(360)
