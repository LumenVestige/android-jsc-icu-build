# Copyright (C) 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html
#******************************************************************************
#
#   Copyright (C) 1999-2014, International Business Machines
#   Corporation and others.  All Rights Reserved.
#
#******************************************************************************
## Makefile.in for ICU - tools/toolutil
## Steven R. Loomis

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/tools/toolutil
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ../..

## All the flags and other definitions are included here.
include $(top_builddir)/icudefs.mk

## Build directory information
subdir = tools/toolutil

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS) $(IMPORT_LIB) $(MIDDLE_IMPORT_LIB) $(FINAL_IMPORT_LIB)

## Target information

TARGET_STUBNAME=$(TOOLUTIL_STUBNAME)

ifneq ($(ENABLE_STATIC),)
TARGET = $(LIBDIR)/$(LIBSICU)$(TARGET_STUBNAME)$(ICULIBSUFFIX).$(A)
endif

ifneq ($(ENABLE_SHARED),)
SO_TARGET = $(LIBDIR)/$(LIBICU)$(TARGET_STUBNAME)$(ICULIBSUFFIX).$(SO)
ALL_SO_TARGETS = $(SO_TARGET) $(MIDDLE_SO_TARGET) $(FINAL_SO_TARGET) $(SHARED_OBJECT)
endif

ALL_TARGETS = $(TARGET) $(ALL_SO_TARGETS)

DYNAMICCPPFLAGS = $(SHAREDLIBCPPFLAGS)
DYNAMICCFLAGS = $(SHAREDLIBCFLAGS)
DYNAMICCXXFLAGS = $(SHAREDLIBCXXFLAGS)
CFLAGS += $(LIBCFLAGS)
CXXFLAGS += $(LIBCXXFLAGS)

CPPFLAGS += -I$(srcdir) -I$(top_srcdir)/common -I$(top_srcdir)/i18n $(LIBCPPFLAGS)

# from icuinfo
CPPFLAGS+=  "-DU_BUILD=\"x86_64-pc-linux-gnu\"" "-DU_HOST=\"aarch64-unknown-linux-android\"" "-DU_CC=\"aarch64-linux-android24-clang\"" "-DU_CXX=\"aarch64-linux-android24-clang++\""
CPPFLAGS += -DUNISTR_FROM_CHAR_EXPLICIT=explicit -DUNISTR_FROM_STRING_EXPLICIT=explicit

DEFS += -DU_TOOLUTIL_IMPLEMENTATION
LDFLAGS += $(LDFLAGSICUTOOLUTIL)
LIBS = $(LIBICUI18N) $(LIBICUUC) $(DEFAULT_LIBS)

OBJECTS = filestrm.o package.o pkgitems.o swapimpl.o toolutil.o unewdata.o \
collationinfo.o denseranges.o \
ucm.o ucmstate.o uoptions.o uparse.o \
ucbuf.o xmlparser.o writesrc.o \
pkg_icu.o pkg_genc.o pkg_gencmn.o ppucd.o flagparser.o filetools.o \
udbgutil.o dbgutil.o ucln_tu.o

STATIC_OBJECTS = $(OBJECTS:.o=.$(STATIC_O))

DEPS = $(OBJECTS:.o=.d)

-include Makefile.local

## List of phony targets
.PHONY : all all-local install install-local clean clean-local	\
distclean distclean-local install-library dist	\
dist-local check check-local

## Clear suffix list
.SUFFIXES :

## List of standard targets
all: all-local
install: install-local
clean: clean-local
distclean : distclean-local
dist: dist-local
check: all check-local

all-local: $(ALL_TARGETS)

install-local: install-library

install-library: all-local
	$(MKINSTALLDIRS) $(DESTDIR)$(libdir)
ifneq ($(ENABLE_STATIC),)
	$(INSTALL-L) $(TARGET) $(DESTDIR)$(libdir)
endif
ifneq ($(ENABLE_SHARED),)
	$(INSTALL-L) $(FINAL_SO_TARGET) $(DESTDIR)$(libdir)
ifneq ($(FINAL_SO_TARGET),$(SO_TARGET))
	cd $(DESTDIR)$(libdir) && $(RM) $(notdir $(SO_TARGET)) && ln -s $(notdir $(FINAL_SO_TARGET)) $(notdir $(SO_TARGET))
ifneq ($(FINAL_SO_TARGET),$(MIDDLE_SO_TARGET))
	cd $(DESTDIR)$(libdir) && $(RM) $(notdir $(MIDDLE_SO_TARGET)) && ln -s $(notdir $(FINAL_SO_TARGET)) $(notdir $(MIDDLE_SO_TARGET))
endif
endif
ifneq ($(IMPORT_LIB_EXT),)
	$(INSTALL-L) $(FINAL_IMPORT_LIB) $(DESTDIR)$(libdir)
ifneq ($(IMPORT_LIB),$(FINAL_IMPORT_LIB))
	cd $(DESTDIR)$(libdir) && $(RM) $(notdir $(IMPORT_LIB)) && ln -s $(notdir $(FINAL_IMPORT_LIB)) $(notdir $(IMPORT_LIB))
endif
ifneq ($(MIDDLE_IMPORT_LIB),$(FINAL_IMPORT_LIB))
	cd $(DESTDIR)$(libdir) && $(RM) $(notdir $(MIDDLE_IMPORT_LIB)) && ln -s $(notdir $(FINAL_IMPORT_LIB)) $(notdir $(MIDDLE_IMPORT_LIB))
endif
endif
endif

dist-local:

clean-local:
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES)
	$(RMV) $(OBJECTS) $(STATIC_OBJECTS) $(ALL_TARGETS)

distclean-local: clean-local
	$(RMV) Makefile

check-local: all-local

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

ifneq ($(ENABLE_STATIC),)
$(TARGET): $(STATIC_OBJECTS)
	$(AR) $(ARFLAGS) $(AR_OUTOPT)$@ $^
	$(RANLIB) $@
endif

ifneq ($(ENABLE_SHARED),)
$(SHARED_OBJECT): $(OBJECTS)
	$(SHLIB.cc) $(LD_SONAME) $(OUTOPT)$@ $^ $(LIBS)
ifeq ($(ENABLE_RPATH),YES)
ifneq ($(wildcard $(libdir)/$(MIDDLE_SO_TARGET)),)
	$(warning RPATH warning: --enable-rpath means test programs may use existing $(libdir)/$(MIDDLE_SO_TARGET))
endif
endif
endif

ifeq (,$(MAKECMDGOALS))
-include $(DEPS)
else
ifneq ($(patsubst %clean,,$(MAKECMDGOALS)),)
-include $(DEPS)
endif
endif

