#!/bin/sh
set -e
S=$(realpath $(dirname ${0}))

RPp="root@$1"
RP="$(echo $RPp | awk '{split($0,a,":"); print a[1]}')"
if [ "$RPp" -eq "$RP" ]
then RPp=$RP:
fi

if [ "0$2" -gt "0" ]
then
  if [ "0$2" -gt "1" ]
  then
    if [ "$2" -gt "2" ] && [ ! "$RPp" -eq "$RP" ]
    then
      echo default password is 'root'
      ssh-copy-id $RP
      # scp -r $S/.ssh ${RP}:/root/.ssh
      ssh $RP apt-get update
      ssh $RP apt-get -y install python-numpy kmod
      ssh $RP passwd
    fi
    if [ "$RPp" -eq "$RP" ]
    then ssh $RP ". /etc/profile&&rw&&mount -o remount,rw /boot&&echo ok||echo failed"
    fi
    scp $S/logic/sdk/dts/devicetree.dtb $S/../../uImage $RPp/boot
  fi
  scp -r $S/rp/* $RPp/
  scp $S/src/libw7x_timing_lib.so $RPp/lib
  scp $S/logic/out/red_pitaya.bit $S/src/w7x_timing.ko $RPp/root
  if [ "$RPp" -eq "$RP" ]
  then
    ssh $RP systemctl enable w7x_timing w7x_timing_fpga
    ssh $RP systemctl enable w7x_timing w7x_timing_fpga
  fi
fi

if [ "$RPp" -eq "$RP" ]
then
  if [ "0$2" -gt "1" ]
  then
    ssh $RP reboot
  else
    ssh $RP systemctl stop  w7x_timing.service
    ssh $RP /bin/w7x_timing test
    ssh $RP systemctl start w7x_timing.service
    sleep 3
    $S/rp/bin/w7x_timing_remote $1
  fi
fi
