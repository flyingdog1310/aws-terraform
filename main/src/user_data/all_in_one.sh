#!/bin/bash
sudo apt-get update

# sudo apt upgrade -y

# Install MySQL
sudo apt-get install mysql-server -y
sudo systemctl start mysql.service

# Install Redis
sudo apt-get install redis -y

# Install Nginx
sudo apt-get install nginx -y 

# Install Pipx
sudo apt-get install pipx -y
pipx ensurepath
sudo pipx ensurepath --global
