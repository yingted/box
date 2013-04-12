.PHONY: all clean test
CFLAGS+=-march=native -O3 -pipe -fstack-protector --param ssp-buffer-size=4 -D_FORTIFY_SOURCE=2
export CFLAGS
#strip again
INSTALL=sudo install -o0
all:drop score tprolog box.o pysandbox-root pybox.py2o pybox.py3o luasandbox.luac ../config ../html/ace
	$(INSTALL) -sm555 drop score tprolog ../rootfs/build
	objcopy --redefine-sym main=_start --redefine-sym _start=__start ../rootfs/usr/lib/crt1.o crt1.o
	$(INSTALL) -m555 run.sh ../rootfs/build
	$(INSTALL) -m444 OpenTuring/turing/package/turing.exe crt1.o box.o pybox.py{2,3}o luasandbox.luac ../rootfs/build
	sudo cp -dr --no-preserve=ownership OpenTuring/turing/package/support pysandbox-root/lib/python2.7/site-packages/{sandbox,_sandbox.so} pysandbox-root/lib/python3.*/site-packages/_sandbox.cpython* ../rootfs/build/
	sudo chmod -R 444 ../rootfs/build/support
	sudo find ../rootfs/build/support -type d -exec chmod 555 {} +
	rm crt1.o
	{ [ -e /sys/fs/selinux/enforce ] && grep -Fxq 1 /sys/fs/selinux/enforce 2>/dev/null && chcon -vt httpd_unconfined_script_exec_t ../{server.py,nq.sh} && sudo chcon -Rt httpd_sys_rw_content_t ../code && chcon -vt httpd_sys_content_t ../config; }; :
clean:
	rm -rf drop score tprolog box.o crt1.o pybox.py{2,3}o pysandbox-root ../html/ace
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
luasandbox.luac:luasandbox.lua
	luac -o luasandbox.luac luasandbox.lua
../config:
	install config.sample ../config
../rootfs/build/wineprefix:
	sudo mkdir -p ../rootfs/build/wineprefix
	sudo chown 99:99 ../rootfs/build/wineprefix
	xhost +
	cd ..; sudo chroot rootfs sh -c 'mknod -m 644 /dev/random c 1 8 2>/dev/null; mknod -m 644 /dev/urandom c 1 9 2>/dev/null; cd /tmp; HOME=/tmp WINEPREFIX=/build/wineprefix DISPLAY=$(DISPLAY) wine /build/turing.exe -run "$$(winepath -w /dev/null)"'
	xhost -
ace/build/src-min:
	cd ace && npm install && ./Makefile.dryice.js --m normal
../html/ace:ace/build/src-min
	rm -rf ../html/ace
	mkdir -p ../html/ace
	cp ace/{demo/kitchen-sink/require,build/src-min/{ace,keybinding-{emacs,vim},worker-javascript,theme-*,mode-{c_cpp,java,javascript,python,lua,turing}}}.js ../html/ace/
	python2 -SOOc '\
		import json,subprocess;\
		print"ace.config.themes=",json.dumps([[label.lower(),subprocess.check_output(("sed","-n","/<optgroup label=\""+label+"\">/,/<\\/optgroup>/s:.*<option value=\"ace/theme/\\([^\"/]*\\)\"[^<>]*>.*:\\1:p","ace/kitchen-sink.html")).split()]for label in"Bright","Dark"],separators=(",",":"));\
	' >> ../html/ace/ace.js
test:urchin
	bash urchin test
