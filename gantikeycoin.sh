#!/bin/bash

#gantikeycoin.sh 
#link 

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

chmod +x cointellect.sh
