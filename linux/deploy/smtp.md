#### for Centos 6.9 x64
#### 安装
```bash
yum install postfix -y
yum install cyrus* -y
yum install opendkim -y

yum remove sendmail -y

alternatives --config mta
# 按 Enter 来保存当前选择[+]，或键入选择号码：1

alternatives --display mta
```

#### 编辑 ```/etc/postfix/main.cf```
```bash
myhostname = localhost  //76行，将等号后面的部分改写为本机主机名
mydomain = 51yip.com   //82行，设置域名
myorigin = $mydomain   //97行，把$myhostname改为$mydomain
inet_interfaces = all  //112行，把后面的localhost改成all
mydestination = $myhostname, localhost.$mydomain, localhost,$mydomain //163行，把前面的注释拿掉，并加一下$mydomain
mynetworks = 192.168.0.0/24, 127.0.0.0/8  //263行，设置内网和本地IP
local_recipient_maps =  //209行，把前面的注释拿掉。
smtpd_banner = $myhostname ESMTP unknow //568行，把前面的注释拿掉，然后把$mail_name ($mail_version)改成unknow

# 在main.cf文件的底部加上以下内容
smtpd_sasl_auth_enable = yes     //使用SMTP认证
broken_sasl_auth_clients = yes   //让不支持RFC2554的smtpclient也可以跟postfix做交互。
smtpd_sasl_local_domain = $myhostname  // 指定SMTP认证的本地域名
smtpd_sasl_security_options = noanonymous //取消匿名登陆方式
smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination //设定邮件中有关收件人部分的限制
smtpd_sasl_security_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination //设置允许范围
message_size_limit = 15728640     //邮件大小
mailbox_transport=lmtp:unix:/var/lib/imap/socket/lmtp   //设置连接cyrus-imapd的路径
```

#### 编辑  ```/etc/sasl2/smtpd.conf```
```bash
vim /etc/sasl2/smtpd.conf
# 添加以下内容
log_level: 3     //记录log的模式
saslauthd_path:/var/run/saslauthd/mux     //设置一下smtp寻找cyrus-sasl的路径
```

#### 设置dkim验证
```bash
export domain=smtp.1.org
mkdir /etc/opendkim/keys/$domain
cd /etc/opendkim/keys/$domain
opendkim-genkey -d $domain -s default
chown -R opendkim:opendkim /etc/opendkim/keys/$domain
echo "default._domainkey.$domain $domain:default:/etc/opendkim/keys/$domain/default.private" >> /etc/opendkim/KeyTable

# 不同域名选择不同的签名密钥，设置后，gmail会显示 signed by
# 没特殊需求，不需要改这个
echo "*@$domain default._domainkey.$domain" >> /etc/opendkim/SigningTable

# 上例中，*@$domain 结尾的邮件，会用 default._domainkey.$domain 加密
# 如 noreply@1.org ,会用default._domainkey.$domain，后面这个domain就是gmail里面的signed-by

# 接下来在dns上设置 dkim密钥
# /etc/opendkim/keys/$domain/default.txt，里面就有需要的DKIM key
# 添加一个 txt记录
# 主机记录为default._domainkey（这个也是selector），记录值为括号里面的（去掉所有引号），如下
# v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3... 没有引号和换行符！

# 编辑 /etc/opendkim.conf
vim /etc/opendkim.conf
# 1. 将Mode v 改为 Mode sv
# 2. 将Domain 改为 Domain test.com(test.com是之前设置的域名)
# 3. 将所有变量前面的 # 去掉，但是KeyFile、Statistics加上#
# 4. SigningTable /etc/opendkim/SigningTable 改成
#    SigningTable refile:/etc/opendkim/SigningTable

# 编辑 /etc/postfix/main.cf
vim /etc/postfix/main.cf
# 添加以下内容
# opendkim setup
smtpd_milters = inet:127.0.0.1:8891
non_smtpd_milters = inet:127.0.0.1:8891
milter_default_action = accept

# 编辑 /etc/sasl2/smtpd.conf
vim /etc/sasl2/smtpd.conf
# 添加以下内容
log_level: 3
saslauthd_path:/var/run/saslauthd/mux

# 重启opendkim和postfix
service opendkim restart
service postfix restart
```

#### 设置spf记录
添加一个MX记录，名称（主机名）为@，值为发邮件的域名，优先级设为10（随意，这里只设置一个）<br />
添加一个TXT记录，名称（主机名）为@，值为```v=spf1 a mx ~all```<br />
这样就只能用a记录和mx记录的主机发件了，其他设置请自行摸索<br />

#### 设置dmarc记录
设置一个邮箱地址，从这个邮箱发送的邮件，如果未通过spf和dkim验证，则会被拒收<br />
添加TXT记录<br />
主机名：_dmarc<br />
记录值：v=DMARC1;p=reject;rua=noreply@1.org<br />

