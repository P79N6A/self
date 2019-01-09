### python3 没反应
```
<babun installation dir>\update.bat
```

### python3 apscheduler模块报错
```bash
TZ='Asia/Shanghai'; export TZ
```

### nginx 启动失败
```bash
# error while loading shared libraries: cygcrypt-0.dll
pact remove libcrypt0
pact install libcrypt0
mkdir /var/log/nginx && touch /var/log/nginx/error.log
mkdir -p /var/lib/nginx/tmp/
```

### php-fpm 启动失败
```bash
# unable to remap cygwebp-7.dll to same address as parent

find /bin /lib /usr -iname '*.so' > /tmp/to_rebase.lst
find /bin /lib /usr -iname '*.dll' >> /tmp/to_rebase.lst
# quit all cygwin shells and stop all cygwin processes
# run as Administrator C:\cygwin\bin\ash.exe
/bin/rebaseall -T /tmp/to_rebase.lst
# last restart machine
```
