basic:basic-opt.cpp
	g++ -O3 -funroll-loops -fgcse -march=native basic-opt.cpp -pg -fprofile-generate -o basic-pg
	./basic-pg < input-huge.txt > /dev/null
	g++ -O3 -funroll-loops -fgcse -march=native basic-opt.cpp -fprofile-use -o basic
	rm gmon.out basic-opt.gcda basic-pg
