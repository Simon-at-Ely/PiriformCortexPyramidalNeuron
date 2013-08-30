// genesis

//
// piriform_inputs.g: setting up the olfactory_bulb spike-generating
//                    object and an array of pseudo-mitral cells.
//

extern get_NE
extern set_up_surface_field_electrodes
extern set_up_depth_field_electrodes
extern dump_weights

// Q: should I have neuromodulation in OB object?

int OB_output = 1
int OB_flush  = 1

//
// Global variable for shock strength implemented as a modulation of the
// afferent input weights.
//

float shock_strength = 1.0


// ----------------------------------------------------------------------
// Make the olfactory_bulb object and the supporting odor_in object.
// ----------------------------------------------------------------------

function make_OB(ncells)
    int ncells

    create neutral /bulb
    create olfactory_bulb /bulb/OB

    setfield ^  \
           isi->filename      "ob_isi"          \
           isi->nscalef       11                \
           ncells             {ncells}          \
           output->enabled    {OB_output}       \
           output->flush      {OB_flush}        \
           output->filename   {outdir}/ob.out   \
           bg_odor            0                 \
           max_odors          4                 \
           coding_mode        2                 \
           mod_index          10

    call /bulb/OB INITIALIZE

    create odor_in /odors
    addmsg /odors /bulb/OB ODOR odor conc
end


// ----------------------------------------------------------------------
// Shock paradigms.
// ----------------------------------------------------------------------

function set_up_shock(intensity)
    float intensity

    setfield /bulb/OB coding_mode 2

    // Load odor response data for synchrony coding.
    // Get the sync_activities file name.  All cells are considered
    // active.

    // weak shock activities...
    str sync_file = "bulb_sync_activities_shock_960_4"

    setfield /bulb/OB \
        sync_code->sync_events_filename      "bulb_sync_spike_events_shock_4" \
        sync_code->sync_activities_filename  {sync_file}    \
        sync_code->sync_mode                 0              \
        sync_code->width                     0.0001         \
        sync_code->sync_duration            -1.0            \
        sync_code->nrsb                      0


    // Use the intensity as a probability of spiking for each cell.
    assert {(intensity >= 0.0) && (intensity <= 1.0)}
    setfield /bulb/OB sync_code->event_prob {intensity}

    call /bulb/OB LOADSYNCINFO

    setfield /odors filename "odor_events_multi_shock"
end


// ----------------------------------------------------------------------
// Rate coding paradigms.
// ----------------------------------------------------------------------

// Change the background firing rate of the OB object.

function set_OB_rate_mod(rate_mod)
    float rate_mod

    setfield /bulb/OB isi->ratescale {rate_mod}
end


// Set up a theta-modulated background firing rate in the OB object.

function set_up_OB_theta(rate, amplitude, maxtime)
    float rate, amplitude, maxtime

    str rate_filename = "bulb_theta_rate_modulation"

    // Create the rate modulation file.
    // This calls a python script which generates the needed file.
    sh make_odor_theta_rate_modulation \
       {rate} {amplitude} {maxtime} {rate_filename}

    setfield /bulb/OB coding_mode 1

    // These files make all cells part of the pattern.
    setfield /bulb/OB patterns_filename "bulb_odor_patterns_1000"

    call /bulb/OB INITRATEINFO
    call /bulb/OB LOADPATTERNS

    // Load odor response data.
    setfield /bulb/OB rate_code->filename {rate_filename}
    call /bulb/OB LOADRATEINFO

    // You need an odor_in object to turn on the rate coding,

    setfield /odors filename "odor_events_theta"
end



// Set up a rate-code paradigm for after a shock stimulus.

function set_up_OB_shock_rate(event_filename, minrate, maxtime)
    str   event_filename
    float minrate, maxtime

    str rate_filename = "bulb_shock_rate_modulation"

    // Create the rate modulation file.
    // This calls a python script which generates the needed file.
    sh make_odor_shock_rate_modulation \
        {rate_filename} {minrate} {maxtime}

    setfield /bulb/OB coding_mode 1

    // These files make all cells part of the pattern.
    setfield /bulb/OB patterns_filename "bulb_odor_patterns_1000"

    call /bulb/OB INITRATEINFO
    call /bulb/OB LOADPATTERNS

    // Load odor response data.
    setfield /bulb/OB rate_code->filename {rate_filename}
    call /bulb/OB LOADRATEINFO

    // You need an odor_in object to turn on the rate coding,

    setfield /odors filename {event_filename}
end


// ----------------------------------------------------------------------
// Hybrid rate coding/synchrony coding paradigms.
// ----------------------------------------------------------------------

