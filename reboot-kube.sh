#!/bin/bash

root_pass="changeme"

for i in $(seq 171 176)
do

    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@192.168.1.$i reboot

done

