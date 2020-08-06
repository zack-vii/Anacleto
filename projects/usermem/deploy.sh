#!/bin/bash
set -e
S=$(realpath $(dirname ${0}))
KVER=${3:-4.9.0}
echo $KVER
RP="$(echo root@$1 | awk '{split($0,a,":"); print a[1]}')"

if [ "0$2" -ge "1" ]
then
  if [ "0$2" -ge "2" ]
  then
    if [ "0$2" -ge "3" ]
    then
      echo default password is 'root'
      ssh-copy-id $RP
      # scp -r $S/.ssh ${RP}:/root/.ssh
      ssh $RP apt-get update
      ssh $RP apt-get -y install python-numpy kmod
      ssh $RP passwd
    fi
    ssh $RP ". /etc/profile&&rw&&mount -o remount,rw /boot&&echo ok||echo failed"
    ssh $RP /bin/mount -o remount,rw /boot
    scp $S/devicetree.dtb $S/../../uImage $RP:/boot/
    module_path=/lib/modules/${KVER}-xilinx
    ssh $RP mkdir -p ${module_path}
    scp $S/linux/usermem.ko $RP:${module_path}
    scp -r $S/fs/* $RP:/
    ssh $RP depmod -a
  fi
fi

if [ "0$2" -ge "2" ]
then
  ssh $RP "sync;sync;reboot"
fi
