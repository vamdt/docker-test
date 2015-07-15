FROM phusion/baseimage:0.9.16

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

CMD ["/sbin/my_init"]

RUN sed -i 's/archive/cn.archive/g' /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y nginx php5 php5-fpm php5-mysql php5-gd php5-dev php5-snmp

#daemon off
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini

COPY static /usr/share/nginx/html


ADD services/php-fpm.service /etc/service/php-fpm/run
ADD services/nginx.service /etc/service/nginx/run

EXPOSE 80


RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
