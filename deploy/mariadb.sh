echo "# MariaDB 10.2 CentOS repository list - created 2014-03-12 12:47 UTC
# http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.2/centos6-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo

echo "# MariaDB 10.0 CentOS repository list - created 2014-03-12 12:47 UTC
# http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.0/centos6-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo

yum install MariaDB-server MariaDB-client -y

chkconfig mysql on && service mysql start
mysqladmin -u root password 'newpassword'

service mysql stop
mysqld_safe --skip-grant-tables &

mysql -uroot -p

use mysql;
update user set password=PASSWORD("newpassword") where user="root";
flush privileges;
\q

service mysql restart
