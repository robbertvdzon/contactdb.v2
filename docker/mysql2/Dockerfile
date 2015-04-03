FROM wnameless/mysql-phpmyadmin
MAINTAINER Robbert vd Zon <robbert@vdzon.com>

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install mysql-client

RUN mkdir /data
COPY config.sh /data/config.sh
COPY contact.sql /data/contact.sql
RUN chmod a+x /data/config.sh
RUN /data/config.sh
