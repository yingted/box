#!/bin/bash
[ "$0" != "./grader.sh" ] && echo "usage: cd $(dirname "$0"); ./grader.sh" && exit 1
shopt -s nullglob
ip r s dev eth0 | sed -n 's/.*src \([^ ]*\).*/ip: \1 = /p' | tr -d \\n
bc -l <<< $(ip r s dev eth0 | sed -n 's/.*src \([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\).*/((\1*256+\2)*256+\3)*256+\4/p')
next(){
	mkdir -p code
	file="$(find code -mindepth 2 -maxdepth 2 -type d ! -name lock -exec ls -drt {} + | while IFS= read x; do
		[ ! -e "$x/out" -a -e "$x/in" -a ! -d "$x/../lock" ] && echo "$x";
	done | head -1)"
	[ -z "$file" ]
}
declare -A wrap
wrap=([t]="sh	-c	'"'mknod -m 644 /dev/random c 1 8 2>/dev/null; mknod -m 644 /dev/urandom c 1 9 2>/dev/null; exec "$0" "$@"'"'")
wrap[py]="${wrap[t]}"
while :
do
	while next
	do
		find code -maxdepth 1 -type d -exec inotifywait -qe modify -e delete -e delete_self -t1 {} + > /dev/null
	done
	echo testing "$file"
	sudo find rootfs/tmp -mindepth 1 -delete
	sln=("$file/solution."*)
	sudo install -o99 "$sln" rootfs/tmp
	sln="${sln##*/}"
	IFS=$'\t' eval curwrap=(${wrap[${sln#*.}]})
	curwrap=(sh -c 'mknod -m 644 /dev/random c 1 8 2>/dev/null; mknod -m 644 /dev/urandom c 1 9 2>/dev/null; exec "$0" "$@"')
	test_path="$(cat "$file/in")"
	sudo ln "$data_dir$test_path" rootfs/data/in
	cat config "$data_dir${test_path%/*}/config" "$data_dir$(sed 's/\(.*\)\binput\b/\1config/' <<< "$test_path")" > rootfs/tmp/config 2> /dev/null
	sudo lxc-execute -n box -- "${curwrap[@]}" /build/drop 99 /build/run.sh > "$file/out"
	#sudo chroot rootfs "${curwrap[@]}" /build/drop 99 /build/run.sh "$(cat "$file/in")" > "$file/out"
	rootfs/build/score "data$(sed 's/\(.*\)\binput\b/\1output/' <<< "$test_path")" rootfs/tmp/stdout >> rootfs/tmp/score
	rm -f rootfs/tmp/solution.* rootfs/tmp/stdout rootfs/data/in 2> /dev/null
	cp rootfs/tmp/score "$file/score.part" 2> /dev/null && mv "$file/score.part" "$file/score" || { >> "$file/score"; rm -f "$file/score.part"; }
	sudo find rootfs/tmp -mindepth 1 -delete
	tail -1 "$file/score"
done
