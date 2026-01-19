# @file:  ./Makefile
# @date: Fri, Dec 19, 2025 12:52:59 AM
# @version:    0.0.1

all: reinstall

reinstall: uninstall # INSERT <?php echo("\r$DATE"); ?>
	./install.sh

install: uninstall
	./install.sh

uninstall:
	./uninstall.sh
