#!/bin/sh

SERVER="https://raw.githubusercontent.com/ldavnn/directadmin/master"
SERVER_NEW="https://www.plesk.com.vn/license.key"
LICENSE=/usr/local/directadmin/conf/license.key
LICENSE_GZ=/usr/local/directadmin/conf/license.key.gz

echo "#####################################################"
echo "#          CAI DAT DIRECTADMIN EDIT BY LDAVN        #"
echo "#                   FB.COM/LDA.VN                   #"
echo "#####################################################"
echo "#             GET LICENSE DIRECTADMIN               #"
echo "#####################################################"
echo ""

cd /usr/local/directadmin/conf
service directadmin stop
rm -rf $LICENSE
## wget -O $LICENSE_GZ ${SERVER}/files/license.key.gz
## gunzip $LICENSE_GZ
## rm -rf $LICENSE_GZ
wget -O $LICENSE $SERVER_NEW
chmod 600 $LICENSE
chown diradmin:diradmin $LICENSE
service directadmin start

echo "Get License Success!"
