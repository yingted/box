#!/bin/sh
#usage: $0 test_path file_blocks wall_secs cpu_secs memory_kb vsize_kb taskset
set -e
shopt -s failglob
test_path="$1"
file_blocks="${2:-1}"
wall_secs="${3:-2}"
cpu_secs="${4:-1}"
memory_kb="${5:-$[256*1024]}"
vsize_kb="${6:-$[320*1024]}"
taskset="${7:-1}"
[ -e "/data/config" ] && . "/data/config" #$test_path is never /
conf="/data${test_path%/*}/config"
[ -e "$conf" ] && . "$conf"
tconf="/data$(sed 's/\(.*\)\binput\b/\1config/' <<< "$test_path")"
[ -e "$tconf" ] && . "$tconf"
exec 2>&1
cd /tmp
sol=(solution.*)
case "${sol#*.}" in
	cpp)
		deps="`cpp -MM solution.cpp | cut -d\  -f3-`";
		if [ -n "$deps" ]
		then
			echo "fatal error: unmet dependencies: $deps"
			echo "compilation terminated."
			exit 1
		fi
		g++ solution.cpp -c -O3 -Wall -Wunreachable-code -march=native -pipe
		if [ -x /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/collect2 ]; then
			/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/collect2 --build-id --eh-frame-hdr --hash-style=gnu -m elf_x86_64 -e __start -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o solution /build/crt1.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/../../../../lib/crti.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/crtbegin.o -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2 -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/../../../../lib -L/lib/../lib -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/../../.. /build/box.o /build/libseccomp.a -L/build -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/crtend.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/../../../../lib/crtn.o solution.o
		else
			/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 -e __start --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o solution /build/crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. /build/box.o -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o solution.o
		fi
		rm solution.{cpp,o}
		strip solution
		run="./solution";;
	t)
		WINEPREFIX=/build/wineprefix xvfb-run -aw0 -s'-screen 0 1x1x8' wine /build/turing.exe -compile solution.t &>/dev/null
		rm solution.t
		run="/build/tprolog solution.tbc";;
	java)
		javac solution.java
		rm solution.java
		run="java -client -Djava.security.manager -Djava.security.policy=/build/java.policy solution";;
	py2)
		#python2 -SOO -mpy_compile solution.py2
		run="python2 -SOO /build/pybox.py2o solution.py2";;
	py3)
		#python3 -SOOc 'import py_compile;py_compile.compile("solution.py3","solution.py3o")'
		run="python3 -SOO /build/pybox.py3o solution.py3";;
esac
[ -n "$taskset" ] && taskset="taskset $taskset"
(
	set +e
	ulimit -d1024 -f"$file_blocks" -i5 -m"$memory_kb" -n11 -q0 -t"$cpu_secs" -v"$vsize_kb" -x0
	time -o score -f "wall=%e sys=%S usr=%U cpu=%P mmax=%M rssavg=%t mavg=%t pvt=%D ss=%p ts=%X maj=%F min=%R swp=%W iow=%w in=%I out=%O" $taskset timeout "$wall_secs" $run <"/data$test_path" >stdout 2>/dev/null
	echo $?
)
/build/score "/data$(sed 's/\(.*\)\binput\b/\1output/' <<< "$test_path")" stdout >>score
rm stdout
exec find -mindepth 1 ! -name score -delete &>/dev/null
