## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html
## ******************************************************************************
## *
## *   Copyright (C) 1999-2014, International Business Machines
## *   Corporation and others.  All Rights Reserved.
## *
## *******************************************************************************
## Makefile.in for ICU - uconv
## Steven  R. Loomis

## Set the following to dll or static or common..
UCONVMSG_MODE=static
##############################################################

srcdir=/mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/extra/uconv
top_srcdir=/mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ../..
subdir = extra/uconv

include $(top_builddir)/icudefs.mk

MSGNAME=uconvmsg

# RESSRC comes from resfiles.mk
FILESEPCHAR=/
include $(srcdir)/resfiles.mk

RESDIR=$(MSGNAME)
RESFILES=$(RESSRC:$(RESOURCESDIR)$(FILESEPCHAR)%.txt=$(RESDIR)/%.res)

##

TARGET_STUB_NAME = uconv

SECTION = 1

ALL_MAN_FILES = $(TARGET_STUB_NAME).$(SECTION)

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS) $(ALL_MAN_FILES)

## Target information
TARGET = $(BINDIR)/$(TARGET_STUB_NAME)$(EXEEXT)

CPPFLAGS += -I$(srcdir) -I$(top_srcdir)/common -I$(top_srcdir)/i18n -I$(srcdir)/../toolutil
CPPFLAGS += -DUNISTR_FROM_CHAR_EXPLICIT=explicit -DUNISTR_FROM_STRING_EXPLICIT=explicit
LIBS = $(LIBICUI18N) $(LIBICUUC) $(DEFAULT_LIBS) $(LIB_M)

ifeq ($(PKGDATA_OPTS),)
PKGDATA_OPTS = -O pkgdata.inc
endif

## generic settings for data - common.
PKGMODE=common
INSTALLTO=$(DESTDIR)$(ICUDATA_DIR)
UCONVMSG_LIB=package-resfiles

## Static mode
ifeq ($(UCONVMSG_MODE),static)
DEFS += -DUCONVMSG_LINK=$(MSGNAME)
UCONVMSG_LIB = $(RESDIR)/$(LIBPREFIX)$(STATIC_PREFIX_WHEN_USED)$(MSGNAME).$(A)
LIBS += $(UCONVMSG_LIB)
PKGMODE=static
INSTALLTO=$(libdir)
endif

## DLL mode
ifeq ($(UCONVMSG_MODE),dll)
DEFS += -DUCONVMSG_LINK=$(MSGNAME)
LIBS += -L$(RESDIR) -l$(MSGNAME)
PKGMODE=dll
INSTALLTO=$(libdir)
endif

OBJECTS = uconv.o uwmsg.o

DEPS = $(OBJECTS:.o=.d)

## List of phony targets
.PHONY : all all-local install install-local clean clean-local \
distclean resclean distclean-local dist dist-local \
check check-local build-dir package-resfiles install-resfiles install-man

## Clear suffix list
.SUFFIXES :

## List of standard targets
all: all-local

install: install-local
clean: clean-local
distclean : distclean-local
dist: dist-local
check: check-local

all-local: build-dir $(TARGET) $(ALL_MAN_FILES)

install-local: all-local install-target install-resfiles install-man

install-target: all-local
	$(MKINSTALLDIRS) $(DESTDIR)$(bindir)
	$(INSTALL) $(TARGET) $(DESTDIR)$(bindir)

dist-local:

clean-local: resclean
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES) $(RESFILES)
	$(RMV) $(OBJECTS) $(TARGET)

resclean:
	@#-$(INVOKE) $(TOOLBINDIR)/pkgdata --clean -p $(RESDIR) -O pkgdata.inc -m $(PKGMODE) -d $(RESDIR) -T $(RESDIR) $(RESDIR)/$(RESDIR).lst
	$(RMV) pkgdata.inc $(RESDIR)

distclean-local: clean-local
	$(RMV) Makefile $(DEPS)

check-local: $(TARGET)
ifneq (,$(filter $(PKGDATA_MODE),files common))
	@echo "Currently, pkgdata is in \"$(PKGDATA_MODE)\" mode."
	@echo "To test uconv, run this manually after installing ICU:"
	@echo "\"./$(TARGET) -f ibm-37 $(srcdir)/samples/ibm-37-test.txt\""
else
	$(INVOKE) ./$(TARGET) -f ibm-37 $(srcdir)/samples/ibm-37-test.txt
endif

Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

pkgdata.inc: pkgdataMakefile
	$(MAKE) -f pkgdataMakefile

build-dir:
	@$(MKINSTALLDIRS) $(RESDIR)

pkgdataMakefile:
	cd $(top_builddir) \
	&& CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

$(TARGET_STUB_NAME).$(SECTION): $(srcdir)/$(TARGET_STUB_NAME).$(SECTION).in pkgdata.inc
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$(TARGET_STUB_NAME).$(SECTION) CONFIG_HEADERS= $(SHELL) ./config.status

$(TARGET) : $(OBJECTS)  $(UCONVMSG_LIB)
	$(LINK.cc) $(OUTOPT)$@ $(OBJECTS) $(LIBS)
	$(POST_BUILD_STEP)

# The | is an order-only prerequisite. This helps when the -j option is used,
# and we don't want the files to be built before the directories are built.
ifneq ($(filter order-only,$(.FEATURES)),)
$(RESFILES) $(RESDIR)/$(RESDIR).lst: | build-dir
endif

$(UCONVMSG_LIB): $(RESFILES) $(RESDIR)/$(RESDIR).lst pkgdata.inc
	$(INVOKE) $(PKGDATA_INVOKE_OPTS) $(TOOLBINDIR)/pkgdata -p $(MSGNAME) $(PKGDATA_OPTS) -m $(PKGMODE) -s $(RESDIR) -d $(RESDIR) -T $(RESDIR) $(RESDIR)/$(RESDIR).lst

$(RESDIR)/$(RESDIR).lst: Makefile $(srcdir)/resfiles.mk
	@-$(RMV) $@
	@for file in $(RESFILES:$(RESDIR)/%.res=%.res); do \
	  echo $$file >> $@; \
	done;

# no install for static mode
ifneq ($(UCONVMSG_MODE),static)
install-resfiles: $(RESFILES) $(RESDIR)/$(RESDIR).lst pkgdata.inc 
	$(MKINSTALLDIRS) $(DESTDIR)$(ICUDATA_DIR)
	$(INVOKE) $(TOOLBINDIR)/pkgdata -p $(RESDIR) -O pkgdata.inc -m $(PKGMODE) -d $(RESDIR) -I $(INSTALLTO) -T $(RESDIR) $(RESDIR)/$(RESDIR).lst
else
install-resfiles:
endif

$(MSGNAME)/%.res: $(srcdir)/$(RESOURCESDIR)/%.txt
	$(INVOKE) $(TOOLBINDIR)/genrb -e UTF-8 -s $(^D) -d $(@D) $(^F)

install-man: $(ALL_MAN_FILES)
	$(MKINSTALLDIRS) $(DESTDIR)$(mandir)/man$(SECTION)
	$(INSTALL_DATA) $? $(DESTDIR)$(mandir)/man$(SECTION)



