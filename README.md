# MTProxy Docker 一键管理脚本

Telegram MTProxy 服务器 Docker 部署和管理工具。

## 一键安装

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ridaiqianhe/Mtproxy-Docker/main/mtproxy.sh)
```
 
## 功能

- 一键安装 MTProxy
- 自动生成安全密钥
- 交互式菜单管理(启动/停止/删除/查看日志)
- 自动生成连接链接

## 系统要求

- Docker
- Bash
- curl

## 菜单

```
1) 安装 MTProxy
2) 查看日志
3) 启动 MTProxy
4) 停止 MTProxy
5) 删除 MTProxy
0) 退出
```

## 常见问题

### 安装 Docker

```bash
curl -fsSL https://get.docker.com | sh
```

### 开放防火墙端口

```bash
# UFW
sudo ufw allow 443/tcp

# Firewalld
sudo firewall-cmd --permanent --add-port=443/tcp && sudo firewall-cmd --reload
```

### 查看状态

```bash
docker ps -a | grep mtproxy
docker logs mtproxy
```

## 许可证

MIT License
