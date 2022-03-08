# nginx Dockerfile

FROM debian:buster

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install nginx vim curl gettext openssl

COPY /tools/www.conf.template /etc/nginx/conf.d/www.conf.template

COPY /tools/setup.sh /
ENTRYPOINT ["/setup.sh"]

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
