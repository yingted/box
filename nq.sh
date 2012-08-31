#!/bin/sh
#usage: $0 ip problem < file
set -e
die(){
	echo 429 Too Many Requests
	exit
}
mkdir -p html/code
cd html/code
mkdir "$1" || find "$1" -maxdepth 0 -type d -mmin -1 >&- 2>&- || die
mkdir "$1/lock" || die
trap "rmdir $1/lock" exit
base="$1/`date +%s`"
mkdir "$base" 2>&- || die
echo "$3" > "$base/in"
cat > "$base/solution.cpp"
echo 202 Accepted
echo -n "$base"
