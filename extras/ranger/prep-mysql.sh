#!/usr/bin/env bash

mypass="${mypass:-BadPass#1"}
db_root_password="${mypass}"

sudo yum -y install mysql-server mysql-connector-java
sudo chkconfig mysqld on
sudo service mysqld start

cat << EOF | mysql -u root
GRANT ALL PRIVILEGES ON *.* to 'root'@'$(hostname -f)' WITH GRANT OPTION;
SET PASSWORD FOR 'root'@'$(hostname -f)' = PASSWORD('${db_root_password}');
FLUSH PRIVILEGES;
exit
EOF

