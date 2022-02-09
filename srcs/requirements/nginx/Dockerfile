# nginx Dockerfile

FROM debian:buster

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install nginx

COPY ./tools/* ./

CMD ["-g", "daemon off;"]
