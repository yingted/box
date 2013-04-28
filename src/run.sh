#!/bin/sh
set -e
shopt -s failglob
test_path="/data/in"
. /tmp/config
rm /tmp/config
exec 2>&1
cd /tmp
sol=(solution.*)
(
set -e
ulimit "${compile_ulimit_args[@]}"
case "${sol#*.}" in
	cpp*)
		deps="`cpp -MM $sol | cut -d\  -f3-`";
		if [ -n "$deps" ]
		then
			echo "fatal error: unmet dependencies: $deps"
			echo "compilation terminated."
			exit 1
		fi
		if [ "${sol#*.}" = "cpp11" ]; then
			mv solution.cpp{11,}
			g++ solution.cpp -c -std=gnu++11 -O3 -Wall -Wunreachable-code -march=native -pipe
		else
			g++ solution.cpp -c -O3 -Wall -Wunreachable-code -march=native -pipe
		fi
		if [ -x /usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0/collect2 ]; then
			PATH=/usr/bin /usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0/collect2 --build-id --eh-frame-hdr --hash-style=gnu -m elf_x86_64 -e __start -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o solution /build/crt1.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0/../../../../lib/crti.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0/crtbegin.o -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0 -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0/../../../../lib -L/lib/../lib -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0/../../.. /build/box.o -L/build -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc -lseccomp /usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0/crtend.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.0/../../../../lib/crtn.o solution.o
		else
			/usr/libexec/gcc/i686-redhat-linux/4.6.3/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_i386 -e __start --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 -o solution /build/crt1.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crti.o /usr/lib/gcc/i686-redhat-linux/4.6.3/crtbegin.o -L/usr/lib/gcc/i686-redhat-linux/4.6.3 -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. /build/box.o -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc -lseccomp /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o solution.o
		fi
		rm solution.{cpp,o}
		strip solution
		echo 'run=(./solution)' > run_cmd;;
	t)
		WINEPREFIX=/build/wineprefix xvfb-run -aw0 -s'-screen 0 1x1x8' wine /build/turing.exe -compile solution.t &>/dev/null
		ret="$?"
		rm solution.t
		if [ "$(head -c8 solution.tbc | xxd -p)" = 4552524f52000d0a ]
		then
			tail -n+2 solution.tbc | dos2unix | sed -n 's/^Line \([0-9]\+\) \[\([0-9]\+\) - \([0-9]\+\)\] of ([^()]*):/\1 \2 \3/p'
			echo
			rm solution.tbc
			exit "$?"
		else
			echo 'run=(/build/tprolog solution.tbc)' > run_cmd
		fi;;
	java)
		javac -Xlint -O solution.java
		rm solution.java
	echo 'run=(java -client -Djava.security.manager -Djava.security.policy=/build/java.policy Solution)' > run_cmd;;
	js)
		echo 'run=(/usr/bin/js -e "delete load;delete read;delete run;delete snarf" solution.js)' > run_cmd;;
	py2)
		#python2 -SOO -mpy_compile solution.py2
		echo 'run=(python2 -SOO /build/pybox.py2o solution.py2)' > run_cmd;;
	py3)
		#python3.2 -SOOc 'import py_compile;py_compile.compile("solution.py3","solution.py3o")'
		echo 'run=(python3.2 -SOO /build/pybox.py3o solution.py3)' > run_cmd;;
esac
)
[ -n "$taskset" ] && taskset="taskset $taskset"
(
	set +e
	. ./run_cmd
	rm run_cmd
	if [ -x /data/judge ]; then
		mkfifo fifo
		ulimit "${ulimit_args[@]}"
		/data/judge "$test_path" <fifo 2>stdout | 'time' -o score -f "wall=%e sys=%S usr=%U cpu=%P mmax=%M rssavg=%t mavg=%t pvt=%D ss=%p ts=%X maj=%F min=%R swp=%W iow=%w in=%I out=%O" $taskset timeout "$wall_secs" "${run[@]}" >fifo 2>/dev/null
		echo $?
		rm -f fifo
	else
		ulimit "${ulimit_args[@]}"
		'time' -o score -f "wall=%e sys=%S usr=%U cpu=%P mmax=%M rssavg=%t mavg=%t pvt=%D ss=%p ts=%X maj=%F min=%R swp=%W iow=%w in=%I out=%O" $taskset timeout "$wall_secs" "${run[@]}" <"$test_path" >stdout
		echo $?
	fi
)
#/build/score "/data$(sed 's/\(.*\)\binput\b/\1output/' <<< "$test_path")" stdout >>score
#rm stdout
exec find -mindepth 1 ! \( -name stdout -or -name score \) -delete &>/dev/null
