// genesis

//
// piriform_ff_fb_pyr_connect.g: synaptic connections from the
//     feedforward/feedback inhibitory interneurons to the pyramidal cells.
//

str the_compt, all_ff_fb_compts

if (FP_FF_FB_DEND_INHIB_FLAG)
    all_ff_fb_compts = \
    "Ia_2 Ia_1 supIb_3 supIb_2 supIb_1 deepIb_3 deepIb_2 deepIb_1"
else
    all_ff_fb_compts = "supIb_2 supIb_1 deepIb_3"
end


function ff_fb_pyr_syn(compt)
    str compt

    if (FP_FF_FB_DEND_INHIB_FLAG)
        if (compt == "Ia_2")        // New
            return "pyr_layer1_inh_syn_3"
        elif (compt == "Ia_1")      // New
            return "pyr_layer1_inh_syn_3"
        elif (compt == "supIb_3")   // New
            return "pyr_layer1_inh_syn_2"
        elif (compt == "supIb_2")
            return "pyr_layer1_inh_syn_2"
        elif (compt == "supIb_1")
            return "pyr_layer1_inh_syn_1"
        elif (compt == "deepIb_3")
            return "pyr_layer1_inh_syn_1"
        elif (compt == "deepIb_2")  // New
            return "pyr_layer1_inh_syn_0"
        elif (compt == "deepIb_1")  // New
            return "pyr_layer1_inh_syn_0"
        else
            error
            echo ff_fb_pyr_syn: invalid compartment {compt}
        end
    else
        if (compt == "supIb_2")
            return "pyr_layer1_inh_syn_2"
        elif (compt == "supIb_1")
            return "pyr_layer1_inh_syn_1"
        elif (compt == "deepIb_3")
            return "pyr_layer1_inh_syn_1"
        else
            error
            echo ff_fb_pyr_syn: invalid compartment {compt}
        end
    end
end


