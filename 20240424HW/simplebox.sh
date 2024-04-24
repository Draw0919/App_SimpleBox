#!/bin/bash

# 使用說明  
# 1. 將此腳本複製到目標 Ubuntu 容器中。
# 2. 在終端機中打開腳本所在目錄。
# 3. 使用指令 `chmod +x setup_vulnerable.sh` 給予腳本執行權限。
# 4. 以 root 權限執行腳本：./setup_vulnerable.sh
# 5. 通過 SSH 連接到靶機進行管理和測試。

# 靶機管理設定
echo "" 
echo "靶機管理設定"
# 新增 admin 用戶，並將其添加到 root 群組
useradd -m admin
usermod -aG sudo admin
echo "admin:admin" | chpasswd

# 檢查 SSH 服務是否存在，如不存在則安裝
if ! command -v sshd > /dev/null; then
    apt-get update
    apt-get install -y openssh-server
fi
service ssh start

# 外部滲透設定
echo ""
echo "外部滲透設定"
# 新增 gary 用戶
useradd -m gary
echo "gary:password" | chpasswd

# 在 gary 的家目錄中創建 user.txt 文件，並添加一個字符串
echo "user's flag" > /home/gary/user.txt
chown gary:gary /home/gary/user.txt

# 內部提權設定
echo ""
echo "內部提權設定"
# 在 root 的家目錄中創建 root.txt 文件，並添加一個字符串
echo "root's flag" > /root/root.txt
chmod 600 /root/root.txt  # 只有 root 可以讀寫

# 檢查 sudo 是否存在，如果不存在則安裝
if ! command -v sudo > /dev/null; then
    apt-get update
    apt-get install -y sudo
fi

# 授權所有用戶可以用 root 權限執行 cp 命令
echo "ALL ALL=(root) NOPASSWD: /bin/cp" >> /etc/sudoers

# 創建10個加密的 root.txt，每個文件內容不同，只有一個匹配密碼的哈希值
for i in {1..10}; do
    echo "random data $RANDOM" > "/root/root_$i.txt"
    # 假設這裡使用一個簡單的方式來模擬加密
    md5sum "/root/root_$i.txt" | cut -d " " -f1 > "/root/root_$i.txt.enc"
done
# 確保一個文件是正確的
echo "root's flag" > "/root/root_5.txt"
md5sum "/root/root_5.txt" | cut -d " " -f1 > "/root/root_5.txt.enc"

# 完成設定
echo ""
echo "完成設定"
echo "靶機已設定完成，可以開始進行滲透測試。"
