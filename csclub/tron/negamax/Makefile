SHEDSKIN_LIBDIR=/home/ted/mnt/Documents/csclub/tron/mainline/build/lib/shedskin/lib
CC=g++
CCFLAGS=-O2 -march=native -Wno-deprecated $(CPPFLAGS) -I. -I${SHEDSKIN_LIBDIR} -D__SS_NOBOUNDS -D__SS_FASTRANDOM -D__SS_NOASSERT -D__SS_FASTHASH
LFLAGS=-lgc -lpcre $(LDFLAGS)

CPPFILES=/home/ted/mnt/Documents/csclub/tron/negamax/negamax.cpp \
	${SHEDSKIN_LIBDIR}/time.cpp \
	${SHEDSKIN_LIBDIR}/sys.cpp \
	${SHEDSKIN_LIBDIR}/struct.cpp \
	${SHEDSKIN_LIBDIR}/socket.cpp \
	${SHEDSKIN_LIBDIR}/re.cpp \
	${SHEDSKIN_LIBDIR}/random.cpp \
	${SHEDSKIN_LIBDIR}/math.cpp \
	${SHEDSKIN_LIBDIR}/builtin.cpp

HPPFILES=/home/ted/mnt/Documents/csclub/tron/negamax/negamax.hpp \
	${SHEDSKIN_LIBDIR}/time.hpp \
	${SHEDSKIN_LIBDIR}/sys.hpp \
	${SHEDSKIN_LIBDIR}/struct.hpp \
	${SHEDSKIN_LIBDIR}/socket.hpp \
	${SHEDSKIN_LIBDIR}/re.hpp \
	${SHEDSKIN_LIBDIR}/random.hpp \
	${SHEDSKIN_LIBDIR}/math.hpp \
	${SHEDSKIN_LIBDIR}/builtin.hpp

all:	negamax

negamax:	$(CPPFILES) $(HPPFILES)
	$(CC)  $(CCFLAGS) $(CPPFILES) $(LFLAGS) -o negamax

negamax_prof:	$(CPPFILES) $(HPPFILES)
	$(CC) -pg -ggdb $(CCFLAGS) $(CPPFILES) $(LFLAGS) -o negamax_prof

negamax_debug:	$(CPPFILES) $(HPPFILES)
	$(CC) -g -ggdb $(CCFLAGS) $(CPPFILES) $(LFLAGS) -o negamax_debug

clean:
	rm -f negamax negamax_prof negamax_debug

.PHONY: all clean

