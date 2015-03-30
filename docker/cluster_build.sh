#!/bin/bash

export CLUSTERNR=$1
if [ -z "$1" ]
	then
		export CLUSTERNR="1"
fi


# public port numbers
export APACHE_A_PORT=${CLUSTERNR}"084"
export APACHE_B_PORT=${CLUSTERNR}"085"
export HAPROXY_PORT=${CLUSTERNR}"080"
export APACHE_A_SSH_PORT=${CLUSTERNR}"422"
export APACHE_B_SSH_PORT=${CLUSTERNR}"522"
export WILDFLY_SSH_PORT=${CLUSTERNR}"222"
export MYSQL_SSH_PORT=${CLUSTERNR}"322"

export MYPHPADMIN_PORT=${CLUSTERNR}"081"
export WILDFLY_ADMIN_PORT=${CLUSTERNR}"090"
export WILDFLY_DEBUG_PORT=${CLUSTERNR}"087"
export WILDFLY_APP_PORT=${CLUSTERNR}"088"

# docker names
export DOCKERNAME_HAPROXY="haproxy"$CLUSTERNR
export DOCKERNAME_APACHE="apache"$CLUSTERNR
export DOCKERNAME_APACHE_A="apacheA"$CLUSTERNR
export DOCKERNAME_APACHE_B="apacheB"$CLUSTERNR
export DOCKERNAME_WILDFLY="wildfly"$CLUSTERNR
export DOCKERNAME_MYSQLDB="mysqldb"$CLUSTERNR

docker rm -f $DOCKERNAME_HAPROXY
docker rm -f $DOCKERNAME_APACHE_A
docker rm -f $DOCKERNAME_APACHE_B
#docker rm -f $DOCKERNAME_WILDFLY
#docker rm -f $DOCKERNAME_MYSQLDB

# build and run mysql container
#docker build -t robbertvdzon/$DOCKERNAME_MYSQLDB ./mysql
#docker run -d -p $MYSQL_SSH_PORT:22 -p $MYPHPADMIN_PORT:80 --name $DOCKERNAME_MYSQLDB robbertvdzon/$DOCKERNAME_MYSQLDB

# build and run wildfly container
#docker build -t robbertvdzon/$DOCKERNAME_WILDFLY ./wildfly
#docker run -d -it -p $WILDFLY_SSH_PORT:22 -p $WILDFLY_DEBUG_PORT:8787 -p $WILDFLY_ADMIN_PORT:9990 -p $WILDFLY_APP_PORT:8080 --name $DOCKERNAME_WILDFLY --link $DOCKERNAME_MYSQLDB:mysqldb robbertvdzon/$DOCKERNAME_WILDFLY

# build and run apache container
docker build -t robbertvdzon/$DOCKERNAME_APACHE ./apache
docker run -d -it -p $APACHE_A_SSH_PORT:22 -p $APACHE_A_PORT:80 --name $DOCKERNAME_APACHE_A robbertvdzon/$DOCKERNAME_APACHE
docker run -d -it -p $APACHE_B_SSH_PORT:22 -p $APACHE_B_PORT:80 --name $DOCKERNAME_APACHE_B robbertvdzon/$DOCKERNAME_APACHE

# build and run haproxy container
docker build -t robbertvdzon/$DOCKERNAME_HAPROXY ./haproxy
docker run -d -it -p $HAPROXY_PORT:80 --name $DOCKERNAME_HAPROXY --link $DOCKERNAME_APACHE_A:apache1 --link W$DOCKERNAME_APACHE_A:apache2 robbertvdzon/$DOCKERNAME_HAPROXY
