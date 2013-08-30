// genesis

//
// piriform_pyr_ff_fb_connect.g: synaptic connections from the pyramidal
//     cells to the feedforward/feedback inhibitory interneurons.
//

if (PYR_FF_FB_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up pyramidal cell -> feedforward/feedback interneuron
    echo     synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (PYR_FF_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

piriform_volume_connect \
    /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_assoc_exc_syn       \
    -relative                                                       \
    -sourceall                                                      \
    -destmask ellipsoid 0.0 0.0 0.0                                 \
        {PYR_FF_FB_CONNECTION_X_EXTENT}                             \
        {PYR_FF_FB_CONNECTION_Y_EXTENT}                             \
        {PYR_FF_FB_CONNECTION_Z_EXTENT}                             \
    -probability {PYR_FF_FB_CONNECTION_PROB}                        \
    -verbose {PYR_FF_FB_VERBOSE} -debug {PYR_FF_FB_DEBUG}


if (PYR_FF_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_set_associational_weights                                  \
    /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_assoc_exc_syn       \
    -expdecay {PYR_FF_FB_MAX_WT} {PYR_FF_FB_MIN_WT}                 \
        {PYR_FF_FB_DECAY_RATE} 0.0                                  \
    -gaussian {PYR_FF_FB_STDEV} {PYR_FF_FB_MAXDEV}                  \
    -verbose {PYR_FF_FB_VERBOSE} -debug {PYR_FF_FB_DEBUG}


if (PYR_FF_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end

piriform_set_associational_delays                               \
    /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen         \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_assoc_exc_syn   \
    -vel_lognormal {PIRIFORM_PYR_FF_FB_VELOCITY_MODE}           \
                   {PIRIFORM_PYR_FF_FB_VELOCITY_MEDIAN}         \
    -mindelay {sim_mindelay}                                    \
    -verbose {PYR_FF_FB_VERBOSE} -debug {PYR_FF_FB_DEBUG}


if (PYR_FF_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Normalizing synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_normalize_synapses  \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_assoc_exc_syn   \
    {PIRIFORM_NPYR_FF_FB_SYNAPSES}                              \
    -source_element_name pyr_spikegen                           \
    -sourceall                                                  \
    -gaussian {PYR_FF_FB_STDEV} {PYR_FF_FB_MAXDEV}              \
    -debug {PYR_FF_FB_DEBUG}


//
// Function to dump the pyr->ff_fb weights to an xview file.
//

function dump_pyr_ff_fb_weights
    if (PYR_FF_FB_VERBOSE >= 0)
        echo "Dumping weights from pyramidal cell spikegens " -n
        echo "to ff_fb_inhib cell synchans..."
    end

    piriform_dump_synaptic_weights  \
        /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_assoc_exc_syn       \
        {outdir_syn}/nsyn_pyr_to_ff_fb                                  \
        -source_element_name pyr_spikegen                               \
        -sourceall                                                      \
        -xview_format                                                   \
             {PIRIFORM_NX_FF_FB_INHIB} {PIRIFORM_NY_FF_FB_INHIB}        \
             0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}            \
        -debug {DUMP_WEIGHTS_DEBUG}
end

