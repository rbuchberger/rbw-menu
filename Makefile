DESTDIR = /usr/bin
SCRIPTS = bw-unlock bwmenu bww gen-otp

.PHONY: install uninstall

install:
	@echo "Installing scripts..."
	@for script in $(SCRIPTS); do \
		install -D -m 755 $$script $(DESTDIR)/$$script; \
		echo "Installed $$script"; \
	done

uninstall:
	@echo "Uninstalling scripts..."
	@for script in $(SCRIPTS); do \
		rm -f $(DESTDIR)/$$script; \
		echo "Uninstalled $$script"; \
	done
