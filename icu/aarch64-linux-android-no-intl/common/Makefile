# Copyright (C) 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html
#******************************************************************************
#
#   Copyright (C) 1999-2016, International Business Machines
#   Corporation and others.  All Rights Reserved.
#
#******************************************************************************
## Makefile.in for ICU - icuuc.so
## Stephen F. Booth

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/common
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ..

## All the flags and other definitions are included here.
include $(top_builddir)/icudefs.mk

## Build directory information
subdir = common

# for service hook
LOCALSVC_CPP=localsvc.cpp
SVC_HOOK_INC=$(top_builddir)/common/svchook.mk

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS) $(IMPORT_LIB) $(MIDDLE_IMPORT_LIB) $(FINAL_IMPORT_LIB) $(SVC_HOOK_INC)

## Target information

TARGET_STUBNAME=$(COMMON_STUBNAME)

ifneq ($(ENABLE_STATIC),)
TARGET = $(LIBDIR)/$(LIBSICU)$(TARGET_STUBNAME)$(ICULIBSUFFIX).$(A)
endif

ifneq ($(ENABLE_SHARED),)
SO_TARGET = $(LIBDIR)/$(LIBICU)$(TARGET_STUBNAME)$(ICULIBSUFFIX).$(SO)
ALL_SO_TARGETS = $(SO_TARGET) $(MIDDLE_SO_TARGET) $(FINAL_SO_TARGET) $(SHARED_OBJECT)

ifeq ($(ENABLE_SO_VERSION_DATA),1)
SO_VERSION_DATA = common.res
endif

ifeq ($(OS390BATCH),1)
BATCH_TARGET = $(BATCH_COMMON_TARGET)
BATCH_LIBS = $(BATCH_LIBICUDT) -lm
endif   # OS390BATCH

endif   # ENABLE_SHARED

ALL_TARGETS = $(TARGET) $(ALL_SO_TARGETS) $(BATCH_TARGET)

DYNAMICCPPFLAGS = $(SHAREDLIBCPPFLAGS)
DYNAMICCFLAGS = $(SHAREDLIBCFLAGS)
DYNAMICCXXFLAGS = $(SHAREDLIBCXXFLAGS)
CFLAGS += $(LIBCFLAGS)
CXXFLAGS += $(LIBCXXFLAGS)
ifeq ($(OS390BATCH),1)
CFLAGS += -WI
CXXFLAGS += -WI
endif

CPPFLAGS += -I$(srcdir) $(LIBCPPFLAGS) $(CPPFLAGSICUUC)
# we want DEFS here
DEFS += -DU_COMMON_IMPLEMENTATION 
LDFLAGS += $(LDFLAGSICUUC)

# for plugin configuration
CPPFLAGS += "-DDEFAULT_ICU_PLUGINS=\"$(libdir)/icu\" "

# for icu data location
ifeq ($(PKGDATA_MODE),common)
CPPFLAGS += "-DU_ICU_DATA_DEFAULT_DIR=\"$(ICUDATA_DIR)\""
endif

# $(LIBICUDT) is either stub data or the real DLL common data.
LIBS = $(LIBICUDT) $(DEFAULT_LIBS)

OBJECTS = errorcode.o putil.o umath.o utypes.o uinvchar.o umutex.o ucln_cmn.o \
uinit.o uobject.o cmemory.o charstr.o cstr.o \
udata.o ucmndata.o udatamem.o umapfile.o udataswp.o utrie_swap.o ucol_swp.o utrace.o \
uhash.o uhash_us.o uenum.o ustrenum.o uvector.o ustack.o uvectr32.o uvectr64.o \
ucnv.o ucnv_bld.o ucnv_cnv.o ucnv_io.o ucnv_cb.o ucnv_err.o ucnvlat1.o \
ucnv_u7.o ucnv_u8.o ucnv_u16.o ucnv_u32.o ucnvscsu.o ucnvbocu.o \
ucnv_ext.o ucnvmbcs.o ucnv2022.o ucnvhz.o ucnv_lmb.o ucnvisci.o ucnvdisp.o ucnv_set.o ucnv_ct.o \
resource.o uresbund.o ures_cnv.o uresdata.o resbund.o resbund_cnv.o \
ucurr.o \
localebuilder.o \
messagepattern.o ucat.o locmap.o uloc.o locid.o locutil.o locavailable.o locdispnames.o locdspnm.o loclikely.o locresdata.o \
bytestream.o stringpiece.o bytesinkutil.o \
stringtriebuilder.o bytestriebuilder.o \
bytestrie.o bytestrieiterator.o \
ucharstrie.o ucharstriebuilder.o ucharstrieiterator.o \
dictionarydata.o \
edits.o \
appendable.o ustr_cnv.o unistr_cnv.o unistr.o unistr_case.o unistr_props.o \
utf_impl.o ustring.o ustrcase.o ucasemap.o ucasemap_titlecase_brkiter.o cstring.o ustrfmt.o ustrtrns.o ustr_wcs.o utext.o \
unistr_case_locale.o ustrcase_locale.o unistr_titlecase_brkiter.o ustr_titlecase_brkiter.o \
normalizer2impl.o normalizer2.o filterednormalizer2.o normlzr.o unorm.o unormcmp.o loadednormalizer2impl.o \
chariter.o schriter.o uchriter.o uiter.o \
patternprops.o uchar.o uprops.o ucase.o propname.o ubidi_props.o characterproperties.o \
ubidi.o ubidiwrt.o ubidiln.o ushape.o \
uscript.o uscript_props.o usc_impl.o unames.o \
utrie.o utrie2.o utrie2_builder.o ucptrie.o umutablecptrie.o \
bmpset.o unisetspan.o uset_props.o uniset_props.o uniset_closure.o uset.o uniset.o usetiter.o ruleiter.o caniter.o unifilt.o unifunct.o \
uarrsort.o brkiter.o ubrk.o brkeng.o dictbe.o filteredbrk.o \
rbbi.o rbbidata.o rbbinode.o rbbirb.o rbbiscan.o rbbisetb.o rbbistbl.o rbbitblb.o rbbi_cache.o \
serv.o servnotf.o servls.o servlk.o servlkf.o servrbf.o servslkf.o \
uidna.o usprep.o uts46.o punycode.o \
util.o util_props.o parsepos.o locbased.o cwchar.o wintz.o dtintrv.o ucnvsel.o propsvec.o \
ulist.o uloc_tag.o icudataver.o icuplug.o \
sharedobject.o simpleformatter.o unifiedcache.o uloc_keytype.o \
ubiditransform.o \
pluralmap.o \
static_unicode_sets.o

