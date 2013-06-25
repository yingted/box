all:output-single.txt output-small.txt output-medium.txt output-large.txt
input-small.txt:gen.py
	./gen.py 15 3 > $@
input-medium.txt:gen.py
	./gen.py 20 7 > $@
input-large.txt:gen.py
	./gen.py 30 10 > $@
output-%.txt:input-%.txt
	time ./runes.py < $< > $@
.PHONY:all
