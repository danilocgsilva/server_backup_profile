BIN ?= sbprofile
PREFIX ?= /usr/local

install:
	cp sbprofile.sh $(PREFIX)/bin/$(BIN)
	chmod +x $(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
