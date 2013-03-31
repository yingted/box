.PHONY: all clean
CFLAGS=-march=native -O3 -pipe -fstack-protector --param ssp-buffer-size=4 -D_FORTIFY_SOURCE=2
export CFLAGS
#strip again
INSTALL=sudo install -o0
all:drop score tprolog box.o libseccomp
	$(INSTALL) -sm555 drop score tprolog ../rootfs/build
	objcopy --redefine-sym main=_start --redefine-sym _start=__start ../rootfs/usr/lib/crt1.o crt1.o
	$(INSTALL) -m555 run.sh ../rootfs/build
	$(INSTALL) -m444 ../OpenTuring/turing/package/turing.exe crt1.o box.o libseccomp-libseccomp/src/libseccomp.a ../rootfs/build
	sudo cp -dr --no-preserve=ownership ../OpenTuring/turing/package/support ../rootfs/build/
	sudo chmod -R 444 ../rootfs/build/support
	sudo find ../rootfs/build/support -type d -exec chmod 555 {} +
	rm crt1.o
	grep -Fxq 1 /sys/fs/selinux/enforce 2>/dev/null && chcon -vt httpd_unconfined_script_exec_t ../{server.py,nq.sh}
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
	g++ box.c -c -lseccomp -L. $(CFLAGS)
libseccomp:
	mkdir -p libseccomp
	[ -x /usr/lib/libseccomp.so.0 ] && mkdir libseccomp/lib && cp /usr/lib/libseccomp.so.0 libseccomp/lib/libseccomp.so.0.0.0 || (cd libseccomp-libseccomp && ./configure --prefix=`readlink -m ../libseccomp` --libdir=`readlink -m ../libseccomp/lib` && make && make install)
tprolog:
	make -kC ../OpenTuring/turing/src || :
	make -C ../OpenTuring/turing/src ../bin/tprolog
	cp ../OpenTuring/turing/bin/tprolog .
