## Makefile.in for ICU - tools/icuswap
## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html
## Copyright (c) 1999-2011, International Business Machines Corporation and
## others. All Rights Reserved.
## Steven R. Loomis

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/tools/icuswap
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ../..

include $(top_builddir)/icudefs.mk

## Build directory information
subdir = tools/icuswap

TARGET_STUB_NAME = icuswap

SECTION = 8

#MAN_FILES = $(TARGET_STUB_NAME).$(SECTION)

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS) $(MAN_FILES)

## Target information
TARGET = $(BINDIR)/$(TARGET_STUB_NAME)$(EXEEXT)

CPPFLAGS += -I$(top_srcdir)/common -I$(srcdir)/../toolutil
LIBS = $(LIBICUTOOLUTIL) $(LIBICUI18N) $(LIBICUUC) $(DEFAULT_LIBS) $(LIB_M)

OBJECTS = icuswap.o

DEPS = $(OBJECTS:.o=.d)

## List of phony targets
.PHONY : all all-local install install-local clean clean-local	\
distclean distclean-local dist dist-local check check-local install-man

## Clear suffix list
.SUFFIXES :

## List of standard targets
all: all-local
install: install-local
clean: clean-local
distclean : distclean-local
dist: dist-local
check: all check-local

all-local: $(TARGET) $(MAN_FILES)

install-local: all-local install-man
	$(MKINSTALLDIRS) $(DESTDIR)$(sbindir)
	$(INSTALL) $(TARGET) $(DESTDIR)$(sbindir)

install-man: $(MAN_FILES)
#	$(MKINSTALLDIRS) $(DESTDIR)$(mandir)/man$(SECTION)
#	$(INSTALL_DATA) $? $(DESTDIR)$(mandir)/man$(SECTION)


dist-local:

clean-local:
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES)
	$(RMV) $(TARGET) $(OBJECTS)

distclean-local: clean-local
	$(RMV) Makefile

check-local: all-local

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

$(TARGET) : $(OBJECTS)
	echo Note: icuswap is obsolete - use icupkg instead.
	$(LINK.cc) $(OUTOPT)$@ $^ $(LIBS)
	$(POST_BUILD_STEP)


%.$(SECTION): $(srcdir)/%.$(SECTION).in
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status


ifeq (,$(MAKECMDGOALS))
-include $(DEPS)
else
ifneq ($(patsubst %clean,,$(MAKECMDGOALS)),)
-include $(DEPS)
endif
endif

