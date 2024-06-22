#!/bin/bash
sudo apt update

# sudo apt upgrade -y

# Install MySQL
sudo apt-get install mysql-server -y
sudo systemctl start mysql.service

# Install Redis
sudo apt-get install redis -y
