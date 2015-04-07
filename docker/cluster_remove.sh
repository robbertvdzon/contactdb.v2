#!/bin/bash

export DOCKERNAME_HAPROXY="haproxy"
export DOCKERNAME_MYSQL_HAPROXY="mysqlhaproxy"
export DOCKERNAME_APACHE1="apache1"
export DOCKERNAME_APACHE2="apache2"
export DOCKERNAME_WILDFLY1="wildfly1"
export DOCKERNAME_WILDFLY2="wildfly2"
export DOCKERNAME_MYSQLDB1="mysqldb1"
export DOCKERNAME_MYSQLDB2="mysqldb2"

docker rm -f $DOCKERNAME_HAPROXY
docker rm -f $DOCKERNAME_MYSQL_HAPROXY
docker rm -f $DOCKERNAME_APACHE1
docker rm -f $DOCKERNAME_APACHE2
docker rm -f $DOCKERNAME_WILDFLY1
docker rm -f $DOCKERNAME_WILDFLY2
docker rm -f $DOCKERNAME_MYSQLDB1
docker rm -f $DOCKERNAME_MYSQLDB2
