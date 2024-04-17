#!/bin/bash

# Update system and install necessary packages
apt-get update
apt-get install -y sudo openssh-server python3-pip

# Install Flask
pip3 install Flask

# Add new user 'gm' with password "gm" and add to the root group
useradd -m gm -s /bin/bash
echo "gm:gm" | chpasswd
usermod -aG sudo gm

# Add new user 'allen', who is a regular user, with password "password"
useradd -m allen -s /bin/bash
echo "allen:password" | chpasswd

# Create a new file in Allen's home directory and add a string "user's flag"
echo "user's flag" > /home/allen/user.txt
chown allen:allen /home/allen/user.txt

# Set Allen's SSH login
mkdir /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Subsystem sftp /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config

# Restart SSH service
service ssh restart

# In root's home directory create a new file, named root.txt and add a string "root's flag"
echo "root's flag" > /root/root.txt

# Authorize all users the sudo privilege to execute 'cp' command with root privileges
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers

# Setup Flask application directory
mkdir -p /app
cd /app

# Create a simple Flask application with an XSS vulnerability
cat <<EOF > app.py
from flask import Flask, request, render_template_string

app = Flask(__name__)

@app.route('/')
def index():
    user_input = request.args.get('data', '')
    return render_template_string('<h1>Your input was: {{ user_input }}</h1>', user_input=user_input)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
EOF

# Expose the necessary port
EXPOSE 5000

# Start the Flask application
flask run --host=0.0.0.0
