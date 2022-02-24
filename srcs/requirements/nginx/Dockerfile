# nginx Dockerfile

FROM debian:buster

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install nginx vim curl

COPY ./tools/* ./

RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509\
	-subj "/C=KR/ST=SEOUL/L=Gaepo-dong/O=42Seoul/OU=yjung/CN=localhost"\
	-keyout localhost.dev.key -out localhost.dev.crt; \
	mv localhost.dev.crt /etc/ssl/certs/;	\
	mv localhost.dev.key /etc/ssl/private/; \
	chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key;

RUN cp ./default /etc/nginx/sites-available/default;

EXPOSE 443
# ENTRYPOINT ["nginx"]
# CMD ["-g", "daemon off;"]

ENTRYPOINT [ "/bin/bash" ]
CMD ["nginx", "-g", "daemon off;"]
