#!/bin/bash

# MTProxy Docker 一键管理脚本（菜单版）

set -e

# 生成随机密钥函数（兼容无 xxd 系统）
generate_secret() {
  if command -v xxd &> /dev/null; then
    head -c 16 /dev/urandom | xxd -ps
  elif command -v hexdump &> /dev/null; then
    head -c 16 /dev/urandom | hexdump -ve '1/1 "%.2x"'
  else
    head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n'
  fi
}

install_mtproxy() {
  echo "=============================="
  echo " MTProxy 安装"
  echo "=============================="
  read -p "请输入端口 (默认443): " PORT
  PORT=${PORT:-443}

  read -p "请输入密钥 (留空自动生成): " SECRET
  if [ -z "$SECRET" ]; then
    SECRET=$(generate_secret)
    echo "已生成密钥: $SECRET"
  fi
 
  echo "安装中..."
  docker run -d \
    --name mtproxy \
    --restart always \
    -p $PORT:443 \
    -e SECRET=$SECRET \
    telegrammessenger/proxy:latest

  SERVER_IP=$(curl -4 -s ifconfig.me || curl -4 -s ip.sb || curl -4 -s icanhazip.com)

  echo ""
  echo "===== MTProxy 安装完成 ====="
  echo "服务器: $SERVER_IP"
  echo "端口:   $PORT"
  echo "密钥:   $SECRET"
  echo ""
  echo "Telegram 链接："
  echo "tg://proxy?server=$SERVER_IP&port=$PORT&secret=$SECRET"
  echo ""
  echo "HTTPS 链接："
  echo "https://t.me/proxy?server=$SERVER_IP&port=$PORT&secret=$SECRET"
  echo ""
}

show_logs() {
  echo "=============================="
  echo " MTProxy 日志"
  echo "=============================="
  docker logs mtproxy
}

start_mtproxy() {
  docker start mtproxy
  echo "MTProxy 已启动"
}

stop_mtproxy() {
  docker stop mtproxy
  echo "MTProxy 已停止"
}

remove_mtproxy() {
  docker rm -f mtproxy
  echo "MTProxy 已删除"
}

while true; do
  echo "=============================="
  echo " MTProxy 一键管理工具"
  echo "=============================="
  echo "1) 安装 MTProxy"
  echo "2) 查看日志"
  echo "3) 启动 MTProxy"
  echo "4) 停止 MTProxy"
  echo "5) 删除 MTProxy"
  echo "0) 退出"
  echo "=============================="
  read -p "请输入选项: " choice

  case $choice in
    1) install_mtproxy ;;
    2) show_logs ;;
    3) start_mtproxy ;;
    4) stop_mtproxy ;;
    5) remove_mtproxy ;;
    0) exit 0 ;;
    *) echo "无效选项,请重新输入。" ;;
  esac

  echo ""
  read -p "按回车键继续..."
  clear
done
