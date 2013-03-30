.PHONY: all
CFLAGS=-march=native -O3 -pipe -fstack-protector --param ssp-buffer-size=4 -D_FORTIFY_SOURCE=2
export CFLAGS
#strip again
INSTALL=sudo install -o0
all:drop score tprolog box.o
	$(INSTALL) -sm555 drop score tprolog ../rootfs/build
	$(INSTALL) -m555 compile.sh ../rootfs/build
	objcopy --redefine-sym main=_start --redefine-sym _start=__start /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crt1.o crt1.o
	$(INSTALL) -m444 crt1.o box.o ../rootfs/build
	rm crt1.o
	$(INSTALL) -m555 -T ../rootfs/build/libseccomp.so.0 libseccomp/lib/libseccomp.so.0.0.0
drop:drop.c
	gcc drop.c -o drop $(CFLAGS)
	strip drop
score:score.cpp
	g++ score.cpp -o score $(CFLAGS)
	strip score
box.o:box.c libseccomp/include/seccomp.h
	g++ box.c -c `PKG_CONFIG_PATH=libseccomp/lib/pkgconfig pkg-config --cflags --libs libseccomp` -L. $(CFLAGS)
libseccomp/include/seccomp.h:
	cd libseccomp-libseccomp && ./configure --prefix=`readlink -f ../libseccomp` --libdir=`readlink -f ../libseccomp/lib` && make && make install
tprolog:
	make -C ../OpenTuring/turing/src ../bin/tprolog
	cp ../OpenTuring/turing/bin/tprolog .