//
// This paradigm is used to model the case where a shock stimulus
// not only causes a large number of cells to fire synchronously,
// but also depresses the background firing rate for some period of
// time after the shock.  There is substantial indirect experimental
// evidence that this can/does happen (e.g. see Shepherd's chapter in
// SOB 4th ed.), although the precise details are unavailable.
//

function set_up_shock_with_bg_modulation(intensity, event_filename, \
        minrate, maxtime)
    float intensity         // shock intensity
    str   event_filename    // rate modulation event filename
    float minrate, maxtime  // rate modulation minimum rate and maxtime

    // NOTE: the synchrony (shock) and rate coding modes are independent
    // but mutually exclusive.  To switch between them we have to
    // manually tweak the `coding_mode' field after the shock is finished.
    // FIXME: this is lame and should be built-in to the olfactory_bulb
    // object, ideally as an array of coding_mode fields that correspond
    // to each "odor".  Then this paradigm could be modeled as one odor
    // that produces the shock followed immediately by another odor that
    // produces the rate modulation.

    set_up_shock {intensity}
    set_up_OB_shock_rate {event_filename} {minrate} {maxtime}
end


// ----------------------------------------------------------------------
// Convenience functions.  These determine the coding paradigm and are
// called from the toplevel file.
// ----------------------------------------------------------------------

//
// Functions to run the simulation itself.
//

// ======== Background activity only paradigm. ========

function run_bg(csd)
    int csd

    float tmax = 0.250   // one canonical time slice

    setfield /bulb/OB coding_mode 0  // background input only

    if ({exists /field})
        delete /field
    end

    if (csd)
        set_up_depth_field_electrodes
    end

    set_up_surface_field_electrodes {FP_SURFACE_FIELD_LOCATION} 8 6

    piriform_reset
    piriform_check
    dump_weights

    int i
    for (i = 0; i < 2; i = i + 1)
        run_sim {tmax}
        beep
    end

    if ({get_NE} <= 0.0)
        sh label_data_files {outdir} bg \
            weak strong eeg \
            bgNE weakNE strongNE eegNE
    else
        sh label_data_files {outdir} bgNE \
            weakNE strongNE eegNE \
            bg weak strong eeg
    end
end


// ======== Weak shock paradigm. ========

function run_weak_shock_no_bg_rate_mod(csd)
    int csd

    float tmax = 0.300

    set_up_shock 1.0  // Probability of spiking = 1.0

    if ({exists /field})
        delete /field
    end

    if (csd)
        set_up_depth_field_electrodes
    end

    set_up_surface_field_electrodes {FP_SURFACE_FIELD_LOCATION} 8 6

    piriform_reset
    piriform_check
    dump_weights

    run_sim {tmax}
    beep

    if ({get_NE} <= 0.0)
        sh label_data_files {outdir} weak \
            strong eeg bg \
            bgNE weakNE strongNE eegNE
    else
        sh label_data_files {outdir} weakNE \
            strongNE eegNE bgNE \
            bg weak strong eeg
    end
end


function run_weak_shock(csd)
    int csd

    float tmax = 0.250   // one canonical time slice

    set_up_shock {FP_WEAK_SHOCK}
    set_up_OB_shock_rate odor_events_shock_rate {1.0 - FP_WEAK_SHOCK} 1.0

    if ({exists /field})
        delete /field
    end

    if (csd)
        set_up_depth_field_electrodes
    end

    set_up_surface_field_electrodes {FP_SURFACE_FIELD_LOCATION} 8 6

    piriform_reset
    piriform_check
    dump_weights

    setfield /bulb/OB coding_mode 2  // Synchrony coding for shock.
    run_sim 0.077
    setfield /bulb/OB coding_mode 1  // Rate coding for shock.
    run_sim 0.423

    if ({get_NE} <= 0.0)
        sh label_data_files {outdir} weak \
            strong eeg bg \
            bgNE weakNE strongNE eegNE
    else
        sh label_data_files {outdir} weakNE \
            strongNE eegNE bgNE \
            bg weak strong eeg
    end
end


// ======== Strong shock paradigm. ========

function run_strong_shock_no_bg_rate_mod(csd)
    int csd

    float tmax = 0.250   // one canonical time slice

    set_up_shock {FP_STRONG_SHOCK}

    if ({exists /field})
        delete /field
    end

    if (csd)
        set_up_depth_field_electrodes
    end

    set_up_surface_field_electrodes {FP_SURFACE_FIELD_LOCATION} 8 6

    piriform_reset
    piriform_check
    dump_weights

    int i
    for (i = 0; i < 1; i = i + 1)
        run_sim {tmax}
        beep
    end

    if ({get_NE} <= 0.0)
        sh label_data_files {outdir} strong \
            eeg bg weak \
            bgNE weakNE strongNE eegNE
    else
        sh label_data_files {outdir} strongNE \
            eegNE bgNE weakNE \
            bg weak strong eeg
    end
