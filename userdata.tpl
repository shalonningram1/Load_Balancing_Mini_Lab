#!/bin/bash

# install nginx start service
sudo apt update -y &&
sudo apt install -y nginx
sudo service nginx start
sudo systemctl enable nginx.service


