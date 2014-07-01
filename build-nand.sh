#!/bin/bash

NAME=$1

NANDNAME=$2
NANDSIZE=0xe80000

XLOADER=./archive/x-load_revc_v3.bin.ift
UBOOT=./archive/u-boot-f_revc_v3.bin

OBJCOPY=arm-rtems4.11-objcopy
MKIMAGE=mkimage
NANDFLASH=./bb_nandflash.sh
NANDFLASH_ECC=./bb_nandflash_ecc

ADDRESS=0x80000000
ENTRY=0x80000000

$OBJCOPY -R -S -O binary $NAME.exe $NAME.bin
cat $NAME.bin | gzip -9 >$NAME.gz
$MKIMAGE -A arm -O rtems -T kernel -a $ADDRESS -e $ENTRY -n "RTEMS" -d $NAME.gz $NAME.img
rm $NAME.bin $NAME.gz

$NANDFLASH $XLOADER $NANDNAME x-loader
$NANDFLASH $UBOOT $NANDNAME u-boot
$NANDFLASH $NAME.img $NANDNAME kernel

$NANDFLASH_ECC $NANDNAME 0x0 $NANDSIZE
