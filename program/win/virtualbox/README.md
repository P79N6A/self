### 转移虚拟机所需文件
```bash
C:\Users\< 用户 >\.VirtualBox\VirtualBox.xml
与
虚拟机vdi文件夹
```
### 复制虚拟机后
```bash
# 删除旧的网卡信息
rm -rf /etc/udev/rules.d/70-persistant-net.rules
```

### 查看当前网卡
```bash
ip link show
```
