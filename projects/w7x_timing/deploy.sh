#!/bin/bash
set -e
S=$(realpath $(dirname ${0}))

RPp="root@$1"
RP="$(echo $RPp | awk '{split($0,a,":"); print a[1]}')"
if [ "$RPp" = "$RP" ]
then RPp=$RP:
fi

if [ "0$2" -ge "1" ]
then
  if [ "0$2" -ge "2" ]
  then
    if [ "0$2" -ge "3" ] && [ ! "$RPp" -eq "$RP" ]
    then
      echo default password is 'root'
      ssh-copy-id $RP
      # scp -r $S/.ssh ${RP}:/root/.ssh
      ssh $RP apt-get update
      ssh $RP apt-get -y install python-numpy kmod
      ssh $RP passwd
    fi
    if [ "$RPp" != "$RP" ]
    then ssh $RP ". /etc/profile&&rw&&mount -o remount,rw /boot&&echo ok||echo failed"
    fi
    scp $S/../user512/devicetree.dtb $S/../../uImage $RPp/boot/
    scp $S/../user512/linux/user512.ko $RPp/root/
  fi
  scp -r $S/rp/* $RPp/
  scp $S/out/lib*.so $RPp/lib/
  scp $S/out/rptrig.bit $RPp/root/
  if [ "$RPp" = "$RP" ]
  then
    ssh $RP systemctl disable rptrig rptrig_fpga
    ssh $RP systemctl enable rptrig rptrig_fpga
  fi
fi

if [ "$RPp" = "$RP" ]
then
  if [ "0$2" -ge "2" ]
  then
    ssh $RP reboot
  else
    ssh $RP systemctl stop rptrig
    ssh $RP /bin/rptrig test
    ssh $RP systemctl start rptrig
    sleep 3
    $S/rp/bin/rptrig_remote $1
  fi
fi
