.PHONY: all clean
CFLAGS=-march=native -O3 -pipe -fstack-protector --param ssp-buffer-size=4 -D_FORTIFY_SOURCE=2
export CFLAGS
#strip again
INSTALL=sudo install -o0
all:drop score tprolog box.o
	$(INSTALL) -sm555 drop score tprolog ../rootfs/build
	$(INSTALL) -m555 run.sh ../rootfs/build
	objcopy --redefine-sym main=_start --redefine-sym _start=__start /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crt1.o crt1.o
	$(INSTALL) -m444 crt1.o box.o ../rootfs/build
	rm crt1.o
	$(INSTALL) -m555 -T libseccomp/lib/libseccomp.so.0.0.0 ../rootfs/build/libseccomp.so.0
	chcon -vt httpd_unconfined_script_exec_t ../{server.py,nq.sh}
clean:
	rm -f drop score tprolog box.o crt1.o
	make -C libseccomp-libseccomp clean
	rm -rf libseccomp
drop:drop.c
	gcc drop.c -o drop $(CFLAGS)
	strip drop
score:score.cpp
	g++ score.cpp -o score $(CFLAGS)
	strip score
box.o:box.c libseccomp
	g++ box.c -c `PKG_CONFIG_PATH=libseccomp/lib/pkgconfig pkg-config --cflags --libs libseccomp` -L. $(CFLAGS)
libseccomp:
	mkdir -p libseccomp
	cd libseccomp-libseccomp && ./configure --prefix=`readlink -m ../libseccomp` --libdir=`readlink -m ../libseccomp/lib` && make && make install
tprolog:
	make -C ../OpenTuring/turing/src ../bin/tprolog
	cp ../OpenTuring/turing/bin/tprolog .
