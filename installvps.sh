#!/bin/bash

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0'`;
MYIP2="s/xxxxxxxxx/$MYIP/g";


#1. Update dan Upgrade Sistem
apt-get update && apt-get upgrade

#2. Install Irssi
apt-get -y install irssi 

#3. Install Text Editor (Nano)
apt-get -y install nano

#4. Install WGET
apt-get -y install wget

#5.  Install Curl
apt-get -y install curl

#6.  Disable IPv6, set local, set time zone
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

#7.  Update dan Upgrade System
apt-get update && apt-get -y upgrade
apt-get -y install cron
# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# install essential package
echo "mrtg mrtg/conf_mods boolean true" | debconf-set-selections
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update


#8.  Install Web Server
cd
https://raw.githubusercontent.com/cmaimu/debian7/master/installnginx.sh
chmod +x installnginx.sh
./installnginx.sh

#10.  Install Webmin
cd
https://raw.githubusercontent.com/cmaimu/debian7/master/installwebmin.sh
chmod +x installwebmin.sh
./installwebmin.sh

#11. Cara Install Squid dan Set Port Squid
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.github.com/yurisshOS/debian7os/master/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

#12.  Install Dropbear dan Set Port Dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS=""/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

#13.  Set Port OpenSSH
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config

#14.  Install OpenVPN
cd
https://raw.githubusercontent.com/cmaimu/debian7/master/installopenvpn.sh
chnod +x installopenvpn.sh
./installopenvpn.sh

#15.  Install BadVPN
 wget -O /usr/bin/badvpn-udpgw "http://script.jualssh.com/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw "http://script.jualssh.com/badvpn-udpgw64"
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

#16.  install fail2ban
apt-get -y install fail2ban;service fail2ban restart

#Script2
wget  https://raw.github.com/ykristanto/31337/master/debian/script/member --no-check-certificate -O akun
wget  https://raw.github.com/ykristanto/31337/master/debian/script/login  --no-check-certificate -O login
wget  https://raw.githubusercontent.com/cmaimu/debian7/master/add-user.sh
wget -O /usr/bin/akun "https://raw.githubusercontent.com/cmaimu/debian7/master/akun"
wget -O /usr/bin/perpanjang "https://raw.githubusercontent.com/cmaimu/debian7/master/renew"
wget -O speedtest_cli.py "https://raw.github.com/sivel/speedtest-cli/master/speedtest_cli.py"
echo "0 */6 * * * root /sbin/reboot" > /etc/cron.d/reboot

chmod +x member
chmod +x login
chmod +x add-user.sh
chmod +x /usr/bin/akun
chmod +x /usr/bin/perpanjang
chmod +x speedtest_cli.py

# finishing
chown -R www-data:www-data /home/vps/public_html
service cron restart
service nginx start
service php-fpm start
service openvpn restart
service ssh restart
service dropbear restart
service fail2ban restart
service squid3 restart
service webmin restart

# info
clear
echo ""  | tee -a log-install.txt
echo "AUTOSCRIPT INCLUDES" | tee log-install.txt
echo "===============================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Service"  | tee -a log-install.txt
echo "-------"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (client config : http://$MYIP:81/client.zip)"  | tee -a log-install.txt
echo "OpenSSH  : 22"  | tee -a log-install.txt
echo "Dropbear : 443"  | tee -a log-install.txt
echo "Squid3   : 8080 (limit to IP SSH)"  | tee -a log-install.txt
echo "badvpn   : badvpn-udpgw port 7300"  | tee -a log-install.txt
echo "nginx    : 81"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Script"  | tee -a log-install.txt
echo "------"  | tee -a log-install.txt
echo "./speedtest_cli.py --share"  | tee -a log-install.txt
echo "./login" | tee -a log-install.txt
echo "./add-user.sh [untuk menambah user]" | tee -a log-install.txt
echo "akun [untuk melihat total user dan masa expirednya]" | tee -a log-install.txt
echo "perpanjang [untuk memperpanjang user]" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Fitur lain"  | tee -a log-install.txt
echo "----------"  | tee -a log-install.txt
echo "Webmin   : https://$MYIP:10000/"  | tee -a log-install.txt
echo "Timezone : Asia/Jakarta"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "IPv6     : [off]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "VPS AUTO REBOOT TIAP 6 JAM"  | tee -a log-install.txt
echo "SILAHKAN REBOOT VPS ANDA"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "==============================================="  | tee -a log-install.txt
cd
