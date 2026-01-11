*This project has been created as part of the 42 curriculum by rhamini.*

# Inception

## What is it?
A small web infrastructure running in a **VM** with **Docker Compose**:
- **NGINX** (only public service) on **HTTPS :443** with **TLSv1.2/TLSv1.3 only**
- **WordPress (PHP-FPM)**
- **MariaDB**

Data persists with **2 named volumes** stored in `/home/rhamini/data`. 

## Run
- `make`

Useful:
- `make down`
- `make logs`

## Open
- `https://rhamini.42.fr`
- `https://rhamini.42.fr/wp-admin` 

## Required comparisons
- **VM vs Docker**: VM = full OS; Docker = lightweight containers sharing the host kernel. 
- **Secrets vs env**: env = config; secrets = passwords (no passwords in Dockerfiles/Git). 
- **Docker network vs host**: we use a dedicated Docker network; host networking/links are forbidden. 
- **Volumes vs bind mounts**: persistence uses named volumes (bind mounts not allowed for mandatory volumes). 

## AI usage
AI was used for documentation drafts, checklists from the subject, training exercices on dockerfile, and troubleshooting. 

