#!/bin/bash
next(){
	mkdir -p code
	file="$(find code -mindepth 2 -maxdepth 2 -type d ! -name lock -exec ls -drt {} + | while IFS= read x; do
		[ ! -e "$x/out" -a -e "$x/in" -a ! -d "$x/../lock" ] && echo "$x";
	done | head -1)"
	[ -z "$file" ]
}
while :
do
	while next
	do
		find code -maxdepth 1 -type d -exec inotifywait -qe modify -e delete -e delete_self -t1 {} + > /dev/null
	done
	echo testing "$file"
	sudo find rootfs/tmp -mindepth 1 -delete
	cp "$file/solution.cpp" rootfs/tmp
	sudo lxc-execute -n box -- /build/drop 99 /build/compile.sh "$(cat "$file/in")" > "$file/out"
	#sudo chroot --userspec=99:99 rootfs /build/compile.sh "$(cat "$file/in")" > "$file/out"
	rm rootfs/tmp/solution.cpp
	cp rootfs/tmp/score "$file/score.part" 2> /dev/null && mv "$file/score.part" "$file/score" || { >> "$file/score"; rm -f "$file/score.part"; }
	sudo find rootfs/tmp -mindepth 1 -delete
	tail -1 "$file/score"
done
