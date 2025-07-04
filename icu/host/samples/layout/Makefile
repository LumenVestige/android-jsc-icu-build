## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html#License
##
## Makefile.in for ICU - samples/layout
## Copyright (c) 2001-2011, International Business Machines Corporation and
## others. All Rights Reserved.

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/samples/layout
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ../..

include $(top_builddir)/icudefs.mk

## Platform-specific setup
include $(top_srcdir)/config/mh-linux

## Build directory information
subdir = samples/layout

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS)

## Target information
TARGET  = gnomelayout
CTARGET = cgnomelayout

CPPFLAGS += -DLE_USE_CMEMORY `pkg-config --cflags libgnomeui-2.0 freetype2 cairo` -I$(top_srcdir)/common -I$(top_srcdir)/i18n -I$(top_srcdir)/layoutex -I$(top_srcdir)/layout -I$(top_srcdir) -g

LIBS = $(LIBICULX) $(LIBICULE) $(LIBICUUC) $(LIBICUI18N) -lpthread -lm   `pkg-config --libs libgnomeui-2.0 freetype2 cairo`

COMMON=cmaps.o UnicodeReader.o GnomeGUISupport.o FontMap.o GnomeFontMap.o ScriptCompositeFontInstance.o GnomeFontInstance.o FontTableCache.o  paragraph.o

OBJECTS=gnomelayout.o

COBJECTS=gnomeglue.o pflow.o rsurface.o ucreader.o cgnomelayout.o

DEPS = $(OBJECTS:.o=.d)

## List of phony targets
.PHONY : all all-local install install-local clean clean-local	\
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
c-all: c-all-local
c-check: c-all c-check-local

all-local: $(TARGET)

c-all-local: $(CTARGET)

install-local:

dist-local:

clean-local:
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES)
	$(RMV) $(COMMON) $(OBJECTS) $(COBJECTS) $(TARGET)

distclean-local: clean-local
	$(RMV) Makefile

check-local: all-local
	$(INVOKE) ./$(TARGET)

c-check-local: c-all-local
	$(INVOKE) ./$(CTARGET)

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

# The following two rules make it possible to
# compile scrptrun.cpp from the extra/scrptrun directory.
# they were copied from the default rules in mh-linux which
# is probably OK because this sample will only run on Linux...
scrptrun.d: $(top_srcdir)/extra/scrptrun/scrptrun.cpp
	$(SHELL) -ec '$(GEN_DEPS.cc) $< \
		| sed '\''s%\($*\)\.o[ :]*%\1.o $@ : %g'\'' > $@; \
		[ -s $@ ] || rm -f $@'

scrptrun.o: $(top_srcdir)/extra/scrptrun/scrptrun.cpp
	$(COMPILE.cc) $(DYNAMICCPPFLAGS) $(DYNAMICCXXFLAGS) -o $@ $<

$(TARGET) : $(COMMON) $(OBJECTS)
	$(LINK.cc) -o $@ $^ $(LIBS)

$(CTARGET) : $(COMMON) $(COBJECTS)
	$(LINK.cc) -o $@ $^ $(LIBS)

invoke:
	ICU_DATA=$${ICU_DATA:-$(top_builddir)/data/} TZ=PST8PDT $(INVOKE) $(INVOCATION)

ifeq (,$(MAKECMDGOALS))
-include $(DEPS)
else
ifneq ($(patsubst %clean,,$(MAKECMDGOALS)),)
-include $(DEPS)
endif
endif
