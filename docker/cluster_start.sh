#!/bin/bash

export DOCKERNAME_HAPROXY="haproxy"
export DOCKERNAME_MYSQL_HAPROXY="mysqlhaproxy"
export DOCKERNAME_APACHE1="apache1"
export DOCKERNAME_APACHE2="apache2"
export DOCKERNAME_WILDFLY1="wildfly1"
export DOCKERNAME_WILDFLY2="wildfly2"
export DOCKERNAME_MYSQLDB1="mysqldb1"
export DOCKERNAME_MYSQLDB2="mysqldb2"

docker start $DOCKERNAME_MYSQLDB1
docker start $DOCKERNAME_MYSQLDB2
docker start $DOCKERNAME_WILDFLY1
docker start $DOCKERNAME_WILDFLY2
docker start $DOCKERNAME_APACHE1
docker start $DOCKERNAME_APACHE2
docker start $DOCKERNAME_HAPROXY
docker start $DOCKERNAME_MYSQL_HAPROXY
