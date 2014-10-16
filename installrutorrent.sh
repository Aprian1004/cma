#!/bin/bash

apt-get update

sudo apt-get install subversion build-essential automake libtool libcppunit-dev libcurl3-dev libsigc++-2.0-dev unzip unrar-free curl libncurses-dev

apt-get install apache2 php5 php5-cli php5-curl

#Enable scgi for Apache:

apt-get install libapache2-mod-scgi

ln -s /etc/apache2/mods-available/scgi.load /etc/apache2/mods-enabled/scgi.load

#Install XMLRPC:

mkdir /install;cd /install

svn checkout http://xmlrpc-c.svn.sourceforge.net/svnroot/xmlrpc-c/stable xmlrpc-c

cd xmlrpc-c

./configure --disable-cplusplus

make

make install

#Intall libtorrent:

cd /install

wget http://vps6.net/src/libtorrent-0.13.0.tar.gz

tar xvf libtorrent-0.13.0.tar.gz

cd libtorrent-0.13.0

./autogen.sh

./configure

make

make install

#Install rTorrent:

cd /install

wget http://vps6.net/src/rtorrent-0.9.0.tar.gz

cd rtorrent-0.9.0

./autogen.sh

./configure --with-xmlrpc-c

make

make install

ldconfig

#Create required directories:

mkdir /home/seeder1/rtorrent

mkdir /home/seeder1/rtorrent/.session

mkdir /home/seeder1/rtorrent/watch

mkdir /home/seeder1/rtorrent/download

#Setup .rtorrent.rc file (rTorrent config):

cd ~/

wget http://vps6.net/src/.rtorrent.rc

cp .rtorrent.rc /home/seeder1/

#(Edit the settings in .rtorrent.rc, like max upload/download speed, max connected peers, etc, as needed.)

#Install rTorrent:

cd /install

wget http://vps6.net/src/rutorrent-3.0.tar.gz

tar xvf rutorrent-3.0.tar.gz

mv rutorrent /var/www

wget http://vps6.net/src/plugins-3.0.tar.gz

tar xvf plugins-3.0.tar.gz

mv plugins /var/www/rutorrent

rm -rf /var/www/rutorrent/plugins/darkpal

chown -R www-data:www-data /var/www/rutorrent

#Secure /rutorrent:

a2enmod ssl

a2enmod auth_digest

a2enmod scgi

openssl req $@ -new -x509 -days 365 -nodes -out /etc/apache2/apache.pem -keyout /etc/apache2/apache.pem

chmod 600 /etc/apache2/apache.pem

htdigest -c /etc/apache2/passwords seedbox seeder1

#(Enter a password of your choice when prompted, you will use this to log in to the ruTorrent web UI.)

cd /etc/apache2/sites-available/

rm -rf default

wget http://vps6.net/src/default

a2ensite default-ssl

/etc/init.d/apache2 reload

#Install screen:

apt-get install screen

Start rTorrent in a detached shell using screen:

screen -fa -d -m rtorrent >> /etc/rc.local

cd
wget https://raw.githubusercontent.com/cmaimu/debian7/master/userrutorrent.sh
chmod +x userrutorrent.sh 
