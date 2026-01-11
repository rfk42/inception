FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

# Nginx config
COPY conf/nginx.conf /etc/nginx/sites-available/default

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
