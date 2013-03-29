drop:drop.c
	gcc drop.c -o drop -march=native -O3 -pipe -fstack-protector --param-ssp-buffer=4 -D_FORTIFY_SOURCE=2
	strip drop
score:score.cpp
	g++ score.cpp -o score -march=native -O3 -pipe -fstack-protector --param-ssp-buffer=4 -D_FORTIFY_SOURCE=2
	strip score