## Header files to install
HEADERS = $(srcdir)/unicode/*.h

STATIC_OBJECTS = $(OBJECTS:.o=.$(STATIC_O))

DEPS = $(OBJECTS:.o=.d)

-include Makefile.local

-include $(SVC_HOOK_INC)


## List of phony targets
.PHONY : all all-local install install-local clean clean-local	\
distclean distclean-local install-library install-headers dist	\
dist-local check check-local check-exhaustive

## Clear suffix list
.SUFFIXES :

## List of standard targets
all: all-local
install: install-local
clean: clean-local
distclean : distclean-local
dist: dist-local
check: all check-local

check-exhaustive: check

all-local: $(ALL_TARGETS)

install-local: install-headers install-library

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

$(SVC_HOOK_INC):
	@echo generating $@
	@-test -f $(top_srcdir)/common/$(LOCALSVC_CPP) && ( echo "have $(LOCALSVC_CPP) - U_LOCAL_SERVICE_HOOK=1" ; \
		echo 'CPPFLAGS +=-DU_LOCAL_SERVICE_HOOK=1' > $@ ; \
		echo 'OBJECTS += $(LOCALSVC_CPP:%.cpp=%.o)' >> $@ \
		 ) ; true
	@echo "# Autogenerated by Makefile" >> $@

install-headers:
	$(MKINSTALLDIRS) $(DESTDIR)$(includedir)/unicode
	@for file in $(HEADERS); do \
	 echo "$(INSTALL_DATA) $$file $(DESTDIR)$(includedir)/unicode"; \
	 $(INSTALL_DATA) $$file $(DESTDIR)$(includedir)/unicode || exit; \
	done

dist-local:

clean-local:
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES)
	$(RMV) $(OBJECTS) $(STATIC_OBJECTS) $(ALL_TARGETS) $(SO_VERSION_DATA)

distclean-local: clean-local
	$(RMV) Makefile icucfg.h $(SVC_HOOK_INC)

check-local:

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status $(SVC_HOOK_INC)
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

ifneq ($(ENABLE_STATIC),)
$(TARGET): $(STATIC_OBJECTS)
	$(AR) $(ARFLAGS) $(AR_OUTOPT)$@ $^
	$(RANLIB) $@
endif

ifneq ($(ENABLE_SHARED),)
$(SHARED_OBJECT): $(OBJECTS) $(SO_VERSION_DATA)
	$(SHLIB.cc) $(LD_SONAME) $(OUTOPT)$@ $^ $(LIBS)
ifeq ($(ENABLE_RPATH),YES)
ifneq ($(wildcard $(libdir)/$(MIDDLE_SO_TARGET)),)
	$(warning RPATH warning: --enable-rpath means test programs may use existing $(libdir)/$(MIDDLE_SO_TARGET))
endif
endif

ifeq ($(OS390BATCH),1)
$(BATCH_TARGET):$(OBJECTS)
	$(SHLIB.cc) $(LD_SONAME) $(OUTOPT)$@ $^ $(BATCH_LIBS)
endif   # OS390BATCH
endif   # ENABLE_SHARED

ifeq (,$(MAKECMDGOALS))
-include $(DEPS)
else
ifneq ($(patsubst %clean,,$(MAKECMDGOALS)),)
-include $(DEPS)
endif
endif

