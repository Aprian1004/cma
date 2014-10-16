#!/bin/bash
#Link

clear
echo "#######################################"
echo "##                                   ##"
echo "##           A D D  U S E R          ##"
echo "##                                   ##"
echo "#######################################"

echo -n "Mau tambah user? "
read tambah

while [ $tambah != "t" ]
do
echo -n "Nama User           :"
read namauser
echo -n "Password User       :"
read puser
echo -n "Expired (yyyy-mm-dd):"
read expired

useradd -e $expired -d /home/$namauser -M -g users -s /bin/false $namauser
echo "$namauser:$puser" | chpasswd

clear
echo "#######################################"
echo "##                                   ##"
echo "##           A D D  U S E R          ##"
echo "##                                   ##"
echo "#######################################"

echo -n "Mau tambah user lagi?"
read tambah
done


#Original: https://blog.jualssh.com/2013/10/user-add-sh-simple-script-untuk-menambahkan-user/#comment-3386
