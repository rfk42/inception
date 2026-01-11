#!/bin/bash
set -e

echo "Waiting for MariaDB..."
until mysqladmin ping -h"$MYSQL_HOST" --silent; do
  sleep 1
done

cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
  echo "Initializing WordPress..."

  wp core download --allow-root

  wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="$MYSQL_HOST" \
    --allow-root

  wp core install \
    --url="https://rhamini.42.fr" \
    --title="Inception" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email \
    --allow-root

  wp user create \
    "$WP_USER" "$WP_USER_EMAIL" \
    --role=author \
    --user_pass="$WP_USER_PASSWORD" \
    --allow-root

  chown -R www-data:www-data /var/www/wordpress
fi

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F
