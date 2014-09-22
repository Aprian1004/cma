#!/bin/bash

#config softether
mv ~/vpnku/vpnserver /usr/local
chmod 600 *
chmod 700 vpncmd
chmod 700 vpnserver
wget -O /etc/init.d/vpnserver "https://raw.githubusercontent.com/cmaimu/debian7/master/softex.sh"
chmod 755 /etc/init.d/vpnserver;
mkdir /var/lock/subsys;
/etc/init.d/vpnserver startcd;

echo "sekarang oftether vpn bisa di restart, stop, atau start dengan:"
echo "service vpnserver start"
echo "service vpnserver restart"
echo "service vpnserver stop"
