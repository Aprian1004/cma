#!/bin/bash

#link download:

apt-get -y update && apt-get -y upgrade
apt-get install yasm -y git make g++ build-essential libminiupnpc-dev
apt-get install -y libboost-all-dev libdb++-dev libgmp-dev libssl-dev dos2unix
apt-get install build-essential libcurl4-openssl-dev

wget http://sourceforge.net/projects/cpuminer/files/pooler-cpuminer-2.4.tar.gz
tar xzf pooler-cpuminer-2.4.tar.gz
cd cpuminer-2.4
./configure CFLAGS="-O3"
cd cpuminer-2.4
make


#untuk gantikey.sh
cd
wget https://raw.githubusercontent.com/cmaimu/debian7/master/gantikeycoin.sh
chmod +x gantikeycoin.sh

#input license
cd
echo -n "user/key/license cointellet = "
read user

#untuk cointellect.sh
echo "#!/bin/bash"  | tee -a cointellect.sh
echo "VAL=1"  | tee -a cointellect.sh
echo "while true; do"  | tee -a cointellect.sh
echo "cd cpuminer-2.4"  | tee -a cointellect.sh
echo "./minerd --url=stratum+tcp://66.55.92.73:8000 -p 123 -u $user"  | tee -a cointellect.sh

chmod +x cointellect.sh


echo "Untuk ganti key, silahkan ketik: ./gantikeycoin.sh"
echo "Masukkan miner licensenya"
echo "Modified by Insanulfaqir"
