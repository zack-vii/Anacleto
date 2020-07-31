#!/bin/sh
src=$(realpath $(dirname ${0}))
name=$1
makedest () {
dest=~/rp/${name}$1
mkdir -p ${dest}
}
makedest /
cp -rf ${src}/rp/* $dest
makedest /boot
cp ${src}/logic/sdk/dts/devicetree.dtb ${src}/../../uImage $dest
makedest /root
cp ${src}/logic/out/red_pitaya.bit ${src}/src/w7x_timing.ko $dest
makedest /lib
cp ${src}/src/libw7x_timing_lib.so $dest
