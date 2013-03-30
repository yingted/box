#!/bin/bash
#usage: $0 sol test_path file_blocks wall_secs cpu_secs memory_kb vsize_kb
set -e
sol="$1"
test_path="$2"
lang="${test_path##*.}"
file_blocks="${3:-1}"
wall_secs="${4:-2}"
cpu_secs="${5:-1}"
memory_kb="${6:-$[256*1024]}"
vsize_kb="${7:-$[320*1024]}"
conf="/data${test_path%/*}/config"
ext=${1%.*}
[ -e "$conf" ] && . "$conf"
tconf="/data$(sed 's/\(.*\)\binput\b/\1config/' <<< "$test_path")"
[ -e "$tconf" ] && . "$tconf"
exec 2>&1
cd /tmp
compile_cpp() {
    deps="`cpp -MM solution.cpp | cut -d\  -f3-`";
    if [ -n "$deps" ]
    then
	echo "fatal error: unmet dependencies: $deps"
	echo "compilation terminated."
	exit 1
    fi

    g++ solution.cpp -o solution -O3 -Wall -Wunreachable-code -march=native -pipe
    /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_x86_64 -e __start --hash-style=gnu -dynamic-linker /usr/lib/ld-linux-x86-64.so.2 -o solution /build/crt1.o /usr/lib/crti.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/crtbegin.o -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/ -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. /build/box.o -L/build -lseccomp -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o solution.o
    strip solution
}
(
	set +e
	ulimit -d1024 -f"$file_blocks" -i10 -m"$memory_kb" -n10 -q0 -t"$cpu_secs" -v"$vsize_kb" -x0
	time -o score -f "wall=%e sys=%S usr=%U cpu=%P mmax=%M rssavg=%t mavg=%t pvt=%D ss=%p ts=%X maj=%F min=%R swp=%W iow=%w in=%I out=%O" timeout "$wall_secs" taskset 0x00000001 ./solution <"/data$test_path" >stdout 2>/dev/null
	echo $?
)
/build/score "/data$(sed 's/\(.*\)\binput\b/\1output/' <<< "$test_path")" stdout >>score
rm solution stdout
exec find tmp -mindepth 1 ! -name score -delete &>/dev/null
