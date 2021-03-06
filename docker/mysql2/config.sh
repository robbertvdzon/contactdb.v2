#!/bin/bash

# setup my.cnf to enable mysql to run as a slave
sed -i -e"s/^#server-id\s*=\s*1/server-id = 2/" /etc/mysql/my.cnf
sed -i -e"s/#log_bin/log_bin/" /etc/mysql/my.cnf
sed -i -e"s/^#binlog_do_db\s*=\s*include_database_name/binlog_do_db = contact/" /etc/mysql/my.cnf
sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

echo "mysqld: ALL" >> /etc/hosts.allow
chown mysql:mysql /var/lib/mysql

# run mysqld
mysqld_safe &
mysqladmin --silent --wait=30 ping 

mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;"

# user for haproxy to be able to ping
mysql -u root -p -e "INSERT INTO mysql.user (Host,User) values ('%','haproxy_check'); FLUSH PRIVILEGES;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO 'haproxy_root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES"

mysql -u root < /data/contact.sql

# setup the slave configuration
mysql -e "create user 'replicator'@'%' identified by 'password';"
mysql -e "grant replication slave on *.* to 'replicator'@'%'; "
mysql -e "slave stop; "
mysql -e "CHANGE MASTER TO MASTER_HOST = '172.17.42.1', MASTER_PORT = 13306, MASTER_USER = 'replicator', MASTER_PASSWORD = 'password', MASTER_LOG_FILE = 'mysql-bin.000001', MASTER_LOG_POS = 2153;"
mysql -e "slave start; "
mysql -e "show master status; "
