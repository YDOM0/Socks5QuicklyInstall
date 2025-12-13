#!/bin/bash

# 自动化安装并配置 Dante SOCKS5 代理服务器
# 作者：Qwen
# 日期：2025-12-13

set -e  # 遇到错误立即退出

echo "[+] 正在更新系统软件包列表..."
sudo apt update

echo "[+] 正在安装 dante-server..."
sudo apt install -y dante-server

echo "[+] 正在进入 /etc 目录..."
cd /etc

echo "[+] 正在删除旧的 danted.conf 配置文件（如果存在）..."
sudo rm -f danted.conf

echo "[+] 正在从 GitHub 下载新的 danted.conf 配置文件..."
sudo curl -fsSL -o danted.conf https://raw.githubusercontent.com/YDOM0/Socks5QuicklyInstall/main/danted.conf

if [ ! -f danted.conf ]; then
    echo "[-] 错误：未能成功下载 danted.conf 文件！"
    exit 1
fi
echo "开放端口中...."
sudo ufw allow 1080
echo "cr.."
sudo useradd -m -s /bin/bash mnb2 && echo "mnb2:mnb2" | sudo chpasswd

echo "[+] 正在重启 danted 服务..."
sudo systemctl restart danted.service

echo "[+] 正在检查 danted 服务状态..."
systemctl status danted.service --no-pager

echo "[+] 配置完成！SOCKS5 代理服务已启动。"
