#!/bin/bash

set -eu

envsubst '${DOMAIN_NAME}' </etc/nginx/conf.d/www.conf.template >/etc/nginx/conf.d/www.conf

if [ ! -f "/etc/ssl/certs/inception.${DOMAIN_NAME}.key" ]; then
  openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
	-subj "/C=KR/ST=SEOUL/L=Gaepo-dong/O=42Seoul/OU=yjung/CN=${DOMAIN_NAME}" \
	-keyout /etc/ssl/private/inception.${DOMAIN_NAME}.key \
	-out /etc/ssl/certs/inception.${DOMAIN_NAME}.crt; \
	chmod 640 /etc/ssl/private/inception.${DOMAIN_NAME}.key \
	 /etc/ssl/certs/inception.${DOMAIN_NAME}.crt;
fi

exec "$@"
