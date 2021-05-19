#!/bin/bash
set -e
S=$(realpath $(dirname ${0}))

RP="$(echo root@$1 | awk '{split($0,a,":"); print a[1]}')"



if [ "0$2" -ge "1" ]
then
  scp -r $S/fs/* $RP:/
  scp $S/out/lib*.so $RP:/lib/
  ssh $RP /bin/mount -o remount,rw /boot
  scp $S/out/fpga_rptrig.bit $RP:/boot/fpga/
  ssh $RP "systemctl disable rptrig;systemctl enable rptrig"
  ../usermem/deploy.sh "$@"
fi

ssh $RP /bin/rptrig-local test
sleep 3
$S/fs/bin/rptrig-remote $1
