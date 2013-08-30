// genesis

//
// piriform_ff_fb_ff_fb_connect.g: synaptic connections from the
//     feedforward/feedback inhibitory interneurons to other
//     feedforward/feedback inhibitory interneurons.
//

//
// There is no evidence for these connections, but there is no
// evidence against them either.
//

if (FF_FB_FF_FB_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up feedback interneuron -> feedback interneuron
    echo     synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (FF_FB_FF_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

// NOTE: we set up a desthole to prevent the cells from projecting
//       to themselves. DELTA is a small nominal value.

piriform_volume_connect \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_fb_spikegen         \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_ff_inh_syn          \
    -relative                                                       \
    -sourceall                                                      \
    -destmask ellipsoid 0.0 0.0 0.0                                 \
        {FF_FB_FF_FB_CONNECTION_X_EXTENT}                           \
        {FF_FB_FF_FB_CONNECTION_Y_EXTENT}                           \
        {FF_FB_FF_FB_CONNECTION_Z_EXTENT}                           \
    -desthole ellipsoid 0.0 0.0 0.0 {DELTA} {DELTA} {DELTA}         \
    -probability {FF_FB_FF_FB_CONNECTION_PROB}                      \
    -verbose {FF_FB_FF_FB_VERBOSE} -debug {FF_FB_FF_FB_DEBUG}


if (FF_FB_FF_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_set_associational_weights                                  \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_fb_spikegen         \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_ff_inh_syn          \
    -expdecay {FF_FB_FF_FB_MAX_WT} {FF_FB_FF_FB_MIN_WT}             \
     {FF_FB_FF_FB_DECAY_RATE} 0.0                                   \
    -gaussian {FF_FB_FF_FB_STDEV} {FF_FB_FF_FB_MAXDEV}              \
    -verbose {FF_FB_FF_FB_VERBOSE} -debug {FF_FB_FF_FB_DEBUG}


if (FF_FB_FF_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end

piriform_set_associational_delays                                     \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_fb_spikegen           \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_ff_inh_syn            \
    -vel_lognormal {PIRIFORM_FF_FB_FF_FB_VELOCITY_MODE}               \
                   {PIRIFORM_FF_FB_FF_FB_VELOCITY_MEDIAN}             \
    -mindelay {sim_mindelay}                                          \
    -verbose {FF_FB_FF_FB_VERBOSE} -debug {FF_FB_FF_FB_DEBUG}


if (FF_FB_FF_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Normalizing synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_normalize_synapses  \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_ff_inh_syn  \
    {PIRIFORM_NFF_FB_FF_FB_SYNAPSES}                        \
    -source_element_name ff_fb_spikegen                     \
    -sourceall                                              \
    -gaussian {FF_FB_FF_FB_STDEV} {FF_FB_FF_FB_MAXDEV}      \
    -debug {FF_FB_FF_FB_DEBUG}


//
// Function to dump the fb->fb weights to an xview file.
//

function dump_ff_fb_ff_fb_weights
    if (FF_FB_FF_FB_VERBOSE >= 0)
        echo "Dumping weights from ff_fb_inhib cell spikegens " -n
        echo "to ff_fb_inhib cell synchans..."
    end

    piriform_dump_synaptic_weights  \
        /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_ff_inh_syn          \
        {outdir_syn}/nsyn_ff_fb_to_ff_fb                                \
        -source_element_name ff_fb_spikegen                             \
        -sourceall                                                      \
        -xview_format                                                   \
             {PIRIFORM_NX_FF_FB_INHIB} {PIRIFORM_NY_FF_FB_INHIB}        \
             0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}            \
        -debug {DUMP_WEIGHTS_DEBUG}
end

