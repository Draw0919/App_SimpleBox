# Docker Setup with Flask and XSS Vulnerability

## Dockerfile
```dockerfile
# Use an official lightweight Python image based on Debian (small size of Linux)
FROM python:3.9-slim

# Maintainer Label
LABEL maintainer="yourname@example.com"

# User Guide:
# To build this image: docker build -t flask-xss-demo .
# To run this container: docker run -d -p 5000:5000 flask-xss-demo

# OS setting: using a small size base image (python:3.9-slim)

# Install necessary packages
RUN apt-get update && \
    apt-get install -y sudo openssh-server && \
    pip install Flask

# Setup users and SSH
RUN useradd -m gm -s /bin/bash && \
    echo "gm:gm" | chpasswd && \
    usermod -aG root gm && \
    useradd -m allen -s /bin/bash && \
    echo "allen:password" | chpasswd && \
    echo "user's flag" > /home/allen/user.txt && \
    chown allen:allen /home/allen/user.txt && \
    echo "root's flag" > /root/root.txt && \
    chown root:root /root/root.txt && \
    echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers

# Enable SSH
RUN mkdir /var/run/sshd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    service ssh restart

# Copy the Flask app to the container
COPY app /app
WORKDIR /app

# Expose port 5000 for the Flask app
EXPOSE 5000

# Environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Start Flask app
CMD ["flask", "run"]
