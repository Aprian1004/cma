#!/bin/bash

#link download https://raw.githubusercontent.com/cmaimu/debian7/master/installsoftx.sh
#Update dulu
su -c "apt-get update; apt-get install build-essential"

#Tanya veris debian:
echo -n "Versi Debian (1. 32bit, 2. 64.bit)"
read versi

#download config
wget https://raw.githubusercontent.com/cmaimu/debian7/master/configsoftx.sh
chmod +x configsoftx.sh

#Download file
if [ "$versi" == 1 ]
then
#echo "Versi 32 bit"
wget http://www.softether-download.com/files/softether/v2.00-9387-rtm-2013.09.16-tree/Linux/SoftEther%20VPN%20Server/32bit%20-%20Intel%20x86/softether-vpnserver-v2.00-9387-rtm-2013.09.16-linux-x86-32bit.tar.gz
tar zxvf softether-vpnserver-v2.00-9387-rtm-2013.09.16-linux-x86-32bit.tar.gz 
elif [ "$versi" == 2 ]
then
#echo "versi debian 64 bit"
wget http://www.softether-download.com/files/softether/v2.00-9387-rtm-2013.09.16-tree/Linux/SoftEther%20VPN%20Server/64bit%20-%20Intel%20x64%20or%20AMD64/softether-vpnserver-v2.00-9387-rtm-2013.09.16-linux-x64-64bit.tar.gz
tar zxvf softether-vpnserver-v2.00-9387-rtm-2013.09.16-linux-x64-64bit.tar.gz
fi

#Pemindahan file dan pemberian hak eksekusi
mv vpnserver /usr/local
cd /usr/local/vpnserver/
chmod 600 *
chmod 700 vpncmd
chmod 700 vpnserver

#config softex
wget -O /etc/init.d/vpnserver "https://raw.githubusercontent.com/cmaimu/debian7/master/softex.sh"
chmod 755 /etc/init.d/vpnserver;
mkdir /var/lock/subsys;
update-rc.d vpnserver defaults;
/etc/init.d/vpnserver startcd;

#Panduan install
echo "PANDUAN INSTALL" | tee -a log-softex-install.txt
echo "perhatikan baik, baik!" | tee -a log-softex-install.txt
echo "Panduan ini hanya di tampilkan sekali," | tee -a log-softex-install.txt
echo "jika lupa, silahkan ulangi dari awal" | tee -a log-softex-install.txt
echo "atau buka web yang menampilkan langkah ini" | tee -a log-softex-install.txt
echo "dari sini semua langkah dilakukan manual" | tee -a log-softex-install.txt
echo "  " | tee -a log-softex-install.txt
echo "Langkah-langkah:" | tee -a log-softex-install.txt
echo "Jika ada pertanyaan, pilih 1" | tee -a log-softex-install.txt
echo "pilih 1 (1. Management of VPN Server or VPN Bridge)" | tee -a log-softex-install.txt
echo "jika ada "Hostname of IP Address of Destination:"," | tee -a log-softex-install.txt
echo "ketik IP_VPS:port. misal IP_VPS=192.168.0.1," | tee -a log-softex-install.txt
echo "maka jadinya seperti" | tee -a log-softex-install.txt
echo "Hostname of IP Address of Destination:192.168.0.1:5555" | tee -a log-softex-install.txt
echo "selanjutnya enter jika ada "Specify Virtual Hub Name:"  " | tee -a log-softex-install.txt
echo "selanjutnya akan muncul seperti berikut" | tee -a log-softex-install.txt
echo "You have administrator privileges for the entire VPN Server." | tee -a log-softex-install.txt
echo "VPN Server>" | tee -a log-softex-install.txt
echo "ketik "ServerPasswordSet", menjadi" | tee -a log-softex-install.txt
echo "You have administrator privileges for the entire VPN Server." | tee -a log-softex-install.txt
echo "VPN Server>ServerPasswordSet" | tee -a log-softex-install.txt
echo "kemudian masukkan password servernya 2 kali" | tee -a log-softex-install.txt
echo "Sampai langkah di atas, installasi tahap 1 selesai" | tee -a log-softex-install.txt
echo "  " | tee -a log-softex-install.txt
echo "Untuk melanjutkan installasi," | tee -a log-softex-install.txt
echo "Silahkan ikuti langkah di atas" | tee -a log-softex-install.txt
echo -n "silahkan ketik "1" (untuk ya):"
read ketik

if [ "$ketik" == 1 ]
then
cd /usr/local/vpnserver/
make
./vpnserver start
./vpncmd
fi

#Modified by Ahmad Jibril Syaikhu


