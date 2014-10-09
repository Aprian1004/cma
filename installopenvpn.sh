#!/bin/bash

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0'`;
MYIP2="s/xxxxxxxxx/$MYIP/g";

#link download: https://raw.githubusercontent.com/cmaimu/debian7/master/installopenvpn.sh

#cek ready tidak-nya
cat /dev/net/tun

#update
apt-get update

#install paket
apt-get -y install openvpn
apt-get -y install zip

#Copy helper script
cp -a /usr/share/doc/openvpn/examples/easy-rsa /etc/openvpn/

#buat sertifikat
cd /etc/openvpn/easy-rsa/2.0
source ./vars
./clean-all
./build-ca

#buat difle helman parameter
./build-dh

#generate sertifikat untuk server
./build-key-server server01

#Untuk menghindari UDP flood dan serangan DDoS maka jalankan: 
openvpn --genkey --secret keys/ta.key

#buat config server UDP dan TCP
cd /etc/openvpn
wget -O server-udp-1194.conf "https://raw.githubusercontent.com/cmaimu/debian7/master/server-udp-1194.conf"
wget -O server-tcp-465.conf "https://raw.githubusercontent.com/cmaimu/debian7/master/server-tcp-465.conf"

mkdir /etc/openvpn/keys

cp /etc/openvpn/easy-rsa/2.0/keys/{ca.crt,server01.crt,server01.key,dh1024.pem,ta.key} /etc/openvpn/keys/

#rubah config
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn

#restart openvpn
service openvpn restart

sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
wget -O /etc/iptables.up.rules "https://raw.github.com/yurisshOS/debian7os/master/iptables.up.rules"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i $MYIP2 /etc/iptables.up.rules;
iptables-restore < /etc/iptables.up.rules
service openvpn restart

echo -n "Jenis virtualisasi apa? (1.OVZ 2.KVM/XEN)"
read virtualisasi

if [ "$virtualisasi" == 1 ]
then
#untuk OVZ
#setting iptables jalur UDP
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o venet0 -j MASQUERADE
#setting iptables jalur TCP
iptables -t nat -I POSTROUTING -s 10.9.0.0/24 -o venet0 -j MASQUERADE
elif [ "$virtualisasi" == 2 ]
then
#untuk KVM/XEN
#setting iptables jalur UDP
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
#setting iptables jalur TCP
iptables -t nat -I POSTROUTING -s 10.9.0.0/24 -o eth0 -j MASQUERADE
fi

cd /etc/openvpn

#setting untuk client
echo -n "Tulis IP VPS-nya (contoh: 192.168.0.1):"
read ipvps
mkdir clientconfig
cp /etc/openvpn/easy-rsa/2.0/keys/{ca.crt,ta.key} clientconfig/
cd /etc/openvpn/clientconfig
wget https://raw.githubusercontent.com/cmaimu/debian7/master/client-udp-1194.ovpn 
wget https://raw.githubusercontent.com/cmaimu/debian7/master/client-tcp-465.ovpn
sed -i "s/remote xxxxxxxxxxxx 1194/remote $ipvps 1194/g" client-udp-1194.ovpn
sed -i "s/remote xxxxxxxxxxxx 465/remote $ipvps 465/g" client-tcp-465.ovpn


zip client.zip *
cp client.zip /home/vps/public_html/

echo "Silahkan bagikan file client.zip pada membernya"

#Modified by Ahmad Jibril
#Source: ari-f.com
