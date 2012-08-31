#!/bin/sh
#usage: $0 test file-blocks wall-secs cpu-secs memory-kb vsize-kb
set -e
exec 2>&1
cd /tmp
deps="`cpp -MM solution.cpp | cut -d\  -f3-`";
if [ -n "$deps" ]
then
	echo "fatal error: unmet dependencies: $deps"
	echo "compilation terminated."
	exit 1
fi
g++ solution.cpp -c -O3
/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 -e __start --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o solution /build/crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. /build/box.o -L/build -lseccomp -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o solution.o
rm solution.o
strip solution
(
	set +e
	ulimit -d1024 -f${2:-1} -i5 -m${5:-$[256*1024]} -n5 -q0 -t${4:-1} -v${6:-$[320*1024]} -x0
	exec &>out
	LD_LIBRARY_PATH=/build time timeout ${3:-1} ./solution <"/data$1" &>&3
	echo $?
) 3>&1 | /build/score "/data${1/input/output}" /dev/stdin >score
