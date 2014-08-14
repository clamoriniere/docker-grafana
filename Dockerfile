FROM ubuntu:14.04

RUN apt-get update


#Utilities
RUN apt-get install -y net-tools inetutils-ping curl nmap socat dnsutils netcat tree unzip sudo software-properties-common

#nginx
RUN apt-get install nginx -y
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

ADD nginx.conf  /etc/nginx/sites-available/
RUN cd /etc/nginx/sites-enabled/ && ln -s ../sites-available/nginx.conf
RUN rm -f /etc/nginx/sites-enabled/default

#grafana
RUN curl -L http://grafanarel.s3.amazonaws.com/grafana-1.7.0.tar.gz | tar xz
RUN mv grafana* grafana
RUN ls grafana

#Configuration

#grafana conf
ADD config.js /grafana/config.js

EXPOSE 80

ENTRYPOINT nginx
