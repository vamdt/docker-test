FROM phusion/baseimage:0.9.16

ENV HOME /root

CMD ["/sbin/my_init"]

RUN sed -i 's/archive/cn.archive/g' /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y dialog supervisor
RUN apt-get install -y nginx php5 php5-fpm php5-mysql php5-gd php5-dev php5-snmp

# RUN mkdir -p /var/log/supervisor


COPY static /usr/share/nginx/html

# ADD start.sh /root/start.sh

ADD php-fpm.service /etc/service/php-fpm/run
ADD nginx.service /etc/service/nginx/run

EXPOSE 80

# CMD ["/bin/bash", "/root/start.sh"]


RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
