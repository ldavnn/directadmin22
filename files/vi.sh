#!/bin/sh

OS=`uname`;
STT_VER=""
VERSION_DA=""
TRUE_FALSE="n"
DA_CONF=/usr/local/directadmin/conf/directadmin.conf
SERVER="https://raw.githubusercontent.com/ldavnn/directadmin/master"

if [ "$OS" = "FreeBSD" ]; then
	WGET_PATH=/usr/local/bin/wget
else
	WGET_PATH=/usr/bin/wget
fi

echo "##################################################"
echo "#        CAI DAT DIRECTADMIN EDIT BY LDAVN       #"
echo "#                 FB.COM/LDA.VN                  #"
echo "#        SCRIPT CAI DAT TU DONG CAC LOAI         #"
echo "#             PHIEN BAN DIRECTADMIN              #"
echo "##################################################"
echo "#        SCRIPT CO THE CAI CAC PHIEN BAN         #"
echo "#                    DUOI DAY                    #"
echo "##################################################"
echo "#            + DIRECTADMIN 1.44.3 (1)            #"
echo "#            + DIRECTADMIN 1.48.2 (2)            #"
echo "#            + DIRECTADMIN 1.50.1 (3)            #"
echo "#            + DIRECTADMIN 1.51.3 (4)            #"
echo "#            + DIRECTADMIN 1.51.4 (5)            #"
echo "#            + DIRECTADMIN 1.52.1 (6)            #"
echo "#            + DIRECTADMIN 1.53.0 (7)            #"
echo "##################################################"
echo "#  NHAP VAO SO THU TU   ||  NEU RAM CUA BAN NHO  #"
echo "#  DA DUOC GAN SAU      ||  HON HOAC BANG 512MB  #"
echo "#  PHIEN BAN DA         ||  THI HAY TAO SWAP     #"
echo "#  DE CHON PHIEN BAN    ||  TRUOC KHI THUC HIEN  #"
echo "#  CAI DAT DIRECTADMIN  ||  VIEC CAI DIRECTADMIN #"
echo "##################################################"
echo "#         DE THOAT KHOI TIEN TRINH CAI DAT       #"
echo "#              VUI LONG AN CTRL + C              #"
echo "##################################################"
echo ""

while [ "$TRUE_FALSE" = "n" ];
do
{
	echo -n "Nhap Vao So Thu Tu Phien Ban DA Ban Muon Cai (Vd: 1, 2, 3, 4, 5, 6, 7): "
	read STT_VER;
	echo ""
	if [ "$STT_VER" = "1" ] || [ "$STT_VER" = "2" ] || [ "$STT_VER" = "3" ] || [ "$STT_VER" = "4" ] || [ "$STT_VER" = "5" ] || [ "$STT_VER" = "6" ] || [ "$STT_VER" = "7" ]; then
		echo "Phien Ban DA Tuong Thich."
		TRUE_FALSE="y";
		sleep 3;
		clear
	else
		echo "STT Phien Ban DA Khong Hop Le, Vui Long Thu Lai!"
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
echo "Dang Thuc Hien Cai Dat Directadmin..."
sleep 5;
./da-${VERSION_DA}.sh
sleep 5;

if [ ! -s $DA_CONF ]; then
	echo "Loi Cai Dat Directadmin. Vui Long Cai Dat Lai."
	exit 0;
fi
rm -rf /root/da-${VERSION_DA}.sh

if [ "$STT_VER" = "2" ] || [ "$STT_VER" = "3" ] || [ "$STT_VER" = "4" ] || [ "$STT_VER" = "5" ] || [ "$STT_VER" = "6" ] || [ "$STT_VER" = "7" ]; then
	$WGET_PATH -O /root/config.sh ${SERVER}/files/config.sh
	chmod 777 /root/config.sh
	echo "Dang Cau Hinh Card Mang Cho Directadmin..."
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
echo "Tiep Tuc Tien Trinh Cai Dat PHP Lan 2, Ban Co Muon Cai Dat Ko."
echo "Cai Dat PHP Lan 2 Se Lam WebServer Chay On Dinh Va Co The Fix Loi Trong Cac Loai Code."
echo -n "Ban Muon Cai Dat (y/n): "
read TRUE_FALSE;
if [ "$TRUE_FALSE" = "y" ]; then
	echo "Bat Dau Tien Trinh Cai Dat PHP Lan 2."
	sleep 5;
	cd /usr/local/directadmin/custombuild
	./build clean all
	./build php n
	./build rewrite_confs
	clear
	echo "Cai Dat PHP Lan 2 Thanh Cong."
	sleep 5;
	clear
else
	echo "Ban Khong Chon Cai Dat PHP Lan 2."
	sleep 5;
	clear
fi

cd /usr/local/directadmin/scripts
SERVERIP=`cat ./setup.txt | grep ip= | cut -d= -f2`;
USERNAME=`cat ./setup.txt | grep adminname= | cut -d= -f2`;
PASSWORD=`cat ./setup.txt | grep adminpass= | cut -d= -f2`;

echo "Cai Dat Directadmin Thanh Cong."
echo "Dia Chi Dang Nhap http://${SERVERIP}:2222"
echo "Tai Khoan Admin: $USERNAME"
echo "Mat Khau Admin: $PASSWORD"
echo "Quan Ly Tien Trinh - Ram - Chip - Disk Tai http://${SERVERIP}/status.php"
echo "Cam On Ban Da Su Dung."
echo "LDA - FB.COM/LDA.VN"
