## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html#License
##
## Makefile.in for ICU - samples/cal
## Copyright (c) 1999-2011, International Business Machines Corporation and
## others. All Rights Reserved.

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/samples/cal
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

## Install directory information
top_builddir = ../..

include $(top_builddir)/icudefs.mk

## Build directory information
subdir = samples/cal

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS)

## Target information
TARGET = icucal$(EXEEXT)

CPPFLAGS += -I$(top_srcdir)/common -I$(top_srcdir)/i18n
LIBS = $(LIBICUI18N) $(LIBICUUC) $(DEFAULT_LIBS) $(LIB_M)

OBJECTS = uprint.o cal.o

DEPS = $(OBJECTS:.o=.d)

## List of phony targets
.PHONY : all all-local install install-local clean clean-local \
distclean distclean-local dist dist-local check check-local

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

dist-local:

clean-local:
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES)
	$(RMV) $(OBJECTS) $(TARGET)

distclean-local: clean-local
	$(RMV) Makefile

check-local:
	-$(INVOKE) ./$(TARGET)

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
