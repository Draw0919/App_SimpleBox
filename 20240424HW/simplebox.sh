#!/bin/bash

# 使用說明
# 1. 將此腳本保存為 setup_vulnerabilities.sh
# 2. 打開終端機
# 3. 使用 cd 命令切換到腳本所在目錄
# 4. 執行 chmod +x setup_vulnerabilities.sh 賦予執行權限
# 5. 使用 ./setup_vulnerabilities.sh 執行此腳本

# 靶機管理設定
echo ""
echo "靶機管理設定"
# 添加管理用戶 admin 並賦予 root 群組權限
useradd -m admin -G root
# 設置 admin 用戶密碼
echo "admin:admin" | chpasswd
# 檢查並安裝 SSH 服務
if ! command -v ssh > /dev/null; then
    apt-get update && apt-get install -y openssh-server
fi
service ssh start

# 外部滲透設定
echo ""
echo "外部滲透設定"
# 添加普通用戶 gary
useradd -m gary
# 設置 gary 用戶密碼
echo "gary:password" | chpasswd
# 在 gary 的家目錄中創建 user.txt 並添加內容
echo "user's flag" > /home/gary/user.txt

# 內部擴散弱點設定
echo ""
echo "內部擴散弱點設定"
# 在 root 的家目錄中創建 root.txt 並添加內容
echo "root's flag" > /root/root.txt
# 檢查並安裝 sudo 功能
if ! command -v sudo > /dev/null; then
    apt-get update && apt-get install -y sudo
fi
# 授權所有用戶以 root 權限執行 cp 命令
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers

# 完成設定
echo ""
echo "完成設定"
echo "系統漏洞已成功設置，靶機現在準備好進行測試。"
