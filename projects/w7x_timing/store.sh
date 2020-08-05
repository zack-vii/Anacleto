#!/bin/sh
src=$(realpath $(dirname $0))
u512=$src/../user512
name=$1
makedest () {
dest=~/rp/${name}$1
mkdir -p $dest
}
makedest /
cp -rf $src/rp/* $dest
makedest /boot
cp $u512/devicetree.dtb $src/../../uImage $dest
makedest /root
cp $src/out/rptrig.bit $u512/linux/user512.ko $dest
makedest /lib
cp $src/out/librptrig.so $dest