end


function run_strong_shock(csd)
    int csd

    float tmax = 0.250   // one canonical time slice

    set_up_shock {FP_STRONG_SHOCK}
    set_up_OB_shock_rate odor_events_shock_rate 0.0 1.0

    if ({exists /field})
        delete /field
    end

    if (csd)
        set_up_depth_field_electrodes
    end

    set_up_surface_field_electrodes {FP_SURFACE_FIELD_LOCATION} 8 6

    piriform_reset
    piriform_check
    dump_weights

    setfield /bulb/OB coding_mode 2  // Synchrony coding for shock.
    run_sim 0.077
    setfield /bulb/OB coding_mode 1  // Rate coding for shock.
    run_sim 0.173 // 0.223

    if ({get_NE} <= 0.0)
        sh label_data_files {outdir} strong \
            eeg bg weak \
            bgNE weakNE strongNE eegNE
    else
        sh label_data_files {outdir} strongNE \
            eegNE bgNE weakNE \
            bg weak strong eeg
    end
end


// ======== EEG paradigm. ========

function run_eeg(csd)
    int csd

    float tmax = 0.250   // one canonical time slice

    setfield /bulb/OB coding_mode 0  // background input only

    set_OB_rate_mod 2.0

    if ({exists /field})
        delete /field
    end

    if (csd)
        set_up_depth_field_electrodes
    end

    set_up_surface_field_electrodes {FP_SURFACE_FIELD_LOCATION} 8 6

    piriform_reset
    piriform_check
    dump_weights

    int i
    for (i = 0; i < 8; i = i + 1)
        run_sim {tmax}
        beep
    end

    if ({get_NE} <= 0.0)
        sh label_data_files {outdir} eeg \
            bg weak strong \
            bgNE weakNE strongNE eegNE
    else
        sh label_data_files {outdir} eegNE \
            bgNE weakNE strongNE \
            bg weak strong eeg
    end
end



// ----------------------------------------------------------------------
// Create the olfactory bulb object.
// ----------------------------------------------------------------------

make_OB {BULB_N}


// ----------------------------------------------------------------------
// Make a `spikebuffer' object in the library, and call it a mitral cell.
// It takes spike inputs from a particular cell in the olfactory_bulb
// object and sends them on to the piriform cortex model.
// ----------------------------------------------------------------------

function make_mitral_cell
    if (!{exists /cell_library})
        create neutral /cell_library
        disable /cell_library
    end

    // Create the spikebuffer object as a mitral cell.
    create spikebuffer /cell_library/mitral_cell
end

make_mitral_cell



// ----------------------------------------------------------------------
// Create the array of olfactory bulb "mitral cells".
// ----------------------------------------------------------------------

echo Creating {BULB_N} mitral cells.

create_element_grid /cell_library/mitral_cell   \
        /bulb                                   \
        {BULB_NX}                               \
        {BULB_NY}                               \
        -delta      {BULB_DX}                   \
                    {BULB_DY}                   \
        -origin     {BULB_X_OFFSET}             \
                    {BULB_Y_OFFSET}             \
        -zposition  {BULB_Z_OFFSET}             \
        -debug      0


// A utility function, mainly for debugging:

function show_mitral_cell_positions(fileflag, filename)
    int fileflag
    str filename

    float x, y, z
    int i

    if (fileflag)
        clearfile {filename}
    end

    for (i = 0; i < {BULB_N}; i = i + 1)
        x = {getfield /bulb/mitral_cell[{i}] x}
        y = {getfield /bulb/mitral_cell[{i}] y}
        z = {getfield /bulb/mitral_cell[{i}] z}

        if (fileflag)
            echo mitral {i}: {x} {y} {z} >> {filename}
        else
            echo Mitral cell {i}: x = {x} y = {y} z = {z}
        end
    end
end


// ----------------------------------------------------------------------
// Connect the olfactory_bulb object to the mitral cell array.
// Sounds like a contradiction, huh? :-)  It's not.  The "mitral cells"
// are just there to relay the spikes from the olfactory_bulb object to
// piriform cortex.  They allow us to use reasonably standard connection
// commands to set up the afferents.
// ----------------------------------------------------------------------

function set_up_OB_messages
    int i

    for (i = 0; i < {BULB_N}; i = i + 1)
        addmsg /bulb/OB /bulb/mitral_cell[{i}] SPIKE
    end
end

set_up_OB_messages



