# PHP项目Docker开发环境

## 搭建步骤
根据自己的电脑系统去[Docker官网](https://www.docker.com)下载并安装docker环境

## 环境配置文件更新

```bash
cp .env.example .env
```
在其中配置你的 coding 的账号和密码，此目的为了用 HTTP 协议拉取私有的 Composer 库。

### 启动容器
```bash
docker compose up -d
```

### 配置hosts(本地环境需配置)
```text
# 运营后台Api
127.0.0.1 dev.admin.api.com
# 渠道管理Api
127.0.0.1 dev.channel.api.com
# 渠道对接平台
127.0.0.1 dev.channel.platform.api.com
# SCRM系统Api
127.0.0.1 dev.scrm.api.com
# mapi系统
127.0.0.1 dev.mapi.api.com
```

### 安装Composer依赖
```bash
# 进入容器
docker exec -i php sh

# 进入项目根目录
cd /www/xxx

# 安装依赖
composer install --ignore-platform-reqs --no-dev
```

### env文件配置
将env文件复制一份命名为 `.env.dev`
```bash
cp .env.test .env.dev
```

### 日志路径修改
在 `.env.dev` 文件中，将日志输出目录指定为你的日志目录，例如：
```text
LOG_DIR=/www/douyu-env/logs/project/
```



## 常见问题

### 访问报500错误
- 因为配置的是虚拟域名，所以本地不能开VPN，除非你配置了规则代理绕过虚拟域名
- 是否安装了vendor依赖
- 是否创建了`storage`中的缓存目录

### win10无法启动
在使用WSL2 跑 Docker 时，容器可能会因为内存不足显示Exited (139)。  
这个是wsl2的锅，解决方案如下。  
在Windows 10 操作系统的系统盘- 用户 - <用户名>目录下，修改.wslconfig文件（如C:\Users\zhu.wslconfig)，若没有这个文件，则需要先创建。

在其中修改/添加如下内容：
```text
[wsl2]
kernelCommandLine = vsyscall=emulate
```
**电脑重启后生效**

### win10 提示：WSL 2 installation is incomplete
更新 WSL：https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

### SSH协议拉取私有库失败
某些私有库需要使用SSH协议拉取私有库，所以会遇到composer拉取失败的情况。
在PHP容器中，在Dockerfile中已经自动生成了SSH的密钥，所以你只需要将此公钥加入到 coding 中即可。

```bash
# 进入PHP容器
docker exec -it php sh
# 查看公钥
cat ~/.ssh/id_rsa.pub
```

### 项目启动错误
由于项目并没有创建某些目录，导致项目访问报错，所以你可以使用一下的 shell 命令，将其置于项目根目录创建必要的项目缓存目录。
```bash
mkdir -p storage/app storage/logs storage/framework/cache storage/framework/sessions storage/framework/views storage/framework/testing
```