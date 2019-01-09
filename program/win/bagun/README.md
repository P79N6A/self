### 简介
修改版Cygwin，自带包管理、zsh<br />
官网：http://babun.github.io/<br />
Github：https://github.com/babun/babun
#### 安装babun
在官网下载安装包，约300MB，解压
进去，Shift加鼠标右键，在此处打开命令窗口
```
# 文件夹若带空格，也不需要引号
.\install.bat /t "D:\Program Files\target_folder"
```

#### 代理
```bash
# 改成你们自己的socks5
cat >> ~/.babunrc << 'EOF'
export http_proxy=http://127.0.0.1:8888
export https_proxy=$http_proxy
EOF
```

#### 环境准备
```
# 更新
# 进入babun的安装路径，运行update.bat

# https://github.com/max2max/self/blob/master/win/bagun/error.md
# nginx 启动失败 与 php-fpm 启动失败

# https://github.com/max2max/self/blob/master/win/bagun/init.md
# git config 与 .ssh 与 path

# .ssh这一步之前，请先在visual studio添加公钥
# https://lolier.visualstudio.com/_details/security/tokens 在此处添加公钥
# 相应的公钥与私钥请预先准备，通过putty生成

```

#### 安装nginx、php和mysql客户端
```bash
pact remove tzdata
pact install tzdata php php-phar php-json php-zlib php-curl php-gd php-mbstring php-pdo_mysql
pact install nginx mysql

echo "\nexport PATH=\$PATH:/usr/sbin" >> ~/.babunrc
mkdir -p /var/lib/nginx/tmp/client_body
mkdir /var/log/nginx
touch /var/log/nginx/access.log
touch /var/log/nginx/error.log

cat >> /etc/my.cnf << EOF
[client]
host=127.0.0.1
EOF
```

#### 安装mysql服务端
https://downloads.mariadb.org/interstitial/mariadb-10.2.15/winx64-packages/mariadb-10.2.15-winx64.msi/from/http%3A//mirrors.neusoft.edu.cn/mariadb/<br />
下载安装即可

#### 设置Terminal右键复制
打开babun，在蓝色窗口栏上，右键 -> Options -> Mouse -> Click actions -> Right mouse button<br />
选择menu，Apply，然后Save

#### git clone
进入 https://×××.visualstudio.com/_git/××× ， 打开 Code，第二层顶栏有个 Clone，点击后选择 SSH<br />
git clone ssh那个地址

#### git操作
```bash
git add 修改的文件
git commit
git push origin
```

#### ss-panel源码
php composer.phar install 会出错，所以只能从服务器打包正常运行的网站源码，解压下来，这样才能用
