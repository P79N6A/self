```bash

user=root
password=pass

mysql -u$user -p $password

create user user1 identified by 'pass1';

create database testDb;
drop database testDb;

use testDb;
show tables;
source ./test.sql;

insert into MYTABLE values ("hyq","M");

mysqldump -u$user -p dbName > dbName.sql

mysqladmin -u root -p password 'newpassword'

mysqladmin -u root -poldpassword password 'newpassword'

grant all on testDb.* to user1@'%' identified by 'pass1';
grant all on testDb.* to user1@'192.168.56.2' identified by 'pass1';

flush privileges;

DELETE FROM code WHERE user_id = 0;

select id,node_id,online_user from code where user_id=5 order by time desc limit 10;

select id,node_id,online_user from ss_node_online_log as a where online_user=(select max(online_user) from ss_node_online_log where node_id=a.node_id) group by node_id;

update user set last_day_t=0;

delete from node_traffic_log_count where node_id=29;

```

#### 查看各表的大小
```mysql
use information_schema;
select TABLE_NAME,TABLE_ROWS,concat(round((DATA_LENGTH+INDEX_LENGTH)/1024/1024,2),' MB') as size from TABLES where TABLE_SCHEMA='testsorg';

# 结果
+--------------------------------+------------+-----------+
| TABLE_NAME                     | TABLE_ROWS | size      |
+--------------------------------+------------+-----------+
| alive_ip                       |    2045184 | 120.66 MB |
| amount_pending                 |       1603 | 0.14 MB   |
| announcement                   |         32 | 0.05 MB   |
| auto                           |          0 | 0.02 MB   |
| blockip                        |       4929 | 0.30 MB   |
+--------------------------------+------------+-----------+
```

#### 查看表的创建语句
```mysql
use databaseorg;
show create table this_table;
```
