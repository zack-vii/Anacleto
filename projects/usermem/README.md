# universal kernel module that allows user access to memory mapped 512k bytes of FPGA

../../uImage		kernel
dts/devicetree.dts	ascii devicetree
dts/devicetree.dtb	binary device tree place with uImage in /boot
linux/usermem		test module
linux/usermem.ko	kernel module insmod <file>
