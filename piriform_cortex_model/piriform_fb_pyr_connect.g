// genesis

//
// piriform_fb_pyr_connect.g: synaptic connections from the feedback
//     inhibitory interneurons to the pyramidal cells.
//

str compt
str all_compts = "soma basal_1 basal_2 basal_3"

//
// NOTE: It's clear from the literature that there are large numbers of
//       feedback inhibitory connections in the vicinity of the soma.
//       Ketchum and Haberly (J. Neurophys. 69:1, 261-281, fig. 2c) also
//       use inhibitory conductances on the proximal part of the basal
//       dendrites, so I do too.  The strength of the inhibitory drive
//       diminishes considerably as we get further from the soma.
//

if (FB_PYR_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up feedback interneuron -> pyramidal cell
    echo     synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (FB_PYR_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

int random_connections = 1

if (random_connections)
    foreach compt ({arglist {all_compts}})
        piriform_volume_connect \
            /piriform_cortex/fb_inhib_cell[]/soma/fb_spikegen               \
            /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer2_3_inh_syn  \
            -relative                                                       \
            -sourceall                                                      \
            -destmask ellipsoid 0.0 0.0 0.0                                 \
                {FB_PYR_CONNECTION_X_EXTENT}                                \
                {FB_PYR_CONNECTION_Y_EXTENT}                                \
                {FB_PYR_CONNECTION_Z_EXTENT}                                \
            -probability {FB_PYR_CONNECTION_PROB}                           \
            -verbose {FB_PYR_VERBOSE} -debug {FB_PYR_DEBUG}
    end
else
    // Set up non-random connection patterns.
    // Each neuron belongs to one of several non-overlapping groups and
    // only receives connections from other members of its group.

    int   i, j, count
    int   pgroup, igroup   // pyramidal neuron and interneuron groups
    str   src_path, dest_path
    float src_x, src_y, dest_x, dest_y, dx, dy, xy_dist
    float r

    count = 0

    for (i = 0; i < PIRIFORM_N_FB_INHIB; i = i + 1)
        src_path = "/piriform_cortex/fb_inhib_cell[" \
                    @ {i} @ "]/soma/fb_spikegen"
        src_x = {getfield {src_path} x}
        src_y = {getfield {src_path} y}

        igroup = {getfield /groups/fb val[{i}]}

        for (j = 0; j < PIRIFORM_N_PYRAMIDAL; j = j + 1)
            pgroup = {getfield /groups/pyramidal val[{j}]}

            // Only set up connections within the same group.
            if (igroup == pgroup)
                foreach compt ({arglist {all_compts}})
                    dest_path = "/piriform_cortex/pyramidal_cell[" \
                        @ {j} @ "]/" @ {compt} @ "/pyr_layer2_3_inh_syn"
                    dest_x = {getfield {dest_path} x}
                    dest_y = {getfield {dest_path} y}
                    dx     = src_x - dest_x
                    dy     = src_y - dest_y

                    // Don't connect neurons that are too close to or
                    // too far from each other.

                    xy_dist = {sqrt {dx * dx + dy * dy}}

                    if (xy_dist <= FP_FB_PYR_CONNECTION_EXTENT && \
                        xy_dist > DELTA)
                        r = {rand2}

                        if (r < {FP_FB_PYR_GROUP_CONNECTION_PROB})
                            addmsg {src_path} {dest_path} SPIKE
                            // echo {src_path} -> {dest_path}
                            count = count + 1
                        end
                    else
                        //echo Rejecting connection: {src_path} -> {dest_path}
                    end
                end  // foreach
            end  // for
        end
    end

    echo Local fb to pyr connections: {count}
end  // if (random_connections)


if (FB_PYR_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

function fb_pyr_maxwt(compt)
    str compt

    if (compt == "soma")
        return {FB_PYR_MAX_WT_SOMA}
    elif (compt == "basal_1")
        return {FB_PYR_MAX_WT_BASAL_1}
    elif (compt == "basal_2")
        return {FB_PYR_MAX_WT_BASAL_2}
    elif (compt == "basal_3")
        return {FB_PYR_MAX_WT_BASAL_3}
    else
        error
        echo fb_pyr_maxwt: invalid compartment {compt}
    end
end

foreach compt ({arglist {all_compts}})
    piriform_set_associational_weights                                  \
        /piriform_cortex/fb_inhib_cell[]/soma/fb_spikegen               \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer2_3_inh_syn  \
        -expdecay {fb_pyr_maxwt {compt}} {FB_PYR_MIN_WT}                \
            {FB_PYR_DECAY_RATE} 0.0                                     \
        -gaussian {FB_PYR_STDEV} {FB_PYR_MAXDEV}                        \
        -verbose {FB_PYR_VERBOSE} -debug {FB_PYR_DEBUG}
end


if (FB_PYR_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end

foreach compt ({arglist {all_compts}})
    piriform_set_associational_delays                                   \
        /piriform_cortex/fb_inhib_cell[]/soma/fb_spikegen               \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer2_3_inh_syn  \
        -vel_lognormal {PIRIFORM_FB_PYR_VELOCITY_MODE}                  \
                       {PIRIFORM_FB_PYR_VELOCITY_MEDIAN}                \
        -mindelay {sim_mindelay}                                        \
        -verbose {FB_PYR_VERBOSE} -debug {FB_PYR_DEBUG}
end


if (FB_PYR_VERBOSE >= 0)
    echo ----------------------------------------
    echo Normalizing synaptic weights.
    echo ----------------------------------------
    echo
end

function fb_pyr_nsynapses(compt)
    str compt
    float nsynapses = {PIRIFORM_NFB_PYR_SYNAPSES}

    if (compt == "soma")
        return {nsynapses * FB_PYR_DSOMA}
    elif (compt == "basal_1")
        return {nsynapses * FB_PYR_DBASAL_1}
    elif (compt == "basal_2")
        return {nsynapses * FB_PYR_DBASAL_2}
    elif (compt == "basal_3")
        return {nsynapses * FB_PYR_DBASAL_3}
    else
        error
        echo fb_pyr_nsynapses: invalid compartment {compt}
    end
end

float PYR_FB_SCALE1 = FP_PYR_FB_SCALE1
float X1 = FP_X1
float PYR_FB_SCALE2 = FP_PYR_FB_SCALE2
float X2 = FP_X2
float PYR_FB_SCALE3 = FP_PYR_FB_SCALE3
float X3 = FP_X3
float PYR_FB_SCALE4 = FP_PYR_FB_SCALE4

foreach compt ({arglist {all_compts}})
    piriform_normalize_synapses  \
        /piriform_cortex/pyramidal_cell[x<{X1}]/{compt}/pyr_layer2_3_inh_syn  \
        {{fb_pyr_nsynapses {compt}} * PYR_FB_SCALE1}                    \
        -source_element_name fb_spikegen                                \
        -sourceall                                                      \
        -gaussian {FB_PYR_STDEV} {FB_PYR_MAXDEV}                        \
        -debug {FB_PYR_DEBUG}

    piriform_normalize_synapses  \
/piriform_cortex/pyramidal_cell[x>{X1}][x<{X2}]/{compt}/pyr_layer2_3_inh_syn  \
        {{fb_pyr_nsynapses {compt}} * PYR_FB_SCALE2}                    \
        -source_element_name fb_spikegen                                \
        -sourceall                                                      \
        -gaussian {FB_PYR_STDEV} {FB_PYR_MAXDEV}                        \
        -debug {FB_PYR_DEBUG}

    piriform_normalize_synapses  \
/piriform_cortex/pyramidal_cell[x>{X2}][x<{X3}]/{compt}/pyr_layer2_3_inh_syn  \
        {{fb_pyr_nsynapses {compt}} * PYR_FB_SCALE3}                    \
        -source_element_name fb_spikegen                                \
        -sourceall                                                      \
        -gaussian {FB_PYR_STDEV} {FB_PYR_MAXDEV}                        \
        -debug {FB_PYR_DEBUG}

    piriform_normalize_synapses  \
        /piriform_cortex/pyramidal_cell[x>{X3}]/{compt}/pyr_layer2_3_inh_syn  \
        {{fb_pyr_nsynapses {compt}} * PYR_FB_SCALE4}                    \
        -source_element_name fb_spikegen                                \
        -sourceall                                                      \
        -gaussian {FB_PYR_STDEV} {FB_PYR_MAXDEV}                        \
        -debug {FB_PYR_DEBUG}
end



//
// Function to dump the fb->pyr weights to xview files.
//

function dump_fb_pyr_weights
    str compt
    str all_compts = "soma basal_1 basal_2 basal_3"

    if (FB_PYR_VERBOSE >= 0)
        echo "Dumping weights from fb_inhib cell spikegens " -n
        echo "to pyramidal cell synchans..."
    end

    foreach compt ({arglist {all_compts}})
        piriform_dump_synaptic_weights  \
            /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer2_3_inh_syn  \
            {outdir_syn}/nsyn_fb_to_pyr_{compt}                             \
            -source_element_name fb_spikegen                                \
            -sourceall                                                      \
            -xview_format {PIRIFORM_NX_PYRAMIDAL} {PIRIFORM_NY_PYRAMIDAL}   \
                 0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}            \
            -debug {DUMP_WEIGHTS_DEBUG}
    end
end

