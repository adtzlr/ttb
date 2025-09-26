# Disable the default rules
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

# Project name
NAME := ttb

# Configuration settings
FC := gfortran
AR := ar rcs
LD := $(FC)
RM := rm -f
GD := ./deps.awk

# List of all source files
SRCS := src/ttb_rotation.f90 \
        src/ttb_library.f90 \
        src/ttb_sqrt.f90 \
        src/ttb_norm.f90 \
        src/ttb_crossdyadic.f90 \
        src/ttb_sub.f90 \
        src/ttb_piola.f90 \
        src/ttb_reducedim.f90 \
        src/ttb_permute.f90 \
        src/ttb_dyadic.f90 \
        src/ttb_add.f90 \
        src/ttb_types.f90 \
        src/ttb_assign.f90 \
        src/ttb_det.f90 \
        src/ttb_assignscalar.f90 \
        src/ttb_transp.f90 \
        src/ttb_asarray.f90 \
        src/ttb_tools.f90 \
        src/ttb_dev.f90 \
        src/ttb_assignten2sym.f90 \
        src/ttb_dot.f90 \
        src/ttb_asabqarray.f90 \
        src/ttb_assignarray.f90 \
        src/ttb_ddot.f90 \
        src/ttb_div.f90 \
        src/ttb_unimodular.f90 \
        src/ttb_strainstore.f90 \
        src/ttb_inv.f90 \
        src/ttb_symstore.f90 \
        src/ttb_identity.f90 \
        src/ttb_tenstore.f90 \
        src/ttb_trace.f90 \
        src/ttb_power.f90
TEST_SRCS := app/main.f90
# Add source and tests directories to search paths
vpath % .: src
vpath % .: app

# Define a map from each file name to its object file
obj = $(src).o
$(foreach src, $(SRCS) $(TEST_SRCS), $(eval $(src) := $(obj)))

# Create lists of the build artefacts in this project
OBJS := $(addsuffix .o, $(SRCS))
DEPS := $(addsuffix .d, $(SRCS))
TEST_OBJS := $(addsuffix .o, $(TEST_SRCS))
TEST_DEPS := $(addsuffix .d, $(TEST_SRCS))
LIB := $(patsubst %, lib%.a, $(NAME))
TEST_EXE := $(patsubst %.f90, %.exe, $(TEST_SRCS))

# Declare all public targets
.PHONY: all clean
all: $(LIB) $(TEST_EXE)

# Create the static library from the object files
$(LIB): $(OBJS)
	$(AR) $@ $^

# Link the test executables
$(TEST_EXE): %.exe: %.f90.o $(LIB)
	$(LD) -o $@ $^

# Create object files from Fortran source
$(OBJS) $(TEST_OBJS): %.o: % | %.d
	$(FC) -c -o $@ $<

# Process the Fortran source for module dependencies
$(DEPS) $(TEST_DEPS): %.d: %
	$(GD) $< > $@

# Define all module interdependencies
include $(DEPS) $(TEST_DEPS)
$(foreach dep, $(OBJS) $(TEST_OBJS), $(eval $(dep): $($(dep))))

# Cleanup, filter to avoid removing source code by accident
clean:
	$(RM) $(filter %.o, $(OBJS) $(TEST_OBJS)) $(filter %.d, $(DEPS) $(TEST_DEPS)) $(filter %.exe, $(TEST_EXE)) $(LIB) $(wildcard *.mod)
