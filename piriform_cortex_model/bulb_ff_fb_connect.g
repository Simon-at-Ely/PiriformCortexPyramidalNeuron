// genesis

//
// bulb_ff_fb_connect.g: synaptic connections from the olfactory bulb
//     "mitral" cells to the superficial layer 1b feedforward/feedback
//     inhibitory neurons.
//

if (BULB_FF_FB_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up olfactory bulb -> feedforward/feedback interneuron
    echo     synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (BULB_FF_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

piriform_volume_connect  \
    /bulb/mitral_cell[]                                         \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_aff_exc_syn     \
    -sourceall                                                  \
    -destall                                                    \
    -probability {BULB_FF_FB_CONNECTION_PROB}                   \
    -verbose {BULB_FF_FB_VERBOSE} -debug {BULB_FF_FB_DEBUG}


if (BULB_FF_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_set_afferent_weights \
    /bulb/mitral_cell[]                                         \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_aff_exc_syn     \
    -expdecay1 0.0 {BULB_FF_FB_MAX_WT} {BULB_FF_FB_MIN_WT}      \
               {BULB_FF_FB_DECAY_RATE1}                         \
    -expdecay2 {BULB_FF_FB_MIN_WT} {BULB_FF_FB_DECAY_RATE2}     \
    -transition_factor {FP_LOT_TRANSITION_FACTOR}               \
    -axes {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}               \
    -gaussian {BULB_FF_FB_STDEV} {BULB_FF_FB_MAXDEV}            \
    -verbose {BULB_FF_FB_VERBOSE} -debug {BULB_FF_FB_DEBUG}


if (BULB_FF_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end

piriform_set_afferent_delays  \
    /bulb/mitral_cell[]                                                 \
    /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_aff_exc_syn             \
    -vel1 {PIRIFORM_AFFERENT_LOT_VELOCITY}                              \
    -vel2_lognormal {PIRIFORM_AFFERENT_COLLATERAL_VELOCITY_MODE}        \
                    {PIRIFORM_AFFERENT_COLLATERAL_VELOCITY_MEDIAN}      \
    -axes {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                       \
    -mindelay {sim_mindelay} -add_delay {PIRIFORM_EXTRA_FF_FB_DELAY}    \
    -verbose {BULB_FF_FB_VERBOSE} -debug {BULB_FF_FB_DEBUG}


//
// Function to dump the bulb->ff_fb weights to an xview file.
//

function dump_bulb_to_ff_fb_weights
    if (BULB_FF_FB_VERBOSE >= 0)
        echo "Dumping weights from olfactory bulb mitral cells "
        echo "    to ff_fb_inhib cell synchans..."
    end

    piriform_dump_synaptic_weights  \
        /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_aff_exc_syn     \
        {outdir_syn}/nsyn_bulb_to_ff_fb                             \
        -source_element_name mitral_cell                            \
        -sourceall                                                  \
        -xview_format                                               \
            {PIRIFORM_NX_FF_FB_INHIB} {PIRIFORM_NY_FF_FB_INHIB}     \
            0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}         \
        -debug {DUMP_WEIGHTS_DEBUG}
end

