#!/bin/bash
[ "$0" != "./grader.sh" ] && echo "usage: cd $(dirname "$0"); ./grader.sh" && exit 1
. config || { echo "config error" >&2; exit 1; }
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
	test_path="$(cat "$file/in")"
	. ./config "$test_path" > rootfs/tmp/config
	(
		. rootfs/tmp/config
		sln=("$file/solution."*)
		sudo install -o99 "$sln" rootfs/tmp
		sln="${sln##*/}"
		IFS=$'\t' eval curwrap=(${wrap[${sln#*.}]})
		sudo rm -f rootfs/data/{in,judge} #just in case
		sudo ln "$data_dir$test_path" rootfs/data/in
		sudo chmod o+r-w rootfs/data/in #safe, assuming 99 is not in the user or group
		[ -n "$interactive" ] && sudo ln "$data_dir${test_path%/*}/$judge_file" rootfs/data/judge && sudo chmod o+rx-w rootfs/data/judge
		sudo chown 99:99 rootfs/tmp/config
		sudo lxc-execute -n box -- "${curwrap[@]}" /build/drop 99 /build/run.sh > "$file/out"
		#sudo chroot rootfs "${curwrap[@]}" /build/drop 99 /build/run.sh "$(cat "$file/in")" > "$file/out"
		{ cat rootfs/tmp/score 2>/dev/null && touch rootfs/tmp/stdout && "${score_cmd[@]}" "$data_dir$(sed 's/\(.*\)\binput\b/\1output/' <<< "$test_path")" rootfs/tmp/stdout; } > "$file/score.part" && mv "$file/score.part" "$file/score" || { >> "$file/score"; rm -f "$file/score.part"; }
	)
	rm -f rootfs/tmp/{stdout,score,solution.*} 2> /dev/null
	sudo find rootfs/{tmp,data} -mindepth 1 -delete
	tail -1 "$file/score"
done
