# PHP项目Docker开发环境

## 搭建步骤
根据自己的电脑系统去[Docker官网](https://www.docker.com)下载并安装docker环境

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
```

### 配置composer权限
因为composer中某些库依赖于私有库，因此你需要进行如下配置，即可使用composer拉取私有库的依赖。
```bash
# 添加配置
composer config -g http-basic.e.coding.net username password
# 删除配置
composer config -g --unset http-basic.e.coding.net
# 查看配置
composer config -g -l
```

### 安装Composer依赖
```bash
# 进入容器
docker exec -i php sh

# 进入项目根目录
cd /www/xxx

# 安装依赖
composer install --no-dev
```

### env文件配置
将env文件复制一份命名为 `.env.dev`
```bash
cp .env.test .env.dev
```

### 日志路径修改
在 `.env.dev` 文件中，将日志输出目录指定为你的日志目录，例如：
```text
/www/douyu-env/logs/project/
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


### 项目启动错误
由于项目并没有创建某些目录，导致项目访问报错，所以你可以使用一下的 shell 命令，将其置于项目根目录创建必要的项目缓存目录。
```bash
mkdir -p storage/app storage/logs storage/framework/cache storage/framework/sessions storage/framework/views storage/framework/testing
```