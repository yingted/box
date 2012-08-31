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
		mkdir -p html/code
		find html/code -maxdepth 1 -type d -exec inotifywait -qe modify -e delete -e delete_self -t1 {} + > /dev/null
	done
	sudo find rootfs/tmp -mindepth 1 -delete
	cp "$file/solution.cpp" rootfs/tmp
	sudo lxc-execute -n box -- /build/drop 99 /build/compile.sh "$(cat "$file/in")" > "$file/out"
	#sudo chroot --userspec=99:99 rootfs /build/compile.sh "$(cat "$file/in")" > "$file/out"
	rm rootfs/tmp/solution.cpp
	mv rootfs/tmp/score "$file"
	sudo find rootfs/tmp -mindepth 1 -delete
done
