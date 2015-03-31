#!/bin/bash

# public port numbers
export HAPROXY_PORT="80"
export HAPROXY_ADMIN_PORT="81"

export APACHE_PORT1="84"
export APACHE_PORT2="85"
export APACHE_SSH_PORT1="1122"
export APACHE_SSH_PORT2="1222"
export WILDFLY_SSH_PORT1="1322"
export WILDFLY_SSH_PORT2="1422"
export MYSQL_SSH_PORT1="1522"
export MYSQL_SSH_PORT2="1622"

export MYPHPADMIN_PORT1="1082"
export MYPHPADMIN_PORT2="1182"
export WILDFLY_ADMIN_PORT1="1090"
export WILDFLY_ADMIN_PORT2="1190"
export WILDFLY_DEBUG_PORT1="1087"
export WILDFLY_DEBUG_PORT2="1187"
export WILDFLY_APP_PORT1="1088"
export WILDFLY_APP_PORT2="1188"

# docker names
export DOCKERNAME_HAPROXY="haproxy"
export DOCKERNAME_APACHE1="apache1"
export DOCKERNAME_APACHE2="apache2"
export DOCKERNAME_WILDFLY1="wildfly1"
export DOCKERNAME_WILDFLY2="wildfly2"
export DOCKERNAME_MYSQLDB1="mysqldb1"
export DOCKERNAME_MYSQLDB2="mysqldb2"

docker rm -f $DOCKERNAME_HAPROXY
docker rm -f $DOCKERNAME_APACHE1
docker rm -f $DOCKERNAME_APACHE2
docker rm -f $DOCKERNAME_WILDFLY1
docker rm -f $DOCKERNAME_WILDFLY2
docker rm -f $DOCKERNAME_MYSQLDB1
docker rm -f $DOCKERNAME_MYSQLDB2

# build and run mysql container
docker build -t robbertvdzon/$DOCKERNAME_MYSQLDB1 ./mysql
docker run -d -p $MYSQL_SSH_PORT1:22 -p $MYPHPADMIN_PORT1:80 --name $DOCKERNAME_MYSQLDB1 robbertvdzon/$DOCKERNAME_MYSQLDB1

# build and run mysql container
docker build -t robbertvdzon/$DOCKERNAME_MYSQLDB2 ./mysql
docker run -d -p $MYSQL_SSH_PORT2:22 -p $MYPHPADMIN_PORT2:80 --name $DOCKERNAME_MYSQLDB2 robbertvdzon/$DOCKERNAME_MYSQLDB2

# build and run wildfly container
docker build -t robbertvdzon/$DOCKERNAME_WILDFLY1 ./wildfly
docker run -d -it -p $WILDFLY_SSH_PORT1:22 -p $WILDFLY_DEBUG_PORT1:8787 -p $WILDFLY_ADMIN_PORT1:9990 -p $WILDFLY_APP_PORT1:8080 --name $DOCKERNAME_WILDFLY1 --link $DOCKERNAME_MYSQLDB1:mysqldb robbertvdzon/$DOCKERNAME_WILDFLY1

# build and run wildfly container
docker build -t robbertvdzon/$DOCKERNAME_WILDFLY2 ./wildfly
docker run -d -it -p $WILDFLY_SSH_PORT2:22 -p $WILDFLY_DEBUG_PORT2:8787 -p $WILDFLY_ADMIN_PORT2:9990 -p $WILDFLY_APP_PORT2:8080 --name $DOCKERNAME_WILDFLY2 --link $DOCKERNAME_MYSQLDB2:mysqldb robbertvdzon/$DOCKERNAME_WILDFLY2

# build and run apache container
docker build -t robbertvdzon/$DOCKERNAME_APACHE1 ./apache
docker run -d -it -p $APACHE_SSH_PORT1:22 -p $APACHE_PORT1:80 --link $DOCKERNAME_WILDFLY1:wildfly --name $DOCKERNAME_APACHE1 robbertvdzon/$DOCKERNAME_APACHE1

docker build -t robbertvdzon/$DOCKERNAME_APACHE2 ./apache2
docker run -d -it -p $APACHE_SSH_PORT2:22 -p $APACHE_PORT2:80 --link $DOCKERNAME_WILDFLY2:wildfly --name $DOCKERNAME_APACHE2 robbertvdzon/$DOCKERNAME_APACHE2

# build and run haproxy container
docker build -t robbertvdzon/$DOCKERNAME_HAPROXY ./haproxy
docker run -d -it -p 80:80 -p 81:81 --name $DOCKERNAME_HAPROXY --link $DOCKERNAME_APACHE1:apache1 --link $DOCKERNAME_APACHE2:apache2 robbertvdzon/$DOCKERNAME_HAPROXY
