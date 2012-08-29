#!/bin/sh
#usage: $0 file-blocks wall-secs cpu-secs memory-kb vsize-kb
set -e
objcopy --redefine-sym main=_start --redefine-sym _start=__start /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crt1.o crt1.o
g++ solution.cpp -c -O3
export PKG_CONFIG_PATH="`readlink -f libseccomp/lib/pkgconfig`"
export LD_LIBRARY_PATH="`readlink -f libseccomp-libseccomp/src/`"
/usr/libexec/gcc/i686-redhat-linux/4.6.3/cc1plus -quiet -D_GNU_SOURCE box.c -quiet -dumpbase box.c -mtune=generic -march=i686 -auxbase box -O3 -o box.s `pkg-config --cflags libseccomp`
as --32 -o box.o box.s
/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 -e __start --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o solution /home/ted/box/crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. -L/home/ted/box/libseccomp/lib box.o -lseccomp -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o /home/ted/box/solution.o
rm crt1.o box.{o,s} solution.o
ulimit -d1024 -f${1:-1} -i5 -m${4:-$[256*1024]} -n4 -q0 -t${3:-1} -v${5:-$[320*1024]} -x0
set +e
time timeout ${2:-1} ./solution
echo $?
