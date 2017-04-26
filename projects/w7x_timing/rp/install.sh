#!/bin/sh
set -e
S=$(realpath $(dirname ${0}))
RP=root@$1
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
  scp $S/boot/* $RP:/boot
fi
scp -r $S/bin $S/etc $S/lib $S/root $RP:/*
ssh $RP systemctl enable w7x_timing w7x_timing_fpga
if [ "0$2" -gt "0" ]
then
  ssh $RP reboot
else
  ssh $RP systemctl stop  w7x_timing.service
  ssh $RP /bin/w7x_timing test
  ssh $RP systemctl start w7x_timing.service
fi
