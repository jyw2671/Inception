# wordpreess Dockerfile

FROM debian:buster

RUN apt-get -y update && \
    apt-get -y install php7.3 \
    php-fpm \
    php-cli \
    wget \
    curl \
    php-mysql \
    php-mbstring \
    php-xml

COPY ./tools/* ./

EXPOSE 9000

ENTRYPOINT [ "/bin/bash" ]

CMD [ "wordpress.sh" ]
