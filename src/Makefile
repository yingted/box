.PHONY: all clean
CFLAGS+=-march=native -O3 -pipe -fstack-protector --param ssp-buffer-size=4 -D_FORTIFY_SOURCE=2
export CFLAGS
#strip again
INSTALL=sudo install -o0
all:drop score tprolog box.o pysandbox-root pybox.py2o pybox.py3o ../config
	$(INSTALL) -sm555 drop score tprolog ../rootfs/build
	objcopy --redefine-sym main=_start --redefine-sym _start=__start ../rootfs/usr/lib/crt1.o crt1.o
	$(INSTALL) -m555 run.sh ../rootfs/build
	$(INSTALL) -m444 OpenTuring/turing/package/turing.exe crt1.o box.o pybox.py{2,3}o ../rootfs/build
	sudo cp -dr --no-preserve=ownership OpenTuring/turing/package/support pysandbox-root/lib/python2.7/site-packages/{sandbox,_sandbox.so} pysandbox-root/lib/python3.*/site-packages/_sandbox.cpython* ../rootfs/build/
	sudo chmod -R 444 ../rootfs/build/support
	sudo find ../rootfs/build/support -type d -exec chmod 555 {} +
	rm crt1.o
	[ -e /sys/fs/selinux/enforce ] && grep -Fxq 1 /sys/fs/selinux/enforce 2>/dev/null && chcon -vt httpd_unconfined_script_exec_t ../{server.py,nq.sh} && sudo chcon -Rvt httpd_sys_rw_content_t ../code && chcon -vt httpd_unconfined_script_exec_t ../server.py
clean:
	rm -rf drop score tprolog box.o crt1.o pybox.py{2,3}o pysandbox-root
drop:drop.c
	gcc drop.c -o drop $(CFLAGS)
	strip drop
score:score.cpp
	g++ score.cpp -o score $(CFLAGS)
	strip score
box.o:box.c
	g++ box.c -lseccomp -c $(CFLAGS)
tprolog:
	make -kC OpenTuring/turing/src || :
	make -C OpenTuring/turing/src ../bin/tprolog
	cp OpenTuring/turing/bin/tprolog .
pysandbox-root:
	cd pysandbox && python2 setup.py install --prefix=../pysandbox-root
	cd pysandbox && python3.2 setup.py install --prefix=../pysandbox-root
pybox.py2o:pybox.py
	python2 -SOO -mpy_compile pybox.py
	mv pybox.py{,2}o
pybox.py3o:pybox.py
	python3.2 -SOOc 'import py_compile;py_compile.compile("pybox.py","pybox.py3o")'
../config:
	install config.sample ../config
../rootfs/build/wineprefix:
	sudo mkdir -p ../rootfs/build/wineprefix
	sudo chown 99:99 ../rootfs/build/wineprefix
	xhost +
	cd ..; sudo chroot rootfs sh -c 'mknod -m 644 /dev/random c 1 8 2>/dev/null; mknod -m 644 /dev/urandom c 1 9 2>/dev/null; cd /tmp; HOME=/tmp WINEPREFIX=/build/wineprefix DISPLAY=$(DISPLAY) wine /build/turing.exe -run "$$(winepath -w /dev/null)"'
	xhost -
