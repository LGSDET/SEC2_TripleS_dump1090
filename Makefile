#CFLAGS?=-O2 -g -Wall -W $(shell pkg-config --cflags librtlsdr)
#LDLIBS+=$(shell pkg-config --libs librtlsdir) -lpthread -lm -lssl -lcrypto
#OpenSSL 경로 자동 설정 (Mac과 Linux 모두 대응)
OPENSSL_INC := $(shell if [ -d /opt/homebrew/opt/openssl@3/include ]; then echo -I/opt/homebrew/opt/openssl@3/include; else echo -I/usr/include/openssl; fi)
OPENSSL_LIB := $(shell if [ -d /opt/homebrew/opt/openssl@3/lib ]; then echo -L/opt/homebrew/opt/openssl@3/lib; else echo -L/usr/lib; fi)

CFLAGS ?= -O2 -g -Wall -W $(shell pkg-config --cflags librtlsdr) $(OPENSSL_INC) -I/usr/include/json-c
LDLIBS += $(shell pkg-config --libs librtlsdr) $(OPENSSL_LIB) -lssl -lcrypto -lpthread -lm -ljson-c

CC?=gcc
PROGNAME=dump1090

all: dump1090

%.o: %.c
	$(CC) $(CFLAGS) -c $<

dump1090: dump1090.o anet.o
	$(CC) -g -o dump1090 dump1090.o anet.o $(LDFLAGS) $(LDLIBS)

clean:
	rm -f *.o dump1090
