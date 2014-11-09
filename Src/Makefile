LIBAMPLHOME = ..                                                                
PLATFORM ?= Linux
AOUT ?= a.out

# Include standard Makefile.
include $(LIBAMPLHOME)/Src/solvers/makefile.u

# Cancel compilation rule.
%.o : %.c

# Assume we build with gcc unless stated otherwise
ifeq ($(strip $(shell ls $(LIBAMPLHOME)/Arch/$(PLATFORM)/makedefs-cpp)),)
include $(LIBAMPLHOME)/Arch/$(PLATFORM)/makedefs-gcc
else
include $(LIBAMPLHOME)/Arch/$(PLATFORM)/makedefs-cpp
endif

CXX_AMPL_FLGS = -DNON_STDIO -I.
CXX_COMPILE = $(CXX) $(CXX_OPT_FLGS) $(CXX_DBG_FLGS) $(CXX_AMPL_FLGS)
SHELL=/bin/sh
SOEXT ?= so

CC = $(CXX_COMPILE)
CFLAGS =

libampl.$(SOEXT): arith.h stdio1.h $(LIBAMPLHOME)/Lib/libampl.$(SOEXT)

ifeq ($(PLATFORM),Msys)
xectim.o: xectim.c
	$(CXX_COMPILE) -c $(CXX_DYN_FLGS) -D__STDC__ -DNO_RUSAGE xectim.c
else
xectim.o: xectim.c
	$(CXX_COMPILE) -c $(CXX_DYN_FLGS) xectim.c
endif

$(LIBAMPLHOME)/Lib/libampl.$(SOEXT): $a
	$(CXX_COMPILE) $(CXX_DYN_FLGS) -c $a
	$(CXX_COMPILE) $(CXX_SHAR_LIB) -o $@ ${a:.c=.o}

libfuncadd0.$(SOEXT): arith.h stdio1.h $(LIBAMPLHOME)/Lib/libfuncadd0.$(SOEXT)

$(LIBAMPLHOME)/Lib/libfuncadd0.$(SOEXT): funcadd0.c
	$(CXX_COMPILE) $(CXX_DYN_FLGS) -c $?
	$(CXX_COMPILE) $(CXX_SHAR_LIB) -o $@ ${?:.c=.o}

purge: clean
	rm -f Lib/libfuncadd0.$(SOEXT) Lib/libampl.$(SOEXT)
