# Copyright (C) 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html
#******************************************************************************
#
#   Copyright (C) 1998-2016, International Business Machines
#   Corporation and others.  All Rights Reserved.
#
#******************************************************************************
## Makefile.in for ICU - icui18n.so
## Stephen F. Booth

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/i18n
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ..

## All the flags and other definitions are included here.
include $(top_builddir)/icudefs.mk

## Build directory information
subdir = i18n

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS) $(IMPORT_LIB) $(MIDDLE_IMPORT_LIB) $(FINAL_IMPORT_LIB)

## Target information

TARGET_STUBNAME=$(I18N_STUBNAME)

ifneq ($(ENABLE_STATIC),)
TARGET = $(LIBDIR)/$(LIBSICU)$(TARGET_STUBNAME)$(ICULIBSUFFIX).$(A)
endif

ifneq ($(ENABLE_SHARED),)
SO_TARGET = $(LIBDIR)/$(LIBICU)$(TARGET_STUBNAME)$(ICULIBSUFFIX).$(SO)
ALL_SO_TARGETS = $(SO_TARGET) $(MIDDLE_SO_TARGET) $(FINAL_SO_TARGET) $(SHARED_OBJECT)

ifeq ($(ENABLE_SO_VERSION_DATA),1)
SO_VERSION_DATA = i18n.res
endif

ifeq ($(OS390BATCH),1)
BATCH_TARGET = $(BATCH_I18N_TARGET)
BATCH_LIBS = $(BATCH_LIBICUUC) -lm
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

CPPFLAGS += -I$(srcdir) -I$(top_srcdir)/common $(LIBCPPFLAGS) $(CPPFLAGSICUI18N)
DEFS += -DU_I18N_IMPLEMENTATION
LDFLAGS += $(LDFLAGSICUI18N)
LIBS = $(LIBICUUC) $(DEFAULT_LIBS)

OBJECTS = ucln_in.o \
fmtable.o format.o msgfmt.o umsg.o numfmt.o unum.o decimfmt.o dcfmtsym.o \
fmtable_cnv.o \
choicfmt.o datefmt.o smpdtfmt.o reldtfmt.o dtfmtsym.o udat.o dtptngen.o udatpg.o \
nfrs.o nfrule.o nfsubs.o rbnf.o numsys.o unumsys.o ucsdet.o \
ucal.o calendar.o gregocal.o timezone.o simpletz.o olsontz.o \
astro.o taiwncal.o buddhcal.o persncal.o islamcal.o japancal.o gregoimp.o hebrwcal.o \
indiancal.o chnsecal.o cecal.o coptccal.o dangical.o ethpccal.o \
coleitr.o coll.o sortkey.o bocsu.o ucoleitr.o \
ucol.o ucol_res.o ucol_sit.o \
collation.o collationsettings.o collationdata.o collationtailoring.o \
collationdatareader.o collationdatawriter.o collationfcd.o \
collationiterator.o utf16collationiterator.o utf8collationiterator.o uitercollationiterator.o \
collationsets.o \
collationcompare.o collationfastlatin.o collationkeys.o rulebasedcollator.o collationroot.o \
collationrootelements.o collationdatabuilder.o \
collationweights.o collationruleparser.o collationbuilder.o collationfastlatinbuilder.o \
listformatter.o ulistformatter.o \
strmatch.o usearch.o search.o stsearch.o \
translit.o utrans.o esctrn.o unesctrn.o funcrepl.o strrepl.o tridpars.o \
cpdtrans.o rbt.o rbt_data.o rbt_pars.o rbt_rule.o rbt_set.o \
nultrans.o remtrans.o casetrn.o titletrn.o tolowtrn.o toupptrn.o anytrans.o \
name2uni.o uni2name.o nortrans.o quant.o transreg.o brktrans.o \
regexcmp.o rematch.o repattrn.o regexst.o regextxt.o regeximp.o uregex.o uregexc.o \
ulocdata.o measfmt.o currfmt.o curramt.o currunit.o measure.o utmscale.o \
csdetect.o csmatch.o csr2022.o csrecog.o csrmbcs.o csrsbcs.o csrucode.o csrutf8.o inputext.o \
wintzimpl.o windtfmt.o winnmfmt.o basictz.o dtrule.o rbtz.o tzrule.o tztrans.o vtzone.o zonemeta.o \
standardplural.o upluralrules.o plurrule.o plurfmt.o selfmt.o dtitvfmt.o dtitvinf.o udateintervalformat.o \
tmunit.o tmutamt.o tmutfmt.o currpinf.o \
uspoof.o uspoof_impl.o uspoof_build.o uspoof_conf.o smpdtfst.o \
ztrans.o zrule.o vzone.o fphdlimp.o fpositer.o ufieldpositer.o \
decNumber.o decContext.o alphaindex.o tznames.o tznames_impl.o tzgnames.o \
tzfmt.o compactdecimalformat.o gender.o region.o scriptset.o \
uregion.o reldatefmt.o quantityformatter.o measunit.o \
sharedbreakiterator.o scientificnumberformatter.o dayperiodrules.o nounit.o \
number_affixutils.o number_compact.o number_decimalquantity.o \
number_decimfmtprops.o number_fluent.o number_formatimpl.o number_grouping.o \
number_integerwidth.o number_longnames.o number_modifiers.o number_notation.o number_output.o \
number_padding.o number_patternmodifier.o number_patternstring.o \
number_rounding.o number_scientific.o number_stringbuilder.o number_utils.o number_asformat.o \
number_mapper.o number_multiplier.o number_currencysymbols.o number_skeletons.o number_capi.o \
double-conversion.o double-conversion-bignum-dtoa.o double-conversion-bignum.o \
double-conversion-cached-powers.o double-conversion-diy-fp.o \
double-conversion-fast-dtoa.o double-conversion-strtod.o \
numparse_stringsegment.o numparse_parsednumber.o numparse_impl.o \
numparse_symbols.o numparse_decimal.o numparse_scientific.o numparse_currency.o \
numparse_affixes.o numparse_compositions.o numparse_validators.o \
numrange_fluent.o numrange_impl.o \
erarules.o formattedvalue.o formattedval_iterimpl.o formattedval_sbimpl.o

## Header files to install
HEADERS = $(srcdir)/unicode/*.h

STATIC_OBJECTS = $(OBJECTS:.o=.$(STATIC_O))

DEPS = $(OBJECTS:.o=.d)

-include Makefile.local

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
	$(RMV) Makefile

check-local:

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
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
