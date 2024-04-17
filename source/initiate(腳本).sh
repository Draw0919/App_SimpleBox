#!/bin/bash

# Create a new user 'gm' and add to the root group
useradd -m gm -s /bin/bash
echo "gm:gm" | chpasswd
usermod -aG sudo gm

# Create a new regular user 'allen'
useradd -m allen -s /bin/bash
echo "allen:password" | chpasswd

# Create user.txt in Allen's home directory
echo "user's flag" > /home/allen/user.txt
chown allen:allen /home/allen/user.txt

# Enable SSH and set up
mkdir /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Subsystem sftp /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config

# Create root.txt in root's home directory
echo "root's flag" > /root/root.txt
chown root:root /root/root.txt

# Allow all users to execute the 'cp' command as root without a password
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers
