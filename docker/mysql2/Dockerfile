FROM wnameless/mysql-phpmyadmin
MAINTAINER Robbert vd Zon <robbert@vdzon.com>

RUN apt-get update
RUN apt-get install -y vim


RUN mkdir /data
COPY config.sh /data/config.sh
COPY contact.sql /data/contact.sql
RUN chmod a+x /data/config.sh
RUN /data/config.sh

CMD service apache2 start; \
    mysqld_safe --gtid_mode=ON --log-bin --log-slave-updates --enforce-gtid-consistency