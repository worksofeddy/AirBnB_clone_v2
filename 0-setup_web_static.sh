#!/usr/bin/env bash
# script that sets up your web servers for the deployment of web_static

# installing nginx
sudo apt-get update
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'

# creating the directories needed
sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo touch /data/web_static/releases/test/index.html
sudo echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# create a symbolic link
sudo ln -s -f /data/web_static/releases/test/ /data/web_static/current

# change ownership
sudo chown -R ubuntu:ubuntu /data/

# Update the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static
sudo sed -i '/listen 80 default_server/a location /hbnb_static {alias /data/web_static/current/;}' /etc/nginx/sites-enabled/default

# restart nginx
sudo service nginx restart
