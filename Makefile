PREFIX = /usr
BINDIR = $(PREFIX)/bin
DOCDIR = $(PREFIX)/share/doc
MANDIR = $(PREFIX)/share/man

OPTFLAGS = $(shell getconf LFS_CFLAGS) -D_FORTIFY_SOURCE=2 -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wl,-z,relro
WARNFLAGS = -Wall -Wextra -pedantic
DEBUGFLAGS = -g
CFLAGS += $(OPTFLAGS) $(WARNFLAGS) $(DEBUGFLAGS)
LDFLAGS += -Wl,--as-needed

all: pcap pcapng
	gcc $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) pcapfix.c pcap.o pcapng.o -o pcapfix

pcap: pcap.c
	gcc $(CPPFLAGS) $(CFLAGS) -c pcap.c -o pcap.o

pcapng: pcapng.c
	gcc $(CPPFLAGS) $(CFLAGS) -c pcapng.c -o pcapng.o

install:
	install -D -m 755 pcapfix $(DESTDIR)/$(BINDIR)/pcapfix
	install -D -m 644 pcapfix.1 $(DESTDIR)/$(MANDIR)/man1/pcapfix.1

uninstall:
	rm -f $(DESTDIR)/$(BINDIR)/pcapfix
	rm -f $(DESTDIR)/$(MANDIR)/man1/pcapfix.1

clean:
	rm -f *.o pcapfix
