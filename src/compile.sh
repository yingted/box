#!/bin/sh
#usage: $0 test_path file_blocks wall_secs cpu_secs memory_kb vsize_kb
set -e
test_path="$1";
file_blocks="${2:-1}"
wall_secs="${3:-2}"
cpu_secs="${4:-1}"
memory_kb="${5:-$[256*1024]}"
vsize_kb="${6:-$[320*1024]}"
conf="/data${test_path%/*}/config"
[ -e "$conf" ] && . "$conf"
tconf="/data$(sed 's/\(.*\)\binput\b/\1config/' <<< "$test_path")"
[ -e "$tconf" ] && . "$tconf"
exec 2>&1
cd /tmp
deps="`cpp -MM solution.cpp | cut -d\  -f3-`";
if [ -n "$deps" ]
then
	echo "fatal error: unmet dependencies: $deps"
	echo "compilation terminated."
	exit 1
fi
g++ solution.cpp -c -O3 -Wall -Wunreachable-code -pipe
/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 -e __start --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o solution /build/crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. /build/box.o -L/build -lseccomp -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o solution.o
rm solution.o
strip solution
(
	set +e
	ulimit -d1024 -f"$file_blocks" -i5 -m"$memory_kb" -n5 -q0 -t"$cpu_secs" -v"$vsize_kb" -x0
	LD_LIBRARY_PATH=/build time -o score -f "wall=%e sys=%S usr=%U cpu=%P mmax=%M rssavg=%t mavg=%t pvt=%D ss=%p ts=%X maj=%F min=%R swp=%W iow=%w in=%I out=%O" timeout "$wall_secs" ./solution <"/data$test_path" >stdout 2>/dev/null
	echo $?
)
/build/score "/data$(sed 's/\(.*\)\binput\b/\1output/' <<< "$test_path")" stdout >>score
rm solution stdout
exec find tmp -mindepth 1 ! -name score -delete &>/dev/null
