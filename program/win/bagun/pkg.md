```bash
# php和时区问题
pact remove tzdata
pact install tzdata php php-phar php-json php-zlib php-curl php-gd php-mbstring php-pdo_mysql php-sockets

# telnet
pact install getent
# pact install inetutils

# dig nslookup...
pact install bind-utils

# mysql
pact install mysql
cat >> /etc/my.cnf << EOF
[client]
host=127.0.0.1
EOF

# git
pact update git
```
