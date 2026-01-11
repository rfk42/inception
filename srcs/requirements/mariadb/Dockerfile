FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# IMPORTANT : évite que /var/lib/mysql soit pré-rempli dans l'image
RUN rm -rf /var/lib/mysql/* \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3306

CMD ["/init.sh"]
