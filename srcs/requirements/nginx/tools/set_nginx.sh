#!/bin/bash

envsubst '${TLS_PRIVATE_KEY_PATH} ${TLS_SRT_PATH}' \
< /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && \
rm /etc/nginx/nginx.conf.template

exec nginx -g "daemon off;"