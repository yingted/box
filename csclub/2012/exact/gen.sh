#!/bin/sh
for i in {1..3}
do
	for _ in $(seq $1)
	do
		js -e 'n=100;print("2\n"+n);while(n--)print(Math.random()*10000|0,Math.random()*10000|0)' | qhull QR0 QR$RANDOM QJ p | js -e 'readline();print(readline());try{while([x,y]=readline().split(" ").map(Number))print((x+.5)|0,(y+.5)|0)}catch(e){}'
	done | python -c "n=$1;"$'s=0\na=[]\nfor _ in xrange(n):\n\tm=input()\n\ts+=m+1\n\ta.append([raw_input()for _ in xrange(m)])\nprint s\nfor l in a:\n\tfor e in l:\n\t\tprint e\n\tprint l[0]' > input-$2.$i.txt
done
for i in {4..6}
do
	for _ in $(seq $1)
	do
		rbox $1 D2 z O1e4 B1e4 t$RANDOM | qhull QR0 QR$RANDOM QJ p | js -e 'readline();print(readline());try{while([x,y]=readline().split(" ").map(Number))print((x+.5)|0,(y+.5)|0)}catch(e){}'
	done | python -c "n=$1;"$'s=0\na=[]\nfor _ in xrange(n):\n\tm=input()\n\ts+=m+1\n\ta.append([raw_input()for _ in xrange(m)])\nprint s\nfor l in a:\n\tfor e in l:\n\t\tprint e\n\tprint l[0]' > input-$2.$i.txt
done
