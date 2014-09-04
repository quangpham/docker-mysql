FROM sameersbn/ubuntu:14.04.20140818
MAINTAINER sameer@damagehead.com

RUN apt-get update \
 && apt-get install -y mysql-server \
 && rm -rf /var/lib/mysql/mysql \
 && rm -rf /var/lib/apt/lists/* # 20140818

ADD start /start
RUN chmod 755 /start

EXPOSE 3306

VOLUME ["/var/lib/mysql"]
VOLUME ["/var/run/mysqld"]

CMD ["/start"]
