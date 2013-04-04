#!/bin/sh
cd rootfs
bindm(){ mount --bind "/$1" "$1"; mount -o "ro,remount,bind,$3" "$2"; }
for x in bin lib usr
do
	bindm "$x"
done
mount -t tmpfs tmpfs tmp -o rw,nosuid,seclabel,size=128m,nr_inodes=8
