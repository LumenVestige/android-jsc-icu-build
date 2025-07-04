## Makefile.in for ICU - tools/gennorm2
## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html
## Copyright (c) 2009-2011, International Business Machines Corporation and
## others. All Rights Reserved.
## Steven R. Loomis/Markus W. Scherer

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/tools/gennorm2
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ../..

include $(top_builddir)/icudefs.mk

## Build directory information
subdir = tools/gennorm2

TARGET_STUB_NAME = gennorm2

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS)

## Target information
TARGET = $(BINDIR)/$(TARGET_STUB_NAME)$(EXEEXT)

CPPFLAGS += -I$(srcdir) -I$(top_srcdir)/common -I$(srcdir)/../toolutil
LIBS = $(LIBICUTOOLUTIL) $(LIBICUI18N) $(LIBICUUC) $(DEFAULT_LIBS) $(LIB_M)

OBJECTS = gennorm2.o n2builder.o extradata.o norms.o

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

all-local: $(TARGET)

install-local: all-local
	$(MKINSTALLDIRS) $(DESTDIR)$(sbindir)
	$(INSTALL) $(TARGET) $(DESTDIR)$(sbindir)

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
	$(LINK.cc) $(OUTOPT)$@ $^ $(LIBS)
	$(POST_BUILD_STEP)


ifeq (,$(MAKECMDGOALS))
-include $(DEPS)
else
ifneq ($(patsubst %clean,,$(MAKECMDGOALS)),)
-include $(DEPS)
endif
endif
