#!/bin/bash



# install nginx start service
sudo apt update -y &&
sudo apt install -y nginx
echo "Hello World" > /var/www/html/index.html
