#!/bin/bash
src=$(realpath $(dirname $0))
KVER=${KVER:-4.9.0}
u512=$src/../usermem
name=${1:-$(basename $src)}

makedest () {
raw=$1
dest=~/rp/${name}$1
mkdir -p $dest
}

makedest /
rm -rf $dest/*
cp -rf $src/fs/* $u512/fs/* $dest
makedest /boot
cp $u512/devicetree.dtb $src/../../uImage $dest
makedest /boot/fpga
cp $src/edit/red_pitaya/rp_trig_brd_1.0.bit/rp_trig_brd_1.0.bit $dest/fpga_rptrig.bit
makedest /lib
cp $src/linux/librptrig.so $dest
makedest /bin
cp $src/linux/rptrig $dest
makedest /lib/modules/${KVER}-xilinx/
cp $u512/linux/usermem.ko $dest
makedest
fakeroot tar -zcf $dest.tgz -C $dest .
