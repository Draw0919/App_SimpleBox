# 目的 

## 未來運用構想：
  I want to set a simple vulnerable ubuntu box for cyber security class.

## 擬請ChatGPT提供：
  please provide a bash script that can set the vulnerabilities in a given Ubuntu.

# 需求項目

## 提供操作說明：
  - how to run this bash script step by step.
  - box admin can management this box via ssh

## 設定基本功能：
  - add a new user "admin" .   And add owner to root group.
  - change admin's password to plaintext "admin". Ex. echo "admin:admin" | chpasswd.
  - check whether ssh service exists. if ssh not exist, install it.
    
## 設定外部滲透弱點：
  - add a new user, gary, who is a regular user.
  - change gary's password to plaintext "password". Ex. echo "gary:password" | chpasswd
  - In gary's home directory create a new file, named user.txt. And add a string "user's flag" to the file.
  - set allen's password as plaintext "password" exactly, not use crypted string. 

## 設定內部擴散弱點：
  * In root's home directory create a new file, named root.txt. And add a string "root's flag" to the file.
  * check whether sudo function exists. if sudo not exist, install it.
  * authorize all users the privilege that can execute cp command with root privileged.
  *root.txt is locked by the password's hash value
  *create 10 root.txt，every files' content is different and every file will be encrypted by random hash，only one's content is root's flag and it's hash will matched with the password hash 
# ChatGPT回復格式

## 注意事項：
  * segment  code exactly according what I mention in  [# 需求項目]
  * echo empty line between segments.
  * This script will be run in Ubuntu container by root, don't use sudo.
  * This script will be run in Ubuntu container with only core functions, use core commands only.
  * do the work step by step.make it easy to understand for students.
  * use limited echo lines with traditional Chinese I show you in following reference.
 
## 回復範例：
  #!/bin/bash

  # 使用說明  
  # 1. Copy this script to...
  # 2. Open terminal...
  # 3. Navigate to ...
  # 4. chmod +x ...
  # 5. Run the command...

  # 靶機管理設定
  echo "" 
  echo "靶機管理設定"
  useradd -m...
  usermod -aG ...
  echo... | chpasswd
  service ssh ...

  # 外部滲透設定
  echo ""
  echo "外部滲透設定"
  useradd ...
  service ssh ...
  
  
  # 內部提權設定
  echo ""
  echo "內部提權設定"
  if ...sudo...  

  # 完成設定
  echo ""
  echo "完成設定"