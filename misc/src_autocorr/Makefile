# Makefile for building targets

# C compiler (gcc, icc, ...)
CCOMP=gcc

# set GSL path prefix here:
# typically it is in /usr/local
# on MacOS could be in /opt/local
GSL_PATH=/opt/local

# compiler flags
CFLAGS = -Wall -O3 -I$(GSL_PATH)/include
LIBFLAGS = -L$(GSL_PATH)/lib -lgsl -lgslcblas -lm
DEFINES =
SDEFINES =


# all targets that are built with pattern rules are listed here
executables_gen = averblock averjack jackbinaver bootstrap histogram gau_diff tau_int
executables_su2 = sample_su2_hb sample_su2_met_flat sample_su2_met_exp sample_su2_met_xn sample_su2_met_negexp
executables_gau = sample_gau_hb sample_gau_met_inv sample_gau_met_root sample_gau_met_step
objects = utils.o

# rules for object files
%.o : %.c
	$(CCOMP) $(DEFINES) $(SDEFINES) $(CFLAGS) -c -o $@ $<

# rules for single target per source file
$(executables_gen): %: %.c
	$(CCOMP) $(DEFINES) $(CFLAGS) $< -o $@ $(LIBFLAGS)

# rules for multiple targets per source file
$(executables_su2): %: sample_su2.c
	$(CCOMP) $(DEFINES) $(SDEFINES) $(CFLAGS) $< -o $@ $(LIBFLAGS)

# rules for multiple targets per source file
$(executables_gau): %: sample_gau.c $(objects)
	$(CCOMP) $(DEFINES) $(SDEFINES) $(CFLAGS) $(objects) $< -o $@ $(LIBFLAGS)

# target-specific defines
sample_su2_hb: SDEFINES=-DALG_HEATBATH
sample_su2_met_flat: SDEFINES=-DALG_MET_FLAT
sample_su2_met_exp: SDEFINES=-DALG_MET_EXP
sample_su2_met_xn: SDEFINES=-DALG_MET_XN
sample_su2_met_negexp: SDEFINES=-DALG_MET_NEGEXP

sample_gau_hb: SDEFINES=-DALG_HEATBATH
sample_gau_met_inv: SDEFINES=-DALG_MET_INV
sample_gau_met_root: SDEFINES=-DALG_MET_ROOT
sample_gau_met_step: SDEFINES=-DALG_MET_STEP


# cause rebuild if Makefile was modified
$(executables_gen): Makefile
$(executables_su2): Makefile
$(executables_gau): Makefile


# build all
all: $(executables_gen) $(executables_su2)  $(executables_gau)

# clean all
clean:
	rm -f $(executables_gen) $(executables_su2)  $(executables_gau) $(objects)


