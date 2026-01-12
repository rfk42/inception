# DEV_DOC

## Prerequisites
- Docker + docker-compose
- Make
- A valid local DNS mapping for `https://rhamini.42.fr` if required by your setup
- Host directories for persistence: `/home/rhamini/data/wordpress` and `/home/rhamini/data/mariadb`

## Configuration
- Create `srcs/.env` from `srcs/.env.example` and set required variables.
- Project data persists via Docker volumes mapped to `/home/rhamini/data/...`.

## Build & launch
From repository root:
- Build + run: `make`
- Rebuild: `make fclean && make`
- Stop: `make down`

## Useful management commands
From repository root:
- Status: `make ps`
- Logs: `make logs`
From `srcs/`:
- Inspect volumes: `docker volume ls` and `docker volume inspect <name>`
- Exec shell: `docker-compose exec <service> sh`
- docker system prune -a --volumes
- docker volume rm srcs_mariadb srcs_wordpress
- docker-compose ps
- docker rmi mariadb:rhamini wordpress:rhamini nginx:rhamini
- curl -I http://rhamini.42.fr || echo "HTTP blocked ✅"
- docker-compose config | sed -n '1,200p'
- grep -R --line-number --fixed-strings "--link" .
- docker volume ls
- docker-compose exec mariadb mysql -uroot -p
- docker volume inspect wordpress | grep -E "/home/rhamini/data|device"
- docker volume inspect mariadb   | grep -E "/home/rhamini/data|device"
- docker-compose exec wordpress sh -lc 'wp user list --allow-root'
- docker-compose exec mariadb sh -lc 'env -u MYSQL_HOST mysql --protocol=socket -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;"'
- docker-compose exec mariadb sh -lc 'env -u MYSQL_HOST mysql --protocol=socket -uroot -p"$MYSQL_ROOT_PASSWORD" -e "USE wordpress; SHOW TABLES;"'


## Data persistence
- WordPress files: `/home/rhamini/data/wordpress`
- MariaDB data: `/home/<rhamini/data/mariadb`
- Data remains after `make down` and survives reboot; only `make fclean` removes volumes.
