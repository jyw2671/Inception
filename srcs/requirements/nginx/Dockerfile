# nginx Dockerfile

FROM debian:buster

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install nginx

COPY ./tools/* ./

RUN mv inception.crt /etc/ssl/certs/inception.crt;  \
    mv inception.key /etc/ssl/certs/inception.key;

CMD ["-g", "daemon off;"]
