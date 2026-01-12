NAME        := inception

DC          := docker-compose

COMPOSE_DIR := srcs

LOGIN        =rhamini
DATA_DIR    := /home/$(LOGIN)/data
WP_DATA     := $(DATA_DIR)/wordpress
DB_DATA     := $(DATA_DIR)/mariadb

define run_compose
	cd $(COMPOSE_DIR) && $(DC) $(1)
endef

.PHONY: all up down build start stop restart re clean fclean ps logs \
		images config dirs

all: up

dirs:
	@mkdir -p $(WP_DATA) $(DB_DATA)
	@echo "✅ Data dirs ready: $(WP_DATA) | $(DB_DATA)"

up: dirs
	@echo "🚀 Starting $(NAME)..."
	@$(call run_compose,up -d --build)
	@$(call run_compose,ps)

down:
	@echo "🛑 Stopping $(NAME)..."
	@$(call run_compose,down)

start:
	@echo "▶️  Starting containers..."
	@$(call run_compose,start)

stop:
	@echo "⏸️  Stopping containers..."
	@$(call run_compose,stop)

restart:
	@echo "🔄 Restarting containers..."
	@$(call run_compose,restart)

build:
	@echo "🧱 Building images..."
	@$(call run_compose,build)

re: down up

clean: down
	@echo "🧹 Clean done (volumes kept)."

fclean:
	@echo "🔥 Full clean: removing containers, images and volumes..."
	@$(call run_compose,down -v --rmi all --remove-orphans)
	@echo "✅ fclean done."

ps:
	@$(call run_compose,ps)

logs:
	@$(call run_compose,logs -f)

images:
	@$(call run_compose,images)

config:
	@$(call run_compose,config)
