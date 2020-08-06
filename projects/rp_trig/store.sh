#!/bin/bash
src=$(realpath $(dirname $0))
KVER=${KVER:-4.9.0}
u512=$src/../usermem
name=$1
makedest () {
dest=~/rp/${name}$1
mkdir -p $dest
}
makedest /
cp -rf $src/fs/* $u512/fs/* $dest
makedest /boot
cp $u512/devicetree.dtb $src/../../uImage $dest
makedest /boot/fpga
cp $src/out/fpga_rptrig.bit $dest
makedest /lib
cp $src/out/librptrig.so $dest
makedest /lib/modules/${KVER}-xilinx/
cp $u512/linux/usermem.ko $dest
