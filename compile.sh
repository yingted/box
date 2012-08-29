#!/bin/sh
set -e
file=${1:-solution}
ext=${1:-cpp}
export COLLECT_GCC_OPTIONS="'-o' '$file' '-O3' '-shared-libgcc' '-mtune=generic' '-march=i686'"
COLLECT_GCC=g++ \
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/i686-redhat-linux/4.6.3/lto-wrapper \
/usr/libexec/gcc/i686-redhat-linux/4.6.3/cc1plus -quiet -D_GNU_SOURCE $file.$ext -quiet -dumpbase $file.$ext -mtune=generic -march=i686 -auxbase $file -O3 -o $file.s
as --32 -o $file.o $file.s
COMPILER_PATH=/usr/libexec/gcc/i686-redhat-linux/4.6.3/:/usr/libexec/gcc/i686-redhat-linux/4.6.3/:/usr/libexec/gcc/i686-redhat-linux/:/usr/lib/gcc/i686-redhat-linux/4.6.3/:/usr/lib/gcc/i686-redhat-linux/ \
LIBRARY_PATH=/usr/lib/gcc/i686-redhat-linux/4.6.3/:/usr/lib/gcc/i686-redhat-linux/4.6.3/../../../:/lib/:/usr/lib/ \
/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o $file /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. $file.o -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o
