#!/bin/bash

mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/nginx.crt ] || [ ! -f /etc/nginx/ssl/nginx.key ]; then
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=rhamini.42.fr" \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt
fi

exec nginx -g "daemon off;"