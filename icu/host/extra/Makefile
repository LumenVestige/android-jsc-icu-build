# Copyright (C) 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html
#******************************************************************************
#
#   Copyright (C) 1999-2011, International Business Machines
#   Corporation and others.  All Rights Reserved.
#
#******************************************************************************
## Makefile.in for ICU extras
## Stephen F. Booth

## Install directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/extra
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ..

include $(top_builddir)/icudefs.mk

## Build directory information
subdir = extra

## Files to remove for 'make clean'
CLEANFILES = *~

SUBDIRS = uconv

## List of phony targets
.PHONY : all all-local all-recursive install install-local		\
install-recursive clean clean-local clean-recursive distclean		\
distclean-local distclean-recursive dist dist-recursive dist-local	\
check check-recursive check-local check-exhaustive

## Clear suffix list
.SUFFIXES :

## List of standard targets
all: all-recursive all-local
install: install-recursive install-local
clean: clean-recursive clean-local
distclean : distclean-recursive distclean-local
dist: dist-recursive dist-local
check: all check-recursive check-local

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

all-local:

install-local:

dist-local:

clean-local:
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES)

check-local:

distclean-local: clean-local
	$(RMV) Makefile

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	&& CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status
