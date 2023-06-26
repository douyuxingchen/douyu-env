# PHP项目Docker开发环境

## 搭建步骤

1. 根据自己的电脑系统去[Docker官网](https://www.docker.com)下载并安装docker环境

2. 启动容器
```bash
docker compose up -d
```

3. 安装composer依赖
```bash
# {dir} 请更换为具体的项目目录
docker exec -i php sh -c "cd /www/{dir} && composer install --no-dev"
```

4. 配置hosts
```text
# 运营后台Api
127.0.0.1 dev.admin.api.dyxc.com
# 渠道管理Api
127.0.0.1 dev.channel.api.dyxc.com
```
