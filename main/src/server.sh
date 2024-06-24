#!/bin/bash
sudo apt-get update

# sudo apt upgrade -y

# Install MySQL-client
sudo apt-get install mysql-client -y

# Install Redis
sudo apt-get install redis -y

# Install Pipx
sudo apt-get install pipx -y
pipx ensurepath
sudo pipx ensurepath --global