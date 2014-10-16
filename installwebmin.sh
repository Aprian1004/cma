#!/bin/bash

#Link DL: 

#update repo:
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list

#Download dan Instal kunci GPG dengan repository
cd
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

#update sistem lagi
apt-get update

#install webmin
apt-get install webmin

#Hilangkan SSL
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
sed -i 's/SSL=1/SSL=0/g' /etc/webmin/miniserv.conf
service webmin restart

