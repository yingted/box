#!/bin/sh
set -e
g++ solution.cpp -c -g3
export PKG_CONFIG_PATH="`readlink -f libseccomp/lib/pkgconfig`"
export LD_LIBRARY_PATH="`readlink -f libseccomp-libseccomp/src/`"
#export COLLECT_GCC_OPTIONS="'-o' 'box' '-g3' '-shared-libgcc' '-mtune=generic' '-march=i686' `pkg-config --cflags --libs libseccomp`"
#COLLECT_GCC=g++ \
#COLLECT_LTO_WRAPPER=/usr/libexec/gcc/i686-redhat-linux/4.6.3/lto-wrapper \
/usr/libexec/gcc/i686-redhat-linux/4.6.3/cc1plus -quiet -D_GNU_SOURCE box.c -quiet -dumpbase box.c -mtune=generic -march=i686 -auxbase box -g3 -o box.s `pkg-config --cflags libseccomp`
as --32 -o box.o box.s
#COMPILER_PATH=/usr/libexec/gcc/i686-redhat-linux/4.6.3/:/usr/libexec/gcc/i686-redhat-linux/4.6.3/:/usr/libexec/gcc/i686-redhat-linux/:/usr/lib/gcc/i686-redhat-linux/4.6.3/:/usr/lib/gcc/i686-redhat-linux/ \
#LIBRARY_PATH=/usr/lib/gcc/i686-redhat-linux/4.6.3/:/usr/lib/gcc/i686-redhat-linux/4.6.3/../../../:/lib/:/usr/lib/ \
/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 -e __start --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o solution /home/ted/box/crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. -L/home/ted/box/libseccomp/lib box.o -lseccomp -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o /home/ted/box/solution.o
rm box.{o,s}
