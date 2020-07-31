#!/bin/sh
set -e
S=$(realpath $(dirname ${0}))
RP=root@$1
if [ "0$2" -gt "0" ]
then
  if [ "0$2" -gt "1" ]
  then
    if [ "$2" -gt "2" ]
    then
      echo default password is 'root'
      # ssh-copy-id $RP
      scp -r $S/.ssh ${RP}:/root/.ssh
      ssh $RP apt-get update
      ssh $RP apt-get -y install python-numpy kmod
      ssh $RP passwd
    fi
    ssh $RP ". /etc/profile&&rw&&mount -o remount,rw /boot&&echo ok||echo failed"
    scp $S/boot/* $RP:/boot
  fi
  scp -r $S/bin $S/etc $S/lib $S/root $RP:/
  ssh $RP systemctl enable w7x_timing w7x_timing_fpga
fi
if [ "0$2" -gt "1" ]
then
  ssh $RP reboot
else
  ssh $RP systemctl stop  w7x_timing.service
  ssh $RP /bin/w7x_timing test
  ssh $RP systemctl start w7x_timing.service
  sleep 3
  $S/bin/w7x_timing_remote $1
fi
