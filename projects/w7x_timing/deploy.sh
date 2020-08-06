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
    if [ "0$2" -ge "3" ] && [ "$RPp" != "$RP" ]
    then
      echo default password is 'root'
      ssh-copy-id $RP
      # scp -r $S/.ssh ${RP}:/root/.ssh
      ssh $RP apt-get update
      ssh $RP apt-get -y install python-numpy kmod
      ssh $RP passwd
    fi
    ssh $RP ". /etc/profile&&rw&&mount -o remount,rw /boot&&echo ok||echo failed"
    module_path=/lib/modules/${KVER}-xilinx
    ssh $RP mkdir -p ${module_path}
    scp $S/../usermem/devicetree.dtb $S/../../uImage $RP:/boot/
    scp $S/../usermem/linux/usermem.ko $RP:${module_path}
    ssh $RP /bin/bash -c 'echo usermem.ko > /etc/modules-load.d/usermem.conf;depmod -a'
  fi
  scp -r $S/rp/* $RP:/
  scp $S/out/lib*.so $RP:/lib/
  scp $S/out/rptrig.bit $RP:/root/
  ssh $RP "systemctl disable rptrig;systemctl enable rptrig"
fi

if [ "0$2" -ge "2" ]
then
  ssh $RP "sync;sync;reboot"
else
  ssh $RP /bin/rptrig test
  sleep 3
  $S/rp/bin/rptrig_remote $1
fi
