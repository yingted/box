#!/bin/sh
set -e
export COLLECT_GCC_OPTIONS="'-o' 'solution' '-O3' '-shared-libgcc' '-mtune=generic' '-march=i686'"
COLLECT_GCC=g++ \
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/i686-redhat-linux/4.6.3/lto-wrapper \
/usr/libexec/gcc/i686-redhat-linux/4.6.3/cc1plus -quiet -D_GNU_SOURCE solution.cpp -quiet -dumpbase solution.cpp -mtune=generic -march=i686 -auxbase solution -O3 -o solution.s
as --32 -o solution.o solution.s
COMPILER_PATH=/usr/libexec/gcc/i686-redhat-linux/4.6.3/:/usr/libexec/gcc/i686-redhat-linux/4.6.3/:/usr/libexec/gcc/i686-redhat-linux/:/usr/lib/gcc/i686-redhat-linux/4.6.3/:/usr/lib/gcc/i686-redhat-linux/ \
LIBRARY_PATH=/usr/lib/gcc/i686-redhat-linux/4.6.3/:/usr/lib/gcc/i686-redhat-linux/4.6.3/../../../:/lib/:/usr/lib/ \
/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o solution /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. solution.o -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o
