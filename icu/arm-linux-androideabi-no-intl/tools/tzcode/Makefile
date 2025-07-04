# Copyright (C) 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html
# Some Portions Copyright (c) 2006-2012 IBM and others. All Rights Reserved.

srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source/tools/tzcode
top_srcdir = /mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/source

top_builddir = ../..

subdir = tools/tzcode

include $(top_builddir)/icudefs.mk

ifeq ($(TZDATA),)
TZDATA = $(firstword $(wildcard ./tzdata*.tar.gz) $(wildcard $(srcdir)/tzdata*.tar.gz))
endif
ifeq ($(TZCODE),)
TZCODE = $(firstword $(wildcard ./tzcode*.tar.gz) $(wildcard $(srcdir)/tzcode*.tar.gz))
endif


PRIMARY_YDATA=	africa antarctica asia australasia \
		europe northamerica southamerica
YDATA=		$(PRIMARY_YDATA) pacificnew etcetera factory backward
NDATA=		systemv
SDATA=		solar87 solar88 solar89
#TDATA=		$(YDATA) $(NDATA) $(SDATA)
TDATA=		$(YDATA) $(NDATA)
YEARISTYPE=     ./yearistype

TZDIR=zoneinfo

CFLAGS+=-D_POSIX_C_SOURCE
CPPFLAGS+= -DTZDIR=\"$(TZDIR)\" 

# more data
XDATA=zone.tab yearistype.sh leapseconds iso3166.tab
ICUDATA=ZoneMetaData.java icu_zone.txt tz2icu zoneinfo64.txt zoneinfo.txt

VANGUARD_DIR= ./vanguard

# For TZ DB/ICU comparison
TZORIG=./tzorig
TZORIG_TZDIR=./tzorig/tzdir
TZORIG_ABS := $(shell pwd)/tzorig
TZORIG_TZDIR_ABS := $(TZORIG_ABS)/tzdir
TZORIG_OPTS := CFLAGS="-D_POSIX_C_SOURCE $(TZORIG_EXTRA_CFLAGS)" TZDIR=$(TZORIG_TZDIR_ABS)


## Options for building zdumps
ZDUMPOUT=$(shell pwd)/zdumpout
ICUZDUMPOUT=$(shell pwd)/icuzdumpout

ZDUMP_OPTS= -v -a -d $(ZDUMPOUT) -c 1902,2038 -i
ICUZDUMP_OPTS= -a -d $(ICUZDUMPOUT)

# Executables & objects
OBJECTS= zic.o localtime.o asctime.o scheck.o ialloc.o
ZICTARG=$(BINDIR)/zic$(EXEEXT)
ZICEXEC=$(TOOLBINDIR)/zic$(TOOLEXEEXT)
TZ2ICUTARG=$(BINDIR)/tz2icu$(EXEEXT)
TZ2ICUEXEC=$(TOOLBINDIR)/tz2icu$(TOOLEXEEXT)
ICUZDUMPTARG=$(BINDIR)/icuzdump$(EXEEXT)
ICUZDUMPEXEC=$(TOOLBINDIR)/icuzdump$(TOOLEXEEXT)

ifeq ($(TZDATA),)
all: 
	@echo ERROR "tzdata*.tar.gz" can\'t be found.
	@false
else
all: icu_data
endif

TZCODE_TARGETS= tzorig check-dump

ifeq ($(TZCODE),)
# we're broken.
$(TZCODE_TARGETS):
	@echo ERROR "tzcode*.tar.gz" can\'t be found.
	@false

else
ifeq ($(TZDATA),)
# we're broken.
$(TZCODE_TARGETS):
	@echo ERROR "tzdata*.tar.gz" can\'t be found.
	@false
else
tzorig:	$(TZCODE) $(TZDATA)
	-$(RMV) ./tzorig/
	mkdir $@
	mkdir $(TZORIG_TZDIR)
	gunzip -d < $(TZDATA) | ( cd $@ ; tar xf - )
	gunzip -d < $(TZCODE) | ( cd $@ ; tar xf - )
	for tzfile in $(TDATA) ; do \
		mv $(TZORIG)/$$tzfile $(TZORIG)/$$tzfile.bak && \
		awk -v DATAFORM=rearguard -f $(TZORIG)/ziguard.awk $(TZORIG)/$$tzfile.bak > $(TZORIG)/$$tzfile; \
	done
	-mv $(TZORIG)/zdump.c $(TZORIG)/zdump.c.orig
	cp $(srcdir)/zdump.c $(TZORIG)/zdump.c
	-mv $(TZORIG)/factory $(TZORIG)/factory.orig
	cat $(TZORIG)/factory.orig $(srcdir)/icuzones > $(TZORIG)/factory
	-mv $(TZORIG)/zishrink.awk $(TZORIG)/zishrink.awk.orig
	sed -e '/if (line ~ \/^R SystemV \/) return/s/^/#/' $(TZORIG)/zishrink.awk.orig > $(TZORIG)/zishrink.awk
	-mv $(TZORIG)/Makefile $(TZORIG)/Makefile.orig
	sed -e "s/^BACKWARD=.*/BACKWARD= backward pacificnew/" $(TZORIG)/Makefile.orig > $(TZORIG)/Makefile
	$(MAKE) -C $@ $(TZORIG_OPTS) zdump zones

