#!/bin/sh
#usage: $0 user problem lang < file
set -e
wait_mins=1
[ -e rootfs/data/config ] && . rootfs/data/config
conf="rootfs/data${2%/*}/config"
[ -e "$conf" ] && . "$conf"
tconf="rootfs/data$(sed 's/\(.*\)\binput\b/\1config/' <<< "$2")"
[ -e "$tconf" ] && . "$tconf"
die(){
	echo "429 $1"
	exit
}
mkdir -p code
cd code
mkdir "$1" 2>&- || find "$1" -maxdepth 0 -type d -mmin -$wait_mins >&- 2>&- || die
trap '[ -d "$1/lock" ] && rmdir "$1/lock"' exit
mkdir "$1/lock" 2>&- || die "AV"
base="$1/`date +%s`"
mkdir "$base" 2>&- || die "Enko"
cat > "$base/solution.$3"
echo "$2" > "$base/in"
echo 202 Accepted
echo -n "$base"
