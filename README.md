*This project has been created as part of the 42 curriculum by rhamini.*

# Inception

## Description
**Inception** is a small web infrastructure running inside a **virtual machine** and orchestrated with **Docker Compose**.  
Goal: deploy a minimal production-like stack with proper isolation, networking, TLS, and persistent data.

### Services provided
- **NGINX**: the **only public entrypoint**, serving the site on **HTTPS (443)** with **TLSv1.2/TLSv1.3 only** and reverse-proxying PHP requests to WordPress.
- **WordPress (PHP-FPM)**: the web application running with **php-fpm** (no nginx inside).
- **MariaDB**: the database used by WordPress.

### Sources included in this project
- `srcs/docker-compose.yml`: service orchestration (containers, network, volumes).
- `srcs/requirements/nginx/`: Dockerfile, nginx configuration, TLS generation/script.
- `srcs/requirements/wordpress/`: Dockerfile, php-fpm configuration, wp-cli init script.
- `srcs/requirements/mariadb/`: Dockerfile, MariaDB configuration, init script.
- Host persistent data directory: `/home/rhamini/data/{wordpress,mariadb}`.

### Main design choices
- **Single public entrypoint**: only NGINX exposes a port (443). WordPress/MariaDB are internal services.
- **Dedicated Docker network**: services communicate using internal DNS names (e.g. `mariadb`, `wordpress`).
- **Persistent storage**: WordPress files and MariaDB data persist through named volumes stored in `/home/rhamini/data`.

### Required comparisons
- **Virtual Machines vs Docker**  
  A VM runs a full OS (heavier, slower to start). Docker runs isolated containers sharing the host kernel (lighter, faster, reproducible builds).
- **Secrets vs Environment Variables**  
  Environment variables are convenient for configuration; secrets are preferred for sensitive values. This project uses a local `.env` file for configuration, and credentials are not committed to Git.
- **Docker Network vs Host Network**  
  Docker networks provide isolation and service discovery (DNS). Host networking removes isolation and is not used here.
- **Docker Volumes vs Bind Mounts**  
  Volumes are managed by Docker and used for persistence; bind mounts map an explicit host path. Mandatory persistence is implemented using **named volumes stored in `/home/rhamini/data`** to meet project constraints.

---

## Instructions

### Prerequisites
- Docker and docker-compose
- Make
- The domain `rhamini.42.fr` must resolve to the VM (commonly via `/etc/hosts`).

### Run
From the repository root:
- Start/build: `make`
- Stop: `make down`
- Rebuild: `make re`
- Logs: `make logs`
- Status: `make ps`
- Full cleanup (removes volumes/images): `make fclean`

### Access
- Website: `https://rhamini.42.fr`
- Admin panel: `https://rhamini.42.fr/wp-admin`

### Quick checks
- HTTPS reachable: `curl -kI https://rhamini.42.fr`
- HTTP blocked: `curl -I http://rhamini.42.fr` (should fail)
- WordPress users: `cd srcs && docker-compose exec wordpress wp user list --allow-root`
- Database not empty: `cd srcs && docker-compose exec mariadb mysql -uroot -p -e "SHOW DATABASES;"`

---

## Resources
Classic references:
- Docker documentation: https://docs.docker.com/
- Docker Compose documentation: https://docs.docker.com/compose/
- NGINX documentation: https://nginx.org/en/docs/
- WordPress documentation: https://wordpress.org/documentation/
- WP-CLI documentation: https://wp-cli.org/
- MariaDB documentation: https://mariadb.com/kb/en/documentation/

### AI usage
AI was used for:
- Training exercices.
- Building evaluation checklists from the subject requirements.
- Troubleshooting container startup issues (MariaDB init logic, WordPress DB connectivity, volume persistence).

