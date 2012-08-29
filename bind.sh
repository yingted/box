#!/bin/sh
cd rootfs
for x in bin lib usr
do
	mount -o ro --bind /$x $x
	mount -o ro,remount,bind $x
done
mount -t tmpfs tmpfs tmp -o rw,nosuid,seclabel,size=128m,nr_inodes=7
