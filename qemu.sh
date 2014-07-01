#!/bin/bash

QEMU=qemu-system-arm
NANDNAME=$1

$QEMU -M beagle -mtdblock $NANDNAME -serial stdio -s -S
