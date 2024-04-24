#!/bin/bash

# 使用說明
# 1. 請將此腳本複製到您的 Ubuntu 系統中。
# 2. 在終端機中，使用 cd 命令導航到腳本所在的目錄。
# 3. 使用 chmod +x filename.sh 命令賦予腳本執行權限（其中 filename.sh 是您複製的腳本文件的名稱）。
# 4. 執行腳本，可以使用 ./filename.sh 命令（同樣，filename.sh 是您的腳本文件的名稱）。

# 靶機管理設定
echo ""
echo "靶機管理設定"
# 新增使用者 "admin"，並將其添加到 sudo 群組，以便具有管理權限
useradd -m admin
usermod -aG sudo admin
# 更改 admin 的密碼為明文 "admin"
echo "admin:admin" | chpasswd
# 檢查是否已安裝 SSH 服務，如果未安裝，則進行安裝
if [ ! -x /usr/sbin/sshd ]; then
    apt-get update
    apt-get install -y openssh-server
fi
service ssh restart

# 外部滲透設定
echo ""
echo "外部滲透設定"
# 新增一個名為 "gary" 的一般用戶，並設置其密碼為 "password"
useradd gary
echo "gary:password" | chpasswd
# 在 gary 的家目錄中創建一個名為 user.txt 的文件，並將字符串 "user's flag" 添加到文件中
echo "user's flag" > /home/gary/user.txt

# 內部提權設定
echo ""
echo "內部提權設定"
# 檢查是否已安裝 sudo，如果未安裝，則進行安裝
if ! dpkg -l | grep -q sudo; then
    apt-get update
    apt-get install -y sudo
fi
# 授權所有使用者可以以 root 權限執行 cp 命令
echo "ALL ALL=(root) NOPASSWD: /bin/cp" >> /etc/sudoers
# 在 root 的家目錄中創建一個名為 root.txt 的文件，並將字符串 "root's flag" 添加到文件中
echo "root's flag" > /root/root.txt

# 創建 10 個不同的 .txt 檔案，每個文件的內容都不同，並使用隨機哈希加密
for i in {1..10}; do
    # 生成隨機的檔名
    filename="file$i.txt"
    # 生成隨機的內容
    content=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10)
    # 使用隨機哈希加密內容
    hashed_content=$(echo "$content" | sha256sum | awk '{print $1}')
    # 將加密後的內容寫入文件
    echo "$hashed_content" > "/root/$filename"
done

# 隨機選擇一個檔案，將其內容設置為 root 的標誌並與密碼哈希值匹配
# 取得 root 的密碼哈希值
root_password_hash=$(grep '^root:' /etc/shadow | cut -d':' -f2)
# 隨機選擇一個檔案
random_file=$(ls /root/*.txt | shuf -n 1)
# 將 root 的標誌寫入所選檔案
echo "root's flag" > "$random_file"
# 將檔案的名稱和密碼哈希值存入一個文件，以便管理者查看
echo "File: $random_file, Password Hash: $root_password_hash" > /root/password_hash_mapping.txt

# 完成設定
echo ""
echo "完成設定"