$(ZDUMPOUT): tzorig
	( cd $(TZORIG) ; ./zdump$(EXEEXT) $(ZDUMP_OPTS) )
	find $(ZDUMPOUT) -name '*--ICU' -exec sh -c 'mv "$${0}" $${0%--ICU}' {} \;

dump-out: $(ZDUMPOUT) $(ICUZDUMPOUT)

check-dump: dump-out
	diff -r zdumpout icuzdumpout

endif
endif

$(ICUZDUMPOUT): $(ICUZDUMPEXEC)
	-$(RMV) $(ICUZDUMPOUT)
	-mkdir $(ICUZDUMPOUT)
	$(INVOKE) $(ICUZDUMPEXEC) $(ICUZDUMP_OPTS)


#
# old 'tz' rules start here
#


$(ZICTARG):		$(OBJECTS) $(TDATA) yearistype $(srcdir)/tz2icu.h
		$(CC) $(CFLAGS) $(TZORIG_EXTRA_CFLAGS) $(LFLAGS) -I$(srcdir) $(OBJECTS) $(LDLIBS) -o $@

$(TZ2ICUTARG):	$(srcdir)/tz2icu.cpp $(srcdir)/tz2icu.h
		$(CXX) $(CXXFLAGS) -I$(srcdir) -I$(top_srcdir)/common $(srcdir)/tz2icu.cpp -o $@

$(ICUZDUMPTARG):	$(srcdir)/icuzdump.cpp
		$(LINK.cc)  -I$(srcdir) -I$(top_srcdir)/common -I$(top_srcdir)/i18n -I$(top_srcdir)/tools/toolutil -I$(top_srcdir)/io  -pedantic $(srcdir)/icuzdump.cpp $(LIBICUUC) $(LIBICUDT) $(LIBICUI18N) $(LIBICUIO) $(LIBICUTOOLUTIL) -o $@


$(TDATA): tdatamarker

tdatamarker: $(TZDATA)
	mkdir $(VANGUARD_DIR)
	gunzip -d < $(TZDATA) | tar xf - --exclude=Makefile
	for tzfile in $(TDATA) ; do \
		mv $$tzfile $(VANGUARD_DIR)/$$tzfile && \
		awk -v DATAFORM=rearguard -f ziguard.awk $(VANGUARD_DIR)/$$tzfile > $$tzfile; \
	done
	touch $@

yearistype:	yearistype.sh
		cp yearistype.sh yearistype
		chmod +x yearistype

posix_only:	$(ZICEXEC) $(TDATA) $(srcdir)/icuzones
		$(ZICEXEC) -y $(YEARISTYPE) -d $(TZDIR) -L /dev/null $(TDATA) $(srcdir)/icuzones


icu_data:	$(TZ2ICUEXEC) posix_only
		$(TZ2ICUEXEC) $(TZDIR) zone.tab `echo $(TZDATA) | sed -e "s/.*\/tzdata//;s/\.tar\.gz$$//"`
		$(TZ2ICUEXEC) $(TZDIR) zone.tab `echo $(TZDATA) | sed -e "s/.*\/tzdata//;s/\.tar\.gz$$//"` --old

clean:
		-rm -f core *.o *.out zdump${EXEEXT} $(ZICTARG) yearistype date $(TZ2ICUTARG)
		@echo ICU specific cleanup:
		-rm -f $(ICUDATA)
		-rm -rf $(TZDIR)
		-rm -rf $(VANGUARD_DIR)
		-$(RMV) $(ICUZDUMPTARG) tzorig ./zdumpout/ ./icuzdumpout/
ifneq ($(TZDATA),)
		-rm -rf `gunzip -d < $(TZDATA) | tar tf - --exclude=Makefile | grep -o '[^ ]*$$' | tr '\n' ' '`
		-rm -f tdatamarker
endif

checkclean:

dataclean: clean
	-rm -f $(TDATA) $(XDATA)

distclean:	dataclean clean
	-rm -f Makefile

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	&& CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status


