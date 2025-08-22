#!/bin/bash

#apt update

apt-get install -y mysql-server

#ERROR: 'su: warning: cannot change directory to /nonexistent: No such file or directory'
#SOLUTION: set 'home directory' for user mysql
#https://stackoverflow.com/questions/62987154/mysql-wont-start-error-su-warning-cannot-change-directory-to-nonexistent
# alternative may be https://ivangogogo.medium.com/docker-use-dockerfile-to-install-mysql-5-7-on-ubuntu-18-04-88e36436f1fd
usermod -d /var/lib/mysql/ mysql

sed -i 's/.*bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
# sort_buffer_size=5M

BASEDIR=$(dirname "$BASH_SOURCE")
if [ -f "$BASEDIR"/setup.sql ] ; then
	file="$BASEDIR"/setup.sql
else
    file=`mktemp`
	cat << EOF > $file
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
fi

service mysql start
mysql -u root < $file
mysql -u root --execute "CREATE SCHEMA cms"
service mysql stop