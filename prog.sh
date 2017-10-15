#!/bin/bash
DIR=u-boot
CONFIG_FILE1=u-boot//configs//LicheePi_Zero_defconfig
CONFIG_FILE2=u-boot//configs//LicheePi_Zero_800x480LCD_defconfig
CONFIG_FILE=$CONFIG_FILE1

echo  "$DIR check if u-boot is exist"
if [ -d $DIR ]
then
	echo  "if use lcd please enter 'y'..."
	read IS_USELCD
	if test $IS_USELCD eq 'y'
	then
	      CONFIG_FILE=$CONFIG_FILE2   
	else
	      CONFIG_FILE=$CONFIG_FILE1
	fi

	echo  "Auto Promg..."
	if [ -f $CONFIG_FILE1 ]
	then
		echo "#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- defconfig"
		cd $DIR
		make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LicheePi_Zero_defconfig
		make ARCH=arm menuconfig
		time make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  -j4
	else
	       echo "$CONFIG_FILE1&$CONFIG_FILE2 is not"
	fi
else
        echo "no files..."
fi


