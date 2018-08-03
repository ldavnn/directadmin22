#!/bin/sh

OS=`uname`;
STT_VER=""
VERSION_DA=""
TRUE_FALSE="n"
DA_CONF=/usr/local/directadmin/conf/directadmin.conf
SERVER="http://hack-like.me/directadmin"

if [ "$OS" = "FreeBSD" ]; then
	WGET_PATH=/usr/local/bin/wget
else
	WGET_PATH=/usr/bin/wget
fi

echo "##################################################"
echo "#        CAI DAT DIRECTADMIN EDIT BY LDAVN       #"
echo "#                 FB.COM/LDA.VN                  #"
echo "#        SCRIPT AUTO SETUP MULTI VERSION         #"
echo "#                  DIRECTADMIN                   #"
echo "##################################################"
echo "#          SCRIPT CAN BE SETUP VERSIONS          #"
echo "#                     BELOW                      #"
echo "##################################################"
echo "#            + DIRECTADMIN 1.44.3 (1)            #"
echo "#            + DIRECTADMIN 1.48.2 (2)            #"
echo "#            + DIRECTADMIN 1.50.1 (3)            #"
echo "#            + DIRECTADMIN 1.51.3 (4)            #"
echo "#            + DIRECTADMIN 1.51.4 (5)            #"
echo "#            + DIRECTADMIN 1.52.1 (6)            #"
echo "#            + DIRECTADMIN 1.53.0 (7)            #"
echo "##################################################"
echo "#  ENTER SERIAL NUMBER  ||  IF YOUR RAM IS LESS  #"
echo "#  ASSIGNED AFTER THE   ||  THAN OR EQUAL TO     #"
echo "#  DIRECTADMIN VERSION  ||  512MB THEN CREATE    #"
echo "#  TO SELECT            ||  SWAP BEFORE INSTALL  #"
echo "#  DIRECTADMIN VERSION  ||  DIRECTADMIN          #"
echo "##################################################"
echo "#           TO EXIT PROCESS INSTALLING           #"
echo "#              PLEASE ENTER CTRL + C             #"
echo "##################################################"
echo ""

while [ "$TRUE_FALSE" = "n" ];
do
{
	echo "Enter The Directadmin Version Serial Number You"
	echo -n "Want To Install (Ex: 1, 2, 3, 4, 5, 6, 7): "
	read STT_VER;
	echo ""
	if [ "$STT_VER" = "1" ] || [ "$STT_VER" = "2" ] || [ "$STT_VER" = "3" ] || [ "$STT_VER" = "4" ] || [ "$STT_VER" = "5" ] || [ "$STT_VER" = "6" ] || [ "$STT_VER" = "7" ]; then
		echo "DirectAdmin Version Serial Number Is Compatible."
		TRUE_FALSE="y";
		sleep 3;
		clear
	else
		echo "DirectAdmin Version Serial Number Is Not Available, Please Try Again!"
		TRUE_FALSE="n";
		sleep 3;
		clear
	fi
}
done;

if [ "$STT_VER" = "1" ]; then
	VERSION_DA=1443
elif [ "$STT_VER" = "2" ]; then
	VERSION_DA=1482
elif [ "$STT_VER" = "3" ]; then
	VERSION_DA=1500
elif [ "$STT_VER" = "4" ]; then
	VERSION_DA=1513
elif [ "$STT_VER" = "5" ]; then
	VERSION_DA=1514
elif [ "$STT_VER" = "6" ]; then
	VERSION_DA=1521
elif [ "$STT_VER" = "7" ]; then
	VERSION_DA=1530
fi

cd /root
$WGET_PATH -O /root/da-${VERSION_DA}.sh ${SERVER}/files/da-${VERSION_DA}.sh
chmod 777 /root/da-${VERSION_DA}.sh
echo "Performing DirectAdmin Installation..."
sleep 5;
./da-${VERSION_DA}.sh
sleep 5;

if [ ! -s $DA_CONF ]; then
	echo "Error Installing Directadmin. Please Try Rebuild OS Then Install."
	exit 0;
fi
rm -rf /root/da-${VERSION_DA}.sh

if [ "$STT_VER" = "2" ] || [ "$STT_VER" = "3" ] || [ "$STT_VER" = "4" ] || [ "$STT_VER" = "5" ] || [ "$STT_VER" = "6" ] || [ "$STT_VER" = "7" ]; then
	$WGET_PATH -O /root/config.sh ${SERVER}/files/config.sh
	chmod 777 /root/config.sh
	echo "Configuring The Network Card For Directadmin..."
	sleep 5;
	./config.sh
	sleep 5;
	rm -rf /root/config.sh
	service directadmin restart
	clear
else
	grep -q 'letsencrypt=1' /usr/local/directadmin/conf/directadmin.conf || echo "letsencrypt=1" >> /usr/local/directadmin/conf/directadmin.conf
	grep -q 'enable_ssl_sni=1' /usr/local/directadmin/conf/directadmin.conf || echo "enable_ssl_sni=1" >> /usr/local/directadmin/conf/directadmin.conf
	grep -q 'hide_brute_force_notifications=1' /usr/local/directadmin/conf/directadmin.conf || echo "hide_brute_force_notifications=1" >> /usr/local/directadmin/conf/directadmin.conf
	service directadmin restart
	clear
fi

sleep 5;
TRUE_FALSE="n";
echo "Continue Process Install PHP Twice, Would You Want To Install."
echo "Install PHP Twice Will Make WebServer Run Stably And Can Fix Error In Types Code."
echo -n "Would You Want To Install (y/n): "
read TRUE_FALSE;
if [ "$TRUE_FALSE" = "y" ]; then
	echo "Starting Process Install PHP Twice."
	sleep 5;
	cd /usr/local/directadmin/custombuild
	./build clean all
	./build php n
	./build rewrite_confs
	clear
	echo "The PHP Twice Has Been Installed."
	sleep 5;
	clear
else
	echo "You Not Select The PHP Twice."
	sleep 5;
	clear
fi

cd /usr/local/directadmin/scripts
SERVERIP=`cat ./setup.txt | grep ip= | cut -d= -f2`;
USERNAME=`cat ./setup.txt | grep adminname= | cut -d= -f2`;
PASSWORD=`cat ./setup.txt | grep adminpass= | cut -d= -f2`;

echo "Directadmin Has Been Installed."
echo "Url Login http://${SERVERIP}:2222"
echo "User Admin: $USERNAME"
echo "Pass Admin: $PASSWORD"
echo "Manager Process - Ram - Chip - Disk At http://${SERVERIP}/status.php"
echo "Thank For You Using My Tool."
echo "LDA - FB.COM/LDA.VN"
