#!/bin/bash
#第二步：下载uboot代码并编译,如果成功，会在主目录下有u-boot.bin，在spl目录有u-boot-spl.bin
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
        
        find . -name "*.o"  | xargs rm -f
        find . -name "*.su"  | xargs rm -f
        find . -name "*.cmd"  | xargs rm -f
        find . -name "*.tmp"  | xargs rm -f
        find . -name "*.old"  | xargs rm -f
        find . -name "*.srec"  | xargs rm -f
        find . -name "*.sym"  | xargs rm -f
        find . -name "*.dtb"  | xargs rm -f
#第三步：生成boot.scr
	mkimage -C none -A arm -T script -d ../boot.cmd ../boot.scr
	cp u-boot-sunxi-with-spl.bin ../u-boot-sunxi-with-spl.bin
        cd ../
        #rm prog.sh~
	rm u-boot/.config
	rm u-boot/System.map
	rm u-boot/arch/arm/lib/asm-offsets.s
	rm u-boot/arch/arm/lib/lib.a
	rm u-boot/lib/asm-offsets.s
	rm u-boot/lib/efi_loader/helloworld.efi
	rm u-boot/lib/efi_loader/helloworld.so
	rm u-boot/u-boot-dtb.bin
	rm u-boot/u-boot-dtb.img
	rm u-boot/u-boot-nodtb.bin
	rm u-boot/u-boot-sunxi-with-spl.bin
	rm u-boot/u-boot.bin
	rm u-boot/u-boot.cfg
	#rm u-boot/u-boot.cfg.adhoc
	rm u-boot/u-boot.cfg.configs
	#rm u-boot/u-boot.cfg.ok
	#rm u-boot/u-boot.cfg.suspects
	rm u-boot/u-boot.img
	rm u-boot/u-boot.map
        rm u-boot/u-boot.lds

	rm -rf u-boot/include/config/
	rm -rf u-boot/include/generated/
	rm -rf u-boot/spl/
	rm -rf u-boot/u-boot
else
        echo "no files..."
fi


