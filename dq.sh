#!/bin/bash
next(){
	file="$(find html/code -mindepth 2 -maxdepth 2 -type d -exec ls -drt {} + | while IFS= read x; do
		[ ! -e "$x/out" -a -e "$x/in" -a ! -d "$x/../lock" ] && echo "$x";
	done | head -1)"
	[ -z "$file" ]
}
while :
do
	while next
	do
		inotifywait -qe modify -e delete html/code html/code/* > /dev/null
	done
	cp "$file/solution.cpp" rootfs/tmp
	sudo lxc-execute -n box -- /build/drop 99 /build/compile.sh "$(cat "$file/in")"
	#sudo chroot --userspec=99:99 rootfs /build/compile.sh "$(cat "$file/in")"
	rm rootfs/tmp/solution.cpp
done
