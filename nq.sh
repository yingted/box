#!/bin/sh
#usage: $0 user problem lang < file
set -e
. ./config "$2"
die(){
	echo 429 Too Many Requests
	exit
}
mkdir -p code
cd code
mkdir "$1" 2>&- || find "$1" -maxdepth 0 -type d -mmin -$wait_mins >&- 2>&- || die
trap '[ -d "$1/lock" ] && rmdir "$1/lock"' exit
mkdir "$1/lock" 2>&- || die
base="$1/`date +%s`"
mkdir "$base" 2>&- || die
cat > "$base/solution.$3"
echo "$2" > "$base/in"
echo 202 Accepted
echo -n "$base"
