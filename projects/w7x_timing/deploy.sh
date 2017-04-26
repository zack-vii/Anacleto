#!/bin/sh
set -e
S=$(realpath $(dirname ${0}))
RedPitayaIP=$1
RP=root@${RedPitayaIP}
if [ "0$2" -gt "0" ]
then
  if [ "$2" -gt "1" ]
  then
    echo default password is 'root'
    # scp ~/.ssh/authorized_keys root@RP-F0432C:/root/.ssh/authorized_keys
    ssh-copy-id $RP
    ssh $RP passwd
    ssh $RP apt-get update
    ssh $RP apt-get -y install python-numpy kmod
  fi
  ssh $RP ". /etc/profile&&rw&&mount -o remount,rw /boot&&echo ok||echo failed"
  scp $S/logic/sdk/dts/devicetree.dtb $S/../../uImage $RP:/boot
fi
scp -r $S/rp/* $RP:/
scp $S/src/libw7x_timing_lib.so $RP:/lib
scp $S/logic/out/red_pitaya.bit $S/src/w7x_timing.ko $RP:/root
ssh $RP systemctl enable w7x_timing w7x_timing_fpga
if [ "0$2" -gt "0" ]
then
  ssh $RP reboot
else
  ssh $RP systemctl stop  w7x_timing.service
  ssh $RP /bin/w7x_timing test
  ssh $RP systemctl start w7x_timing.service
fi
