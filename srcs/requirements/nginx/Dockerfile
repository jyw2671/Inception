# nginx Dockerfile

FROM debian:buster

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install nginx vim curl

COPY ./tools/* ./

RUN mv inception.crt /etc/ssl/certs/inception.crt;  \
    mv inception.key /etc/ssl/certs/inception.key;

RUN cp ./default /etc/nginx/sites-available/default;

CMD ["-g", "daemon off;"]
