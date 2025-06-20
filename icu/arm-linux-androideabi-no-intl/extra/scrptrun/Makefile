## Copyright (C) 2016 and later: Unicode, Inc. and others.
## License & terms of use: http://www.unicode.org/copyright.html
## Makefile.in for ICU - extra/scrptrun
## Copyright (c) 2001-2011, International Business Machines Corporation and
## others. All Rights Reserved.

## Source directory information
srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/extra/scrptrun
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ../..

include $(top_builddir)/icudefs.mk

## Platform-specific setup
include $(top_srcdir)/config/mh-linux

## Build directory information
subdir = extra/scrptrun

## Extra files to remove for 'make clean'
CLEANFILES = *~ $(DEPS)

## Target information
TARGET = srtest

DEFS = -DPACKAGE_NAME=\"ICU\" -DPACKAGE_TARNAME=\"International\ Components\ for\ Unicode\" -DPACKAGE_VERSION=\"64.2\" -DPACKAGE_STRING=\"ICU\ 64.2\" -DPACKAGE_BUGREPORT=\"http://icu-project.org/bugs\" -DPACKAGE_URL=\"http://icu-project.org\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DSIZEOF_VOID_P=4 -DHAVE_LIBM=1 -DHAVE_ELF_H=1 -DHAVE_GETTIMEOFDAY=1 -DHAVE_INTTYPES_H=1 -DHAVE_DIRENT_H=1 -DHAVE_WCHAR_H=1 -DSIZEOF_WCHAR_T=4
CPPFLAGS =  -ffunction-sections -fdata-sections $(THREADSCPPFLAGS)  -DU_HAVE_ELF_H=1 -DU_ENABLE_DYLOAD=0 -DU_HAVE_STRTOD_L=0  -I$(top_srcdir)/common -I$(top_srcdir) 
CFLAGS =  -fstack-protector -ffunction-sections -fomit-frame-pointer -fno-strict-aliasing -funwind-tables -DPIC -fPIC -fvisibility=hidden -DCUSTOMIZE_REACT_NATIVE -DUCONFIG_NO_COLLATION=1 -DUCONFIG_NO_FORMATTING=1 -DNDEBUG -g0 -Oz -flto=full -D__ANDROID_MIN_SDK_VERSION__=24   -Oz $(THREADSCFLAGS) 
CXXFLAGS =    -fstack-protector -ffunction-sections -fomit-frame-pointer -fno-strict-aliasing -funwind-tables -DPIC -fPIC -fvisibility=hidden -DCUSTOMIZE_REACT_NATIVE -DUCONFIG_NO_COLLATION=1 -DUCONFIG_NO_FORMATTING=1 -DNDEBUG -g0 -Oz -flto=full -D__ANDROID_MIN_SDK_VERSION__=24   -Oz -Oz -std=c++11 $(THREADSCXXFLAGS) 
ENABLE_RPATH = NO
ifeq ($(ENABLE_RPATH),YES)
RPATHLDFLAGS = $(LD_RPATH)$(LD_RPATH_PRE)$(libdir)
endif
LDFLAGS =  -Wl,-z,noexecstack -Wl,--gc-sections -Wl,--exclude-libs,libgcc.a -Wl,--no-undefined -Wl,-z,max-page-size=16384    -Wl,--gc-sections $(RPATHLDFLAGS)
LIBS = $(LIBICUUC) -lm  

OBJECTS = scrptrun.o srtest.o

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

all-local: $(TARGET)

install-local:

dist-local:

clean-local:
	test -z "$(CLEANFILES)" || $(RMV) $(CLEANFILES)
	$(RMV) $(OBJECTS) $(TARGET)

distclean-local: clean-local
	$(RMV) Makefile

check-local: all-local

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	 && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

$(TARGET) : $(OBJECTS)
	$(LINK.cc) -o $@ $^ $(LIBS)
	$(POST_BUILD_STEP)

invoke:
	ICU_DATA=$${ICU_DATA:-$(top_builddir)/data/} TZ=PST8PDT $(INVOKE) $(INVOCATION)

ifeq (,$(MAKECMDGOALS))
-include $(DEPS)
else
ifneq ($(patsubst %clean,,$(MAKECMDGOALS)),)
-include $(DEPS)
endif
endif
