#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo echo "Hello from terraform $HOSTNAME " > /var/www/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx