Installation on a fresh original RedPitaya Image:
ssh-copy-id root@RP-F0432C # password is root
ssh root@RP-F0432C /usr/bin/passwd
ssh root@RP-F0432C apt-get update
ssh root@RP-F0432C apt-get -y install python-numpy kmod
ssh root@RP-F0432C apt-get clean
./deploy RP-F0432C 1
