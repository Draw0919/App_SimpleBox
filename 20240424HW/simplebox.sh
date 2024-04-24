#!/bin/bash

# 使用說明
# 1. 將此腳本複製到 Ubuntu 容器中。
# 2. 打開終端。
# 3. 使用 cd 命令導航至腳本所在目錄。
# 4. 執行命令 chmod +x setup_vulnerabilities.sh 來賦予執行權限。
# 5. 執行命令 ./setup_vulnerabilities.sh 來運行腳本。

# 靶機管理設定
echo ""
echo "靶機管理設定"
# 新增 admin 用戶，並添加到 root 群組
useradd -m -s /bin/bash admin
usermod -aG root admin
# 設定 admin 的密碼為明文 "admin"
echo "admin:admin" | chpasswd
# 檢查並安裝 SSH 服務
if ! dpkg -s openssh-server >/dev/null 2>&1; then
  apt-get update
  apt-get install -y openssh-server
fi
service ssh start

# 外部滲透設定
echo ""
echo "外部滲透設定"
# 新增 gary 用戶
useradd -m -s /bin/bash gary
# 設定 gary 的密碼為明文 "password"
echo "gary:password" | chpasswd
# 在 gary 的家目錄中創建 user.txt 並添加字串 "user's flag"
echo "user's flag" > /home/gary/user.txt
chown gary:gary /home/gary/user.txt

# 內部提權設定
echo ""
echo "內部提權設定"
# 在 root 的家目錄中創建 root.txt 並添加字串 "root's flag"
echo "root's flag" > /root/root.txt
# 檢查並安裝 sudo
if ! dpkg -s sudo >/dev/null 2>&1; then
  apt-get update
  apt-get install -y sudo
fi
# 授權所有用戶以 root 權限執行 cp 命令
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers

# 完成設定
echo ""
echo "完成設定"
echo "脚本执行完成，靶机配置已就绪，可以进行渗透测试学习。"

# 输出用户名和密码列表至 passwd.txt
{
  echo "admin:admin"
  echo "gary:password"
} > passwd.txt
