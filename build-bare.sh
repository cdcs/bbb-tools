#!/bin/bash

NAME=$1
NANDNAME=$2
NANDSIZE=0xe80000

TARGET=arm-none-eabi
RAMMAP=rammap

XLOADER=./archive/x-load_revc_v3.bin.ift
UBOOT=./archive/u-boot-f_revc_v3.bin

NANDFLASH=./bb_nandflash.sh
NANDFLASH_ECC=./bb_nandflash_ecc

$TARGET-gcc -Wall -Werror -O3 -nostdlib -ffreestanding -c $NAME.c -o $NAME.o
$TARGET-ld -T $RAMMAP $NAME.o -o $NAME.elf
$TARGET-objcopy $NAME.elf -O binary $NAME.bin
#rm $NAME.o $NAME.elf

$NANDFLASH $XLOADER $NANDNAME x-loader
$NANDFLASH $UBOOT $NANDNAME u-boot
$NANDFLASH $NAME.bin $NANDNAME kernel

$NANDFLASH_ECC $NANDNAME 0x0 $NANDSIZE
