#!/bin/bash
#usage: $0 test_path file_blocks wall_secs cpu_secs memory_kb vsize_kb
set -e
test_path="$1"
file_blocks="${2:-1}"
wall_secs="${3:-2}"
cpu_secs="${4:-1}"
memory_kb="${5:-$[256*1024]}"
vsize_kb="${6:-$[320*1024]}"
conf="/data${test_path%/*}/config"
ext=${1%.*}
[ -e "$conf" ] && . "$conf"
tconf="/data$(sed 's/\(.*\)\binput\b/\1config/' <<< "$test_path")"
[ -e "$tconf" ] && . "$tconf"
exec 2>&1
cd /tmp
compile_cpp() {
    deps="`cpp -MM solution.cpp | cut -d\  -f3-`";
    if [ -n "$deps" ]
    then
	echo "fatal error: unmet dependencies: $deps"
	echo "compilation terminated."
	exit 1
    fi

    g++ solution.cpp -c -O3 -Wall -Wunreachable-code -march=native -pipe
    #/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/collect2 --build-id --no-add-needed --eh-frame-hdr -m elf_x86_64 -e __start --hash-style=gnu -dynamic-linker /usr/lib/ld-linux-x86-64.so.2 -o solution /build/crt1.o /usr/lib/crti.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/crtbegin.o -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/ -L/usr/lib/gcc/i686-redhat-linux/4.6.3/../../.. /build/box.o -L/build -lseccomp -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/i686-redhat-linux/4.6.3/crtend.o /usr/lib/gcc/i686-redhat-linux/4.6.3/../../../crtn.o solution.o
     /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/collect2 --build-id --eh-frame-hdr --hash-style=gnu -m elf_x86_64 -e __start -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o solution /build/crt1.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/../../../../lib/crti.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/crtbegin.o -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2 -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/../../../../lib -L/lib/../lib -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/../../.. /build/box.o -L/build -lseccomp -lstdc++ -lm -lgcc_s -lgcc -lc -lgcc_s -lgcc /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/crtend.o /usr/lib/gcc/x86_64-unknown-linux-gnu/4.7.2/../../../../lib/crtn.o solution.o
    strip solution
}
compile_java() {
    javac solution.java
    cat > solution <<EOF
#!/bin/bash
java solution
EOF
}
compile_py2() {
    cat > solution <<EOF
#!/bin/bash
python2 -SOO solution.py2
EOF
}
compile_py3() {
    cat > solution <<EOF
#!/bin/bash
python3 -SOO solution.py3
EOF
}
fname=`ls -1 solution.*|head -1)`
lang=${fname##*.}
compile_$lang
chmod +x solution
(
    set +e
    ulimit -d1024 -f"$file_blocks" -i10 -m"$memory_kb" -n10 -q0 -t"$cpu_secs" -v"$vsize_kb" -x0
    time -o score -f "wall=%e sys=%S usr=%U cpu=%P mmax=%M rssavg=%t mavg=%t pvt=%D ss=%p ts=%X maj=%F min=%R swp=%W iow=%w in=%I out=%O" timeout "$wall_secs" taskset 0x00000001 ./solution <"/data$test_path" >stdout 2>/dev/null
    echo $?
)
/build/score "/data$(sed 's/\(.*\)\binput\b/\1output/' <<< "$test_path")" stdout >>score
rm solution stdout
exec find tmp -mindepth 1 ! -name score -delete &>/dev/null
