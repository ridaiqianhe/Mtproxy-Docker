# MTProxy Docker 一键管理脚本

简单易用的 Telegram MTProxy 服务器 Docker 部署和管理工具。

## 功能特性

- 一键安装 MTProxy 服务器
- 自动生成安全密钥
- 交互式菜单管理
- 支持启动、停止、删除操作
- 查看实时日志
- 自动生成 Telegram 连接链接

## 系统要求

- Linux 操作系统
- Docker 已安装并运行
- Bash Shell
- curl (用于获取服务器 IP)

## 快速开始

### 1. 下载脚本

```bash
wget https://raw.githubusercontent.com/ri dai qian he/Mtproxy-Docker/main/mtproxy.sh
# 或使用 curl
curl -O https://raw.githubusercontent.com/ridaiqianhe/Mtproxy-Docker/main/mtproxy.sh
```

### 2. 添加执行权限

```bash
chmod +x mtproxy.sh
```

### 3. 运行脚本

```bash
./mtproxy.sh
```

## 使用说明

运行脚本后会显示交互式菜单:

```
==============================
 MTProxy 一键管理工具
==============================
1) 安装 MTProxy
2) 查看日志
3) 启动 MTProxy
4) 停止 MTProxy
5) 删除 MTProxy
0) 退出
==============================
```

### 菜单选项说明

#### 1. 安装 MTProxy

- 提示输入端口号(默认 443)
- 自动生成安全密钥
- 启动 Docker 容器
- 显示服务器信息和连接链接

#### 2. 查看日志

- 显示 MTProxy 容器的运行日志
- 用于排查问题和监控状态

#### 3. 启动 MTProxy

- 启动已停止的 MTProxy 服务

#### 4. 停止 MTProxy

- 停止正在运行的 MTProxy 服务

#### 5. 删除 MTProxy

- 完全删除 MTProxy 容器
- 需要重新安装才能使用

## 安装示例

```bash
$ ./mtproxy.sh

# 选择选项 1
请输入端口 (默认443): 8443

安装中...

===== MTProxy 安装完成 =====
服务器: 123.456.789.0
端口:   8443
密钥:   a1b2c3d4e5f6789012345678

Telegram 链接:
tg://proxy?server=123.456.789.0&port=8443&secret=a1b2c3d4e5f6789012345678

HTTPS 链接:
https://t.me/proxy?server=123.456.789.0&port=8443&secret=a1b2c3d4e5f6789012345678
```

## 连接到代理

安装完成后,您可以使用以下两种方式连接:

### 方式 1: 直接点击链接(推荐)

在 Telegram 应用中直接打开生成的 HTTPS 链接:
```
https://t.me/proxy?server=YOUR_IP&port=YOUR_PORT&secret=YOUR_SECRET
```

### 方式 2: 手动配置

1. 打开 Telegram 应用
2. 进入 Settings → Data and Storage → Proxy Settings
3. 添加代理:
   - Server: 您的服务器 IP
   - Port: 您设置的端口
   - Secret: 生成的密钥

## 常见问题

### Docker 未安装

如果系统提示找不到 Docker,请先安装:

```bash
# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# CentOS
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
```

### 端口被占用

如果端口 443 被占用,安装时选择其他端口,如 8443、1080 等。

### 防火墙设置

确保所选端口在防火墙中已开放:

```bash
# UFW
sudo ufw allow 443/tcp

# Firewalld
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

# iptables
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
```

### 查看容器状态

```bash
docker ps -a | grep mtproxy
```

### 重新获取连接信息

```bash
docker logs mtproxy
```

## 手动操作(高级)

如果需要手动操作 Docker 容器:

```bash
# 查看容器
docker ps -a

# 查看日志
docker logs mtproxy

# 停止容器
docker stop mtproxy

# 启动容器
docker start mtproxy

# 删除容器
docker rm -f mtproxy

# 生成新密钥
head -c 16 /dev/urandom | xxd -ps
```

## 安全建议

1. 使用非标准端口(如 8443)而不是 443,降低被扫描风险
2. 定期更换密钥
3. 仅分享给信任的用户
4. 定期查看日志,监控异常流量
5. 保持 Docker 镜像更新

## 更新 MTProxy

```bash
# 停止并删除旧容器
./mtproxy.sh
# 选择选项 5 删除

# 拉取最新镜像
docker pull telegrammessenger/proxy:latest

# 重新安装
./mtproxy.sh
# 选择选项 1 安装
```

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request!

## 相关链接

- [Telegram MTProxy 官方文档](https://github.com/TelegramMessenger/MTProxy)
- [Docker 官方镜像](https://hub.docker.com/r/telegrammessenger/proxy)
- [Telegram 官方网站](https://telegram.org/)

## 免责声明

本工具仅供学习和合法使用。使用者需遵守当地法律法规,作者不对任何滥用行为负责。
