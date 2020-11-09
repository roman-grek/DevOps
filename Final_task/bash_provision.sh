#! /bin/bash

yum update -y

# install apache, php and mysql-server
yum install -y httpd24 php73 mysql57-server php73-mysqlnd

# start apache web server
service httpd start

# configure apache to start on every boot
chkconfig httpd on

# add ec2-user to apache group and give permissions to manipulate webserver files
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

# add php file for testing
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

# install ansible
pip install ansible