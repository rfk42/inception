#!/bin/bash
set -e


SOCKET="/run/mysqld/mysqld.sock"
FLAG="/var/lib/mysql/.inception_initialized"

if [ ! -f "$FLAG" ]; then
  # Initialise les tables système si besoin
  if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
  fi

  mysqld_safe --skip-networking --user=mysql &

  until mysqladmin --protocol=socket --socket="$SOCKET" ping --silent; do
    sleep 1
  done

  mysql --protocol=socket --socket="$SOCKET" -uroot <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

  touch "$FLAG"
  mysqladmin --protocol=socket --socket="$SOCKET" -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

exec mysqld --user=mysql --bind-address=0.0.0.0

