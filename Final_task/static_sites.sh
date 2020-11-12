#! /bin/bash

mkdir /var/www/html/wordpress
mkdir /var/www/html/gatsby

# Wordpress installation

wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo service mysqld start

# ============ MySQL commands ==========================
# mysql -u root -p
# create user '<wordpress-username>' identified by '<user password>';
# create database '<wordpress database>';
# grant all privileges on <wordpress database>.* to <wordpress-username>;
# flush privileges;
# exit;

cp wordpress/wp-config-sample.php wordpress/wp-config.php
# enter username, password and database to wordpress/wp-config.php file,
# get authentication unique keys and salts from https://api.wordpress.org/secret-key/1.1/salt/ and add to wordpress/wp-config.php

cp -r wordpress/* /var/www/html/wordpress/
sudo chkconfig httpd on && sudo chkconfig mysqld on

# Gatsby installation

sudo yum install -y git
git config --global user.name "ec2-user"
git config --global user.email "example@google.com"

npm install -g gatsby-cli
gatsby new hello-world https://github.com/gatsbyjs/gatsby-starter-hello-world
cd hello-world
gatsby build
cp -r public/* /var/www/html/gatsby/


sudo service httpd restart

