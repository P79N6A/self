# backup base repo
```bash
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
```

# aliyun
```bash
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
```

# 163
```bash
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS6-Base-163.repo
```

# ustc
```bash
wget -O /etc/yum.repos.d/CentOS-Base.repo http://centos.ustc.edu.cn/CentOS-Base.repo
```

# generate new cache
```bash
yum clean all
yum makecache
yum update
```
