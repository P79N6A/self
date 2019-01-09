#### centos 6
```bash
yum clean all

curl -sL https://rpm.nodesource.com/setup_8.x | bash -
# or
curl -sL https://rpm.nodesource.com/setup_10.x | bash -

rm -rf /etc/yum.repos.d/nodesource*
# or
yum clean all

yum install nodejs
```
