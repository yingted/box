#!/bin/sh
if false
then
	pushd libseccomp-libseccomp
	./configure --prefix=`readlink -f ../libseccomp` --libdir=`readlink -f ../libseccomp/lib`
	make
	make install
	popd
fi
set -e
export PKG_CONFIG_PATH="`readlink -f libseccomp/lib/pkgconfig`"
export LD_LIBRARY_PATH="`readlink -f libseccomp-libseccomp/src/`"
g++ box.c -o box `pkg-config --cflags --libs libseccomp` #-static -O0 -g
