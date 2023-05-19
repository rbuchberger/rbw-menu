DESTDIR = /usr
SCRIPTS = bww bww-setup bww-menu bww-sync gen-otp

.PHONY: install uninstall

install:
	@for script in $(SCRIPTS); do \
		install -D -m 755 bin/$$script $(DESTDIR)/bin/$$script; \
	done

uninstall:
	@for script in $(SCRIPTS); do \
		rm -f $(DESTDIR)/$$script; \
		echo "Uninstalled $$script"; \
	done
