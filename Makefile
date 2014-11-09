MAKECMD = make
LIBAMPLHOME = ${PWD}
AMPLDIR = $(LIBAMPLHOME)/Src
AMPLSOLVERS = $(AMPLDIR)/solvers

# See if we are running on Darwin
ifneq ($(strip $(shell uname -a | grep -i 'darwin')),)
	PLATFORM = Mac
	SOEXT = dylib
	AOUT = a.out
else
ifneq ($(strip $(shell uname -a | grep -i 'msys')),)
	PLATFORM = Msys
	SOEXT = so
	AOUT = a.exe
else
	PLATFORM = Linux
	SOEXT = so
	AOUT = a.out
endif
endif

MAKEOPTIONS = "LIBAMPLHOME=$(LIBAMPLHOME)" "SOEXT=$(SOEXT)" "PLATFORM=$(PLATFORM)" "AOUT=$(AOUT)"

FILE_LIST = COPYING-GLPL INSTALL LICENSE README Makefile \
	Src/get_ampl_library Src/Makefile Arch

all:
	cd $(LIBAMPLHOME) ; \
	if [ ! -d Lib ]; then \
		mkdir Lib ; \
	fi ; \
	cd $(AMPLDIR) ; \
	if [ ! -d solvers ]; then \
		echo ; echo "Fetching AMPL Library source code ..." ; echo ; \
	fi ; \
	sh ./get_ampl_library ; \
	echo ; echo "Building AMPL Library ..." ; echo ; \
	cd $(AMPLSOLVERS) ; \
	$(MAKECMD) -f $(LIBAMPLHOME)/Src/Makefile $(MAKEOPTIONS) arith.h libampl.$(SOEXT) libfuncadd0.$(SOEXT) ; \
	cd $(LIBAMPLHOME) ;

libampl.tar.bz2:
	tar jcvf $@ $(FILE_LIST)

clean:
	cd $(AMPLSOLVERS) ; \
	$(MAKECMD) -f $(LIBAMPLHOME)/Src/Makefile-Ampl-Lib $(MAKEOPTIONS) clean ; \
	cd $(LIBAMPLHOME) ;

veryclean: clean
	cd Lib ; \
	rm -f libampl.$(SOEXT) libfuncadd0.$(SOEXT) ;

mrclean: veryclean

purge: mrclean
	cd Src ; \
	rm -rf solvers ;

distclean: mrclean
