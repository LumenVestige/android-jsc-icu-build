## Makefile.in for ICU tools
## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html
## Copyright (c) 1999-2012, International Business Machines Corporation and
## others. All Rights Reserved.

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/tools
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ..

include $(top_builddir)/icudefs.mk

## Build directory information
subdir = tools

SUBDIRS = toolutil ctestfw makeconv genrb genbrk \
gencnval gensprep icuinfo genccode gencmn icupkg pkgdata \
gentest gennorm2 gencfu gendict

ifneq (mh-linux,mh-cygwin-msvc)
SUBDIRS += escapesrc
endif

## List of phony targets
.PHONY : all all-local all-recursive install install-local	\
install-recursive clean clean-local clean-recursive distclean		\
distclean-local distclean-recursive dist dist-local dist-recursive	\
check check-local check-recursive build-local check-exhaustive

## Clear suffix list
.SUFFIXES :

## List of standard targets
all: all-recursive
install: install-recursive
clean: clean-local clean-recursive
distclean : distclean-recursive
dist: dist-recursive 
check: all check-recursive

check-exhaustive: check

## Recursive targets
all-recursive install-recursive clean-recursive distclean-recursive dist-recursive check-recursive:
	@dot_seen=no; \
	target=`echo $@ | sed s/-recursive//`; \
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  echo "$(MAKE)[$(MAKELEVEL)]: Making \`$$target' in \`$$subdir'"; \
	  if test "$$subdir" = "."; then \
		dot_seen=yes; \
		local_target="$$target-local"; \
	  else \
		local_target="$$target"; \
	  fi; \
	  (cd $$subdir && $(MAKE) $$local_target) || exit; \
	done; \
	if test "$$dot_seen" = "no"; then \
	  $(MAKE) "$$target-local" || exit; \
	fi

all-local: build-local


## Files to remove for 'make clean'
CLEANFILES = *~

install-local:

dist-local:

clean-local: 
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES)

# Clean up any old variations.. 
distclean-local: clean-local
	$(RMV) Makefile

build-local:

check-local:

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	&& CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

