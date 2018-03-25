#
# Makefile for installing the mingw32 version of the SDL2_mixer library

CROSS_PATH := /usr/local
ARCHITECTURES := i686-w64-mingw32 x86_64-w64-mingw32

all install:
	@echo "Type \"make native\" to install 32-bit to /usr"
	@echo "Type \"make cross\" to install 32-bit and 64-bit to $(CROSS_PATH)"

native:
	make install-package arch=i686-w64-mingw32 prefix=/usr

cross:
	for arch in $(ARCHITECTURES); do \
	    make install-package arch=$$arch prefix=$(CROSS_PATH)/$$arch; \
	done

install-package:
	@if test -d $(arch) && test -d $(prefix); then \
	    (cd $(arch) && cp -rv bin include lib $(prefix)/); \
	    sed "s|^libdir=.*|libdir=\'$(prefix)/lib\'|" <$(arch)/lib/libSDL2_mixer.la >$(prefix)/lib/libSDL2_mixer.la; \
	else \
	    echo "*** ERROR: $(arch) or $(prefix) does not exist!"; \
	    exit 1; \
	fi
