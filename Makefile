# A Self-Documenting Makefile: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

.PHONY:build
build: ## Docker编译
	docker compose build --no-cache
	@echo "docker container build success"

.PHONY:up
up: ## Docker容器启动
	docker compose up -d
	@echo "docker container up success"

.PHONY:down
down: ## Docker容器销毁
	docker compose down
	@echo "docker container down success"

.PHONY:composer-install
composer-install: ## Composer依赖安装
	docker exec -i php sh -c "cd /www/api && composer install --no-dev"
	@echo "composer install success"

.PHONY:composer-update
composer-update: ## Composer依赖更新
	docker exec -i php sh -c "cd /www/api && composer update --no-dev"
	@echo "composer update success"

.PHONY:help
.DEFAULT_GOAL:=help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'