// genesis

//
// piriform_fb_fb_connect.g: synaptic connections from the feedback
//     inhibitory interneurons to other feedback inhibitory interneurons.
//

//
// Inhibitory connections between inhibitory interneurons have been
// reported in a few studies:
//
//     -- Satou et al., J. Neurophys. 48:1157-1163 (1982)82,
//     -- Haberly et. al. J. Comp. Neurol. 266:269-290 (1987)
//     -- Ekstrand and Haberly Soc. Neurosci. Abstr. 21:1186 (1995)
//
// but little is known about them.  I'm including them in this model
// because I suspect they may have a significant role to play.
//

if (FB_FB_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up feedback interneuron -> feedback interneuron
    echo     synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (FB_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

// NOTE: we set up a desthole to prevent the cells from projecting
//       to themselves. DELTA is a small nominal value.

piriform_volume_connect \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_spikegen               \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_fb_inh_syn             \
    -relative                                                       \
    -sourceall                                                      \
    -destmask ellipsoid 0.0 0.0 0.0                                 \
        {FB_FB_CONNECTION_X_EXTENT}                                 \
        {FB_FB_CONNECTION_Y_EXTENT}                                 \
        {FB_FB_CONNECTION_Z_EXTENT}                                 \
    -desthole ellipsoid 0.0 0.0 0.0 {DELTA} {DELTA} {DELTA}         \
    -probability {FB_FB_CONNECTION_PROB}                            \
    -verbose {FB_FB_VERBOSE} -debug {FB_FB_DEBUG}


if (FB_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_set_associational_weights                                  \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_spikegen               \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_fb_inh_syn             \
    -expdecay {FB_FB_MAX_WT} {FB_FB_MIN_WT} {FB_FB_DECAY_RATE} 0.0  \
    -gaussian {FB_FB_STDEV} {FB_FB_MAXDEV}                          \
    -verbose {FB_FB_VERBOSE} -debug {FB_FB_DEBUG}


if (FB_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end

piriform_set_associational_delays                           \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_spikegen       \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_fb_inh_syn     \
    -vel_lognormal {PIRIFORM_FB_FB_VELOCITY_MODE}           \
                   {PIRIFORM_FB_FB_VELOCITY_MEDIAN}         \
    -mindelay {sim_mindelay}                                \
    -verbose {FB_FB_VERBOSE} -debug {FB_FB_DEBUG}


if (FB_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Normalizing synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_normalize_synapses  \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_fb_inh_syn     \
    {PIRIFORM_NFB_FB_SYNAPSES}                              \
    -source_element_name fb_spikegen                        \
    -sourceall                                              \
    -gaussian {FB_FB_STDEV} {FB_FB_MAXDEV}                  \
    -debug {FB_FB_DEBUG}


//
// Function to dump the fb->fb weights to an xview file.
//

function dump_fb_fb_weights
    if (FB_FB_VERBOSE >= 0)
        echo "Dumping weights from fb_inhib cell spikegens " -n
        echo "to fb_inhib cell synchans..."
    end

    piriform_dump_synaptic_weights  \
        /piriform_cortex/fb_inhib_cell[]/soma/fb_fb_inh_syn             \
        {outdir_syn}/nsyn_fb_to_fb                                      \
        -source_element_name fb_spikegen                                \
        -sourceall                                                      \
        -xview_format                                                   \
             {PIRIFORM_NX_FB_INHIB} {PIRIFORM_NY_FB_INHIB}              \
             0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}            \
        -debug {DUMP_WEIGHTS_DEBUG}
end
