#
# Makefile for piriform cortex simulation.
#

SHELL   = /bin/sh
DEBUG   =
PROFILE =

ifdef DEBUG
GENESIS = nxgenesis_debug
else
  ifdef PROFILE
GENESIS = nxgenesis_profile
  else
GENESIS = nxgenesis
  endif
endif

# Output data files, mainly xview stuff:
DATAFILES       = ob.out pyramidal_Ia_1 \
                  pyramidal_basal_3 pyramidal_deepIb_2 \
                  pyramidal_soma pyramidal_supIb_2 \
                  ff ff_fb fb \
                  pyramidal_positions fb_inhib_positions \
                  ff_inhib_positions ff_fb_inhib_positions \
                  mitral_positions all_positions nsyn_* *_spikes \
                  xview_*_field* xplot_field* \
                  matlab_*_field* avg_field

# Xplot files:
XPLOTFILES      = test_pyramidal* test_fb* test_ff*

CLEANFILES      = $(DATAFILES) time.out xview.data 

REALCLEANFILES  = $(XPLOTFILES) *.all gmon.out profile.out

SAVEFILES       = *.save*

default: nothing

nothing:
	@echo "Please select a Makefile target!"

run: realclean
	$(GENESIS) piriform.g

#
# Run specific kinds of simulations.
#

bg: realclean
	$(GENESIS) piriform_bg.g

bgNE: realclean
	$(GENESIS) piriform_bgNE.g

weak: realclean
	$(GENESIS) piriform_weak.g

weakNE: realclean
	$(GENESIS) piriform_weakNE.g

strong: realclean
	$(GENESIS) piriform_strong.g

strongNE: realclean
	$(GENESIS) piriform_strongNE.g

eeg: realclean
	$(GENESIS) piriform_eeg.g

eegNE: realclean
	$(GENESIS) piriform_eegNE.g

#
# Calculate steady states of neurons.
# This needs to be done once before doing the other kinds
# of simulations.
#

ss: realclean
	$(GENESIS) piriform_ss.g

# Use these for whatever combinations of the above you want.

series1: bg weak strong bgNE

series1a: weak strong

series2: weakNE strongNE

series_noNE: ss bg weak strong eeg

series_NE: ss bgNE weakNE strongNE eegNE


# This is OK for non-interactive work, but due to buffering
# you won't see anything on the screen for a long time.
time:
	if [ -f time.out ]; then rm time.out; fi
	/usr/bin/time $(GENESIS) piriform.g | tee time.out

# This is better for interactive work.
time2:
	/usr/bin/time $(GENESIS) piriform.g 

debug:
	gdb $(GENESIS) 

# Profiling.

profile:
	@if [ -f profile.out ]; then rm profile.out; fi
	gprof /home/mvanier/local/Linux/bin/$(GENESIS) > profile.out


# Cleanup.

clean:
	@for file in $(CLEANFILES); do \
    if [ -f $$file ]; then rm $$file; fi; done

realclean: clean
	@for file in $(REALCLEANFILES); do \
    if [ -f $$file ]; then rm $$file; fi; done

ultraclean: realclean
	@for file in $(SAVEFILES); do \
    if [ -f $$file ]; then rm $$file; fi; done


problems:
	egrep "CHECKME|FIXME|Q|TODO|WARNING" *.g | more

