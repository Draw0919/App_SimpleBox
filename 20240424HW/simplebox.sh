#!/bin/bash

# 使用說明
# 1. 將此腳本複製到您的Ubuntu容器中。
# 2. 開啟終端機。
# 3. 使用cd命令導航到腳本所在的目錄。
# 4. 給予腳本執行權限：chmod +x setup_script.sh
# 5. 執行腳本：./setup_script.sh

# 靶機管理設定
echo ""
echo "靶機管理設定"
useradd -m admin
usermod -aG root admin
echo "admin:admin" | chpasswd
if ! service ssh status > /dev/null 2>&1; then
    apt-get update
    apt-get install -y ssh
fi
service ssh start

# 外部滲透設定
echo ""
echo "外部滲透設定"
useradd -m gary
echo "gary:password" | chpasswd
echo "user's flag" > /home/gary/user.txt

# 內部提權設定
echo ""
echo "內部提權設定"
echo "root's flag" > /root/root.txt
if ! command -v sudo > /dev/null 2>&1; then
    apt-get update
    apt-get install -y sudo
fi
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers

# 創建加密文件
echo ""
echo "創建加密文件"
for i in {1..50}; do
    file="/home/user/secret_file_$i.txt"
    echo "Data for file $i" | md5sum | cut -d' ' -f1 > "$file"
    chmod 600 "$file"
done
# 將root.txt文件的hash與一個文件的hash匹配
hash_of_root=$(md5sum /root/root.txt | cut -d' ' -f1)
echo $hash_of_root > "/home/user/secret_file_with_root_hash.txt"

# 完成設定
echo ""
echo "完成設定"
echo "腳本執行完成，靶機已設定好基本漏洞。"
