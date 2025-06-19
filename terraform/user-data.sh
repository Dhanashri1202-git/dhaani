#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -e

# Update system packages
yum update -y

# Install Docker 
yum install -y docker

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Pull and run Strapi Docker container
docker pull 03922/strapi-app
docker run -d -p 1337:1337 03922/strapi-app
