#!/bin/bash
sudo apt-get update

# sudo apt upgrade -y

# Install MySQL
sudo apt-get install mysql-server -y
sudo systemctl start mysql.service
sudo mysql -Bse \
    "CREATE USER 'mysql'@'%' IDENTIFIED BY 'mysql'; GRANT ALL PRIVILEGES ON *.* To 'mysql'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# Install Redis
sudo apt-get install redis -y

# Install Nginx
sudo apt-get install nginx -y 

# Set up Nginx
sudo rm /etc/nginx/sites-enabled/default
sudo tee /etc/nginx/sites-available/default <<EOF
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
sudo systemctl restart nginx

# Install Pipx
sudo apt-get install pipx -y
/usr/bin/pipx ensurepath
sudo /usr/bin/pipx ensurepath --global
# TODO: findout why poetry is not installed in the virtual environment
/usr/bin/pipx install poetry

# Set up Poetry
/home/ubuntu/.local/bin/poetry config virtualenvs.in-project true

# Set up service
sudo tee /etc/systemd/system/app.service <<EOF
[Unit]
Description=Python App
After=network.target multi-user.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/app
ExecStart=/home/ubuntu/app/.venv/bin/python3 /home/ubuntu/app/main.py
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=app

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable app.service
sudo systemctl start app.service
