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

# Set up Nginx
sudo tee /etc/nginx/sites-available/app <<EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/app
sudo systemctl restart nginx

# Install Pipx
sudo apt-get install pipx -y
pipx ensurepath
sudo pipx ensurepath --global
pipx install poetry
exec $SHELL

# Set up Poetry
poetry config virtualenvs.in-project true

# Set up service
sudo tee /etc/systemd/system/app.service <<EOF
[Unit]
Description=Python App
After=network.target multi-user.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/app
ExecStart=~/app/.venv/bin/python3 main.py
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=app

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable app
sudo systemctl start app
