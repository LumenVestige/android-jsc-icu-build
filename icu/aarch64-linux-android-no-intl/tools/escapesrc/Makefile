## Makefile.in for ICU - tools/escapesrc
## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html
## Copyright (c) 1999-2011, International Business Machines Corporation and
## others. All Rights Reserved.
## Steven R. Loomis

# To avoid recursion
SKIP_ESCAPING=YES

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/tools/escapesrc
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ../..

include $(top_builddir)/icudefs.mk

## Build directory information
subdir = tools/escapesrc

TARGET_STUB_NAME = escapesrc

SECTION = 8

#MAN_FILES = $(TARGET_STUB_NAME).$(SECTION)

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS) $(MAN_FILES) ./output-*.cpp

## Target information
TARGET = $(BINDIR)/$(TARGET_STUB_NAME)$(EXEEXT)

CPPFLAGS += -I$(top_srcdir)/common -I$(srcdir)/../toolutil
#LIBS = $(LIBICUTOOLUTIL) $(LIBICUI18N) $(LIBICUUC)
LIBS += $(DEFAULT_LIBS) $(LIB_M)

OBJECTS = escapesrc.o

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
	@echo Testing test-nochange.cpp
	@$(INVOKE) $(TARGET) $(srcdir)/test-nochange.cpp ./output-nochange.cpp
	@-diff -I '#line.*' $(srcdir)/test-nochange.cpp ./output-nochange.cpp || (echo >&2 'warning: diff failed or not found' ; true)
	@echo Testing test-simple.cpp
	@$(INVOKE) $(TARGET) $(srcdir)/test-simple.cpp ./output-simple.cpp
	@-diff -I '#line.*' $(srcdir)/expect-simple.cpp ./output-simple.cpp   || (echo >&2 'warning: diff failed or not found' ; true)

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

$(TARGET) : $(OBJECTS)
	$(LINK.cc) $(OUTOPT)$@ $^ $(LIBS)
	$(POST_BUILD_STEP)


%.$(SECTION): $(srcdir)/%.$(SECTION).in
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

# depends on ICU being built
gen-table: tblgen$(EXEEXT)
	$(INVOKE) ./tblgen$(EXEEXT) > $(srcdir)/cptbl.h

tblgen$(EXEEXT): tblgen.o
	$(LINK.cc) $(OUTOPT)$@ $^ $(LIBS) $(LIBICUUC)

ifeq (,$(MAKECMDGOALS))
-include $(DEPS)
else
ifneq ($(patsubst %clean,,$(MAKECMDGOALS)),)
-include $(DEPS)
endif
endif