#### 设置tls加密
```bash
# 编辑 /etc/postfix/main.cf
vim /etc/postfix/main.cf
# 添加以下内容
# 相应的密钥请自行准备，我用的是 Let`s encrypt 的免费密钥
smtp_use_tls = yes
smtp_enforce_tls = yes
smtp_tls_loglevel = 1
smtp_tls_security_level = may
smtp_tls_note_starttls_offer = yes
smtp_tls_session_cache_timeout = 3600s
smtp_tls_key_file = /etc/letsencrypt/live/smtp.1.org/privkey.pem
smtp_tls_CAfile = /etc/letsencrypt/live/smtp.1.org/fullchain.pem
smtp_tls_cert_file = /etc/letsencrypt/live/smtp.1.org/fullchain.pem
smtp_tls_session_cache_database = btree:/var/lib/postfix/smtp_tls_session_cache
# inbound
smtpd_tls_protocols=!SSLv2,!SSLv3
smtpd_tls_mandatory_protocols=!SSLv2,!SSLv3
# outbound
smtp_tls_protocols=!SSLv2,!SSLv3
smtp_tls_mandatory_protocols=!SSLv2,!SSLv3

# 编辑 master.cf
# 去掉下面几行的注释
smtps     inet  n       -       n       -       -       smtpd
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
```

#### 修改smtp端口，针对主机商封端口
```bash
# 编辑 /etc/postfix/master.cf
vim /etc/postfix/master.cf
# 找到下面内容
smtp      inet  n       -       n       -       －     smtpd
# 添加以下内容
smtp2      inet  n       -       n       -       -       smtpd

# 编辑 /etc/services
vim /etc/services
# 找到下面这个
smtp            25/tcp          mail
# 在其后添加
smtp2           2525/tcp        mail2
smtp2           2525/udp        mail2
```

#### 开机启动
```bash
chkconfig postfix on
chkconfig saslauthd on
chkconfig cyrus-imapd on
chkconfig opendkim on
/etc/init.d/opendkim start
/etc/init.d/postfix start
/etc/init.d/saslauthd start
/etc/init.d/cyrus-imapd start
```

#### 日志
```bash
tail -f /var/log/messages //opendkim
tail -f /var/log/maillog //postfix 等
```

#### 用户cyrus
```bash
# 设置cyrus的密码
passwd cyrus
# 测试
testsaslauthd -u cyrus -p '******'
# 或
cyradm -u cyrus localhost --auth plain

# 或者新建其他用户，不用cyrus
# 创建用户1
cm 1
# 赋予cyrus删除用户1的权限
sam 1 cyrus all
# 删除用户1
dm 1
```

#### smtp测试
```bash
openssl s_client -connect smtp.1.org:25 -starttls smtp

# 生成smtp用户与密码的base64编码结果，用以验证telnet smtp连接
# 这里以 用户：cyrus 密码：passwd 为例
# 当然，前提是安装好了perl
perl -e 'use MIME::Base64; print encode_base64("cyrus")'
perl -e 'use MIME::Base64; print encode_base64("passwd")'

telnet smtp.1.org 25
HELO localhost
AUTH LOGIN //之后第一次输入用户名，第二次输入密码

# 发邮件
MAIL FROM:<noreply@1.org>
RCPT TO:<1@qq.com>
RCPT TO:<12@qq.com>
DATA
From:redsos3@163.com
To:yourframe@21cn.com 
Subject:test mail
test body
.

# 退出
QUIT
```

#### smtp设置
```php
# 以ss-panel魔改版中的设置为例
# smtp
$System_Config['smtp_host'] = '127.0.0.1';  //服务器ip或域名
$System_Config['smtp_username'] = 'cyrus';  //服务器邮件管理账号
$System_Config['smtp_port'] = '25';  //端口
$System_Config['smtp_name'] = 'test';  //发信用户名，可以自定义
$System_Config['smtp_sender'] = 'noreply@1.org';  //发信邮箱，可以自定义，这个由dkim设置了相应的加密文件，即gmail显示的 signed by
$System_Config['smtp_passsword'] = 'passwd';  //cyrus的密码
$System_Config['smtp_ssl'] = 'false';
```

#### 一些错误
##### ```postdrop: warning: inet_protocols: configuring for IPv4 support only```
```bash
# 服务器没有设置好ipv6，postfix单独启用ipv4即可
# 编辑 /etc/postfix/main.cf
vim /etc/postfix/main.cf
inet_protocols = all 改为
inet_protocols = ipv4
```
##### ```warning: request to update table btree:/var/run/smtp_tls_session_cache in non-postfix directory /var/run```
```bash
# 原来的/var/spool不能用
# 编辑 /etc/postfix/main.cf
vim /etc/postfix/main.cf
session_cache_database = btree:/var/lib/postfix/smtpd_tls_session_cache
```
