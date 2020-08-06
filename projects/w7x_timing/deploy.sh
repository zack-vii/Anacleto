#!/bin/bash
set -e
S=$(realpath $(dirname ${0}))

RP="$(echo root@$1 | awk '{split($0,a,":"); print a[1]}')"

if [ "0$2" -ge "1" ]
then
  scp -r $S/fs/* $RP:/
  scp $S/out/lib*.so $RP:/lib/
  scp $S/out/rptrig.bit $RP:/root/
  ssh $RP "systemctl disable rptrig;systemctl enable rptrig"
  ../usermem/deploy.sh "$@"
fi

ssh $RP /bin/rptrig test
sleep 3
$S/fs/bin/rptrig_remote $1
