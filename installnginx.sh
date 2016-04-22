#!/bin/bash

apt-get -y install nginx php5-fpm php5-cli php5-mysql

rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old

curl https://raw.githubusercontent.com/cmaimu/debian7/master/nginx.conf > /etc/nginx/nginx.conf
curl https://raw.githubusercontent.com/cmaimu/debian7/master/vps.conf > /etc/nginx/conf.d/vps.conf
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf

mkdir -p /home/vps/public_html
service php5-fpm restart
service nginx restart
