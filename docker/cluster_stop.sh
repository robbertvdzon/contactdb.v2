#!/bin/bash

export DOCKERNAME_HAPROXY="haproxy"
export DOCKERNAME_MYSQL_HAPROXY="mysqlhaproxy"
export DOCKERNAME_APACHE1="apache1"
export DOCKERNAME_APACHE2="apache2"
export DOCKERNAME_WILDFLY1="wildfly1"
export DOCKERNAME_WILDFLY2="wildfly2"
export DOCKERNAME_MYSQLDB1="mysqldb1"
export DOCKERNAME_MYSQLDB2="mysqldb2"

docker stop $DOCKERNAME_HAPROXY
docker stop $DOCKERNAME_MYSQL_HAPROXY
docker stop $DOCKERNAME_APACHE1
docker stop $DOCKERNAME_APACHE2
docker stop $DOCKERNAME_WILDFLY1
docker stop $DOCKERNAME_WILDFLY2
docker stop $DOCKERNAME_MYSQLDB1
docker stop $DOCKERNAME_MYSQLDB2
