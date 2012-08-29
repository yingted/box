#!/bin/sh
#usage: $0 file-blocks wall-secs cpu-secs memory-kb vsize-kb
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
rm solution.cpp
/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 -e __start --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o solution /build/crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. /build/box.o -L/build -lseccomp -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o solution.o
rm solution.o
strip solution
exec 2>/dev/null
ulimit -d1024 -f${1:-1} -i5 -m${4:-$[256*1024]} -n4 -q0 -t${3:-1} -v${5:-$[320*1024]} -x0
set +e
LD_LIBRARY_PATH=/build time timeout ${2:-1} ./solution
echo $?
