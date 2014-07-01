bbb-tools
=========

helper scripts and tools for running stuff in the beagleboard and beaglebone


1) Compile RTEMS or a Bare Application for the beaglebone (e.g. hello.exe)
2) execute ./build-nand.sh hello name-of-your-image.img
3) Run it!
 3.1) qemu-system-arm -M beagle -mtdblock bbb.img -serial stdio
 or
 3.2) ./qemu.sh bbb.img
