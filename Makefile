.PHONY:build
build: ## Docker编译
	docker compose -f docker-compose.yml build

.PHONY:up
up: ## Docker容器启动
	docker compose -f docker-compose.yml up -d

.PHONY:down
down: ## Docker容器销毁
	docker compose -f docker-compose.yml down

#.PHONY:composer-install
#composer-install: ## Composer依赖安装
#	docker exec -i php sh -c "cd /www/api && composer install --no-dev"
#
#.PHONY:composer-update
#composer-update: ## Composer依赖更新
#	docker exec -i php sh -c "cd /www/api && composer update --no-dev"

.PHONY:help
.DEFAULT_GOAL:=help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'