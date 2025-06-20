## Makefile.in for ICU samples
## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html#License
##
## Copyright (c) 1999-2011, International Business Machines Corporation and
## others. All Rights Reserved.

## Install directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/samples
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ..

include $(top_builddir)/icudefs.mk

## Build directory information
subdir = samples

## Platform-specific setup
include $(top_srcdir)/config/mh-linux

## Files to remove for 'make clean'
CLEANFILES = *~

SUBDIRS = date cal
ALLSUBDIRS = break case csdet datefmt msgfmt numfmt props translit ucnv udata ufortune uresb ustring citer uciter8 ugrep

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

all-samples: all-samples-recursive
clean-samples: clean-samples-recursive
check-samples: check-samples-recursive

# Note (srl 4/15/2002) do  NOT recursively check samples for 2.1, look into testing them in the future.
#check: all check-recursive check-local
check: all check-local

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

all-samples-recursive check-samples-recursive clean-samples-recursive:
	@dot_seen=no; \
	target=`echo $@ | sed s/-recursive//`; \
	subtarget=`echo $@ | sed s/-samples-recursive//`; \
	list='$(SUBDIRS) $(ALLSUBDIRS)'; for subdir in $$list; do \
	  echo "$(MAKE)[$(MAKELEVEL)]: Making \`$$subtarget' in \`$$subdir'"; \
	  if test "$$subdir" = "."; then \
	    dot_seen=yes; \
	    local_target="$$subtarget-local"; \
	  else \
	    local_target="$$subtarget"; \
	  fi; \
	  (cd $$subdir && $(MAKE) $$local_target) || exit; \
	done; \
	if test "$$dot_seen" = "no"; then \
	  $(MAKE) "$$subtarget-local" || exit; \
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
