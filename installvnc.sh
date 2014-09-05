#!/bin/sh

apt-get update
apt-get upgrade

#Install GNOME
apt-get install gnome-desktop-environment

#Install Fonts yang dibutuhkan
apt-get install xfonts-100dpi
apt-get install xfonts-100dpi-transcoded
apt-get install xfonts-75dpi
apt-get install xfonts-75dpi-transcoded
apt-get install xfonts-base


#Install TightVNCServer:
apt-get install tightvncserver

#Edit the xstartup file:
# nano  ~/.vnc/xstartup

echo "#!/bin/shxrdb $HOME/.Xresources" > ~/.vnc/xstartup
echo "xsetroot -solid grey" > ~/.vnc/xstartup
echo "x-terminal-emulator -geometry 80×24+10+10 -ls -title “$VNCDESKTOP Desktop” &" > ~/.vnc/xstartup
echo "# x-window-manager &" > ~/.vnc/xstartup
echo "gnome-session &" > ~/.vnc/xstartup

#Memulai VNC dengan resolusi layar yang kita inginkan :
tightvncserver -geometry 1024×768 :1

#Sumber: http://pakzu.com/install-vnc-dan-gnome-di-debian/