if (FF_FB_PYR_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up feedforward/feedback interneuron -> pyramidal cell
    echo     synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (FF_FB_PYR_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

foreach the_compt ({arglist {all_ff_fb_compts}})
    piriform_volume_connect \
        /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_fb_spikegen             \
/piriform_cortex/pyramidal_cell[]/{the_compt}/{ff_fb_pyr_syn {the_compt}}   \
        -relative                                                           \
        -sourceall                                                          \
        -destmask ellipsoid 0.0 0.0 0.0                                     \
            {FF_FB_PYR_CONNECTION_X_EXTENT}                                 \
            {FF_FB_PYR_CONNECTION_Y_EXTENT}                                 \
            {FF_FB_PYR_CONNECTION_Z_EXTENT}                                 \
        -probability {FF_FB_PYR_CONNECTION_PROB}                            \
        -verbose {FF_FB_PYR_VERBOSE} -debug {FF_FB_PYR_DEBUG}
end


if (FF_FB_PYR_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

function ff_fb_pyr_maxwt(compt)
    str compt

    if (FP_FF_FB_DEND_INHIB_FLAG)
        if (compt == "Ia_2")        // New
            return {FF_FB_PYR_MAX_WT_IA_2}
        elif (compt == "Ia_1")      // New
            return {FF_FB_PYR_MAX_WT_IA_1}
        elif (compt == "supIb_3")   // New
            return {FF_FB_PYR_MAX_WT_SUPIB_3}
        elif (compt == "supIb_2")
            return {FF_FB_PYR_MAX_WT_SUPIB_2}
        elif (compt == "supIb_1")
            return {FF_FB_PYR_MAX_WT_SUPIB_1}
        elif (compt == "deepIb_3")
            return {FF_FB_PYR_MAX_WT_DEEPIB_3}
        elif (compt == "deepIb_2")  // New
            return {FF_FB_PYR_MAX_WT_DEEPIB_2}
        elif (compt == "deepIb_1")  // New
            return {FF_FB_PYR_MAX_WT_DEEPIB_1}
        else
            error
            echo ff_fb_pyr_maxwt: invalid compartment {compt}
        end
    else
        if (compt == "supIb_2")
            return {FF_FB_PYR_MAX_WT_SUPIB_2}
        elif (compt == "supIb_1")
            return {FF_FB_PYR_MAX_WT_SUPIB_1}
        elif (compt == "deepIb_3")
            return {FF_FB_PYR_MAX_WT_DEEPIB_3}
        else
            error
            echo ff_fb_pyr_maxwt: invalid compartment {compt}
        end
    end
end

foreach the_compt ({arglist {all_ff_fb_compts}})
    piriform_set_associational_weights                                      \
        /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_fb_spikegen             \
/piriform_cortex/pyramidal_cell[]/{the_compt}/{ff_fb_pyr_syn {the_compt}}   \
        -expdecay {ff_fb_pyr_maxwt {the_compt}} {FF_FB_PYR_MIN_WT}          \
            {FF_FB_PYR_DECAY_RATE} 0.0                                      \
        -gaussian {FF_FB_PYR_STDEV} {FF_FB_PYR_MAXDEV}                      \
        -verbose {FF_FB_PYR_VERBOSE} -debug {FF_FB_PYR_DEBUG}
end


if (FF_FB_PYR_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end

foreach the_compt ({arglist {all_ff_fb_compts}})
    piriform_set_associational_delays                                       \
        /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_fb_spikegen             \
/piriform_cortex/pyramidal_cell[]/{the_compt}/{ff_fb_pyr_syn {the_compt}}   \
        -vel_lognormal {PIRIFORM_FF_FB_PYR_VELOCITY_MODE}                   \
                       {PIRIFORM_FF_FB_PYR_VELOCITY_MEDIAN}                 \
        -mindelay {sim_mindelay}                                            \
        -verbose {FF_FB_PYR_VERBOSE} -debug {FF_FB_PYR_DEBUG}
end


if (FF_FB_PYR_VERBOSE >= 0)
    echo ----------------------------------------
    echo Normalizing synaptic weights.
    echo ----------------------------------------
    echo
end

function ff_fb_pyr_nsynapses(compt)
    str compt
    float nsynapses = {PIRIFORM_NFF_FB_PYR_SYNAPSES}

    if (FP_FF_FB_DEND_INHIB_FLAG)
        if (compt == "Ia_2")
            return {nsynapses * FF_FB_PYR_DIA_2}
        elif (compt == "Ia_1")
            return {nsynapses * FF_FB_PYR_DIA_1}
        elif (compt == "supIb_3")
            return {nsynapses * FF_FB_PYR_DSUPIB_3}
        elif (compt == "supIb_2")
            return {nsynapses * FF_FB_PYR_DSUPIB_2}
        elif (compt == "supIb_1")
            return {nsynapses * FF_FB_PYR_DSUPIB_1}
        elif (compt == "deepIb_3")
            return {nsynapses * FF_FB_PYR_DDEEPIB_3}
        elif (compt == "deepIb_2")
            return {nsynapses * FF_FB_PYR_DDEEPIB_2}
        elif (compt == "deepIb_1")
            return {nsynapses * FF_FB_PYR_DDEEPIB_1}
        else
            error
            echo ff_fb_pyr_nsynapses: invalid compartment {compt}
        end
    else
        if (compt == "supIb_2")
            return {nsynapses * FF_FB_PYR_DSUPIB_2}
        elif (compt == "supIb_1")
            return {nsynapses * FF_FB_PYR_DSUPIB_1}
        elif (compt == "deepIb_3")
            return {nsynapses * FF_FB_PYR_DDEEPIB_3}
        else
            error
            echo ff_fb_pyr_nsynapses: invalid compartment {compt}
        end
    end
end

foreach the_compt ({arglist {all_ff_fb_compts}})
    piriform_normalize_synapses  \
/piriform_cortex/pyramidal_cell[]/{the_compt}/{ff_fb_pyr_syn {the_compt}}   \
        {ff_fb_pyr_nsynapses {the_compt}}                                   \
        -source_element_name ff_fb_spikegen                                 \
        -sourceall                                                          \
        -gaussian {FF_FB_PYR_STDEV} {FF_FB_PYR_MAXDEV}                      \
        -debug {FF_FB_PYR_DEBUG}
end


//
// Function to dump the ff_fb->pyr weights to xview files.
//

function dump_ff_fb_pyr_weights
    str compt

    if (FF_FB_PYR_VERBOSE >= 0)
        echo "Dumping weights from ff_fb_inhib cell spikegens " -n
        echo "to pyramidal cell synchans..."
    end

    foreach compt ({arglist {all_ff_fb_compts}})
        piriform_dump_synaptic_weights  \
        /piriform_cortex/pyramidal_cell[]/{compt}/{ff_fb_pyr_syn {compt}}   \
            {outdir_syn}/nsyn_ff_fb_to_pyr_{compt}                          \
            -source_element_name ff_fb_spikegen                             \
            -sourceall                                                      \
            -xview_format {PIRIFORM_NX_PYRAMIDAL} {PIRIFORM_NY_PYRAMIDAL}   \
                 0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}            \
            -debug {DUMP_WEIGHTS_DEBUG}
    end
end

