# USER_DOC

## Services provided
- **NGINX (HTTPS 443)**: entrypoint, TLS termination, reverse proxy.
- **WordPress (PHP-FPM)**: website and admin panel.
- **MariaDB**: WordPress database.

## Start / Stop
From repository root:
- Start: `make`
- Stop: `make down`
- Restart: `make re`
- Logs: `make logs`
- Status: `make ps`

## Access the website
- Website: `https://rhamini.42.fr`
- Admin panel: `https://rhamini.42.fr/wp-admin`

## Credentials
- Credentials are defined in `srcs/.env`.
- This file must not be committed. Use `srcs/.env.example` as a template.

## Health checks
- Containers status: `make ps`
- NGINX responds: `curl -kI https://rhamini.42.fr`
- WordPress users (inside container):  
  `cd srcs && docker-compose exec wordpress wp user list --allow-root`
