#!/bin/bash

#gantikeycoin.sh 
#link https://raw.githubusercontent.com/cmaimu/debian7/master/gantikeycoin.sh

cd
rm cointellect.sh

cd
echo -n "user/key/license cointellet = "
read user

#untuk cointellect.sh
echo "#!/bin/bash"  | tee -a cointellect.sh
echo "VAL=1"  | tee -a cointellect.sh
echo "while true; do"  | tee -a cointellect.sh
echo "cd cpuminer-2.4"  | tee -a cointellect.sh
echo "./minerd --url=stratum+tcp://66.55.92.73:8000 -p 123 -u $user"  | tee -a cointellect.sh
echo "sleep 10"  | tee -a cointellect.sh
echo "done"  | tee -a cointellect.sh

chmod +x cointellect.sh

echo "Bila mau ganti key lagi, silahkan ketik"
echo "./gantikey.sh"

echo "Untuk memulai mining, silahkan ketik"
echo "./cointellect.sh"

echo "Note:"
echo "Sebaiknya mining dilakukan di moder RDP"
echo "Modified by insanulfaqir"
