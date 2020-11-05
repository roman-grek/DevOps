#! /bin/bash

yum update -y
amazon-linux-extras install -y nginx1.12
nginx -v
systemctl start nginx
systemctl enable nginx
chmod 2775 /usr/share/nginx/html
PrivateIp=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
find /usr/share/nginx/html -type d -exec chmod 2775 {} \; 
find /usr/share/nginx/html -type f -exec chmod 0664 {} \;
echo "<html><body><center><h1><p>Web server with $PrivateIp</p></h1></center></body></html>" > /usr/share/nginx/html/index.html