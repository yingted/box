#!/bin/sh
cd rootfs
bindm(){ mount -o "$3" --bind "$1" "$2"; mount -o "ro,remount,bind,$3" "$2"; }
for x in bin lib usr
do
	bindm "/$x" "$x"
done
bindm /home/ted/Documents/csclub data noexec
mount -t tmpfs tmpfs tmp -o rw,nosuid,seclabel,size=128m,nr_inodes=8
