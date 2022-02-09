# mariadb Dockerfile

FROM debian:buster

RUN apt-get -y update && \
    apt-get -y install mariadb-server

COPY ./tools/* ./

ENTRYPOINT [ "/bin/bash" ]

CMD [ "mariadb.sh" ]
