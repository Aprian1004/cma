#!/bin/bash

#link download 
#Update dulu
#su -c "apt-get update; apt-get install build-essential"

#Tanya veris debian:
echo -n "Versi Debian (1. 32bit, 2. 64.bit)"
read versi

#download config
wget https://raw.githubusercontent.com/cmaimu/debian7/master/configsoftx.sh
chmod +x configsoftx.sh

#Buat folder
mkdir ~/vpnku
cd ~/vpnku

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


#Panduan install
echo "PANDUAN INSTALL" | tee -a log-softex-install.txt
echo "perhatikan baik, baik!" | tee -a log-softex-install.txt
echo "Panduan ini hanya di tampilkan sekali," | tee -a log-softex-install.txt
echo "jika lupa, silahkan ulangi dari awal" | tee -a log-softex-install.txt
echo "atau buka web yang menampilkan langkah ini" | tee -a log-softex-install.txt
echo "dari sini semua langkah dilakukan manual" | tee -a log-softex-install.txt
echo "  " | tee -a log-softex-install.txt
echo "Langkah-langkah:" | tee -a log-softex-install.txt
echo "Ketik cd ~/vpnku/vpnserver" | tee -a log-softex-install.txt
echo "Kemudian ketik make " | tee -a log-softex-install.txt
echo "Jika ada pertanyaan, pilih 1" | tee -a log-softex-install.txt
echo "Ketik "./vpnserver start"  " | tee -a log-softex-install.txt
echo "Ketik "./vpncmd" untuk buat pass server" | tee -a log-softex-install.txt
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
echo "seteleh itu, ketik cd " | tee -a log-softex-install.txt
echo "kemudian ketik ./configsoftx.sh" | tee -a log-softex-install.txt
echo "  " | tee -a log-softex-install.txt
echo "Untuk melanjutkan installasi," | tee -a log-softex-install.txt
echo "Silahkan ikuti langkah di atas" | tee -a log-softex-install.txt
#echo -n "silahkan ketik "1" (untuk ya):"
#read ketik





