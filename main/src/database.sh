#!/bin/bash
sudo apt update

# sudo apt upgrade -y

# Install MySQL
sudo apt-get install mysql-server -y
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service
sudo mysql -Bse \
    "CREATE USER 'mysql'@'%' IDENTIFIED BY 'mysql'; GRANT ALL PRIVILEGES ON *.* To 'mysql'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# Install Redis
sudo apt-get install redis -y
sudo sed -i '/^bind 127.0.0.1 ::1/s/^/#/' /etc/redis/redis.conf
sudo sed -i 's/^protected-mode yes/protected-mode no/' /etc/redis/redis.conf
sudo systemctl restart redis.service
