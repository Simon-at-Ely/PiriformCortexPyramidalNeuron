// genesis

//
// piriform_pyr_fb_connect.g: synaptic connections from the pyramidal cells
//     to the feedback inhibitory interneurons.
//

if (PYR_FB_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up pyramidal cell -> feedback interneuron
    echo     synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (PYR_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

int random_connections = 1

if (random_connections)
    piriform_volume_connect \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen       \
        /piriform_cortex/fb_inhib_cell[]/soma/fb_assoc_exc_syn    \
        -relative                                                 \
        -sourceall                                                \
        -destmask ellipsoid 0.0 0.0 0.0                           \
            {PYR_FB_CONNECTION_X_EXTENT}                          \
            {PYR_FB_CONNECTION_Y_EXTENT}                          \
            {PYR_FB_CONNECTION_Z_EXTENT}                          \
        -probability {PYR_FB_CONNECTION_PROB}                     \
        -verbose {PYR_FB_VERBOSE} -debug {PYR_FB_DEBUG}
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

    for (i = 0; i < PIRIFORM_N_PYRAMIDAL; i = i + 1)
        src_path = "/piriform_cortex/pyramidal_cell[" \
                    @ {i} @ "]/soma/pyr_spikegen"
        src_x = {getfield {src_path} x}
        src_y = {getfield {src_path} y}

        pgroup = {getfield /groups/pyramidal val[{i}]}

        for (j = 0; j < PIRIFORM_N_FB_INHIB; j = j + 1)
            igroup = {getfield /groups/fb val[{j}]}

            // Only set up connections within the same group.
            if (pgroup == igroup)
                dest_path = "/piriform_cortex/fb_inhib_cell[" \
                    @ {j} @ "]/soma/fb_assoc_exc_syn"
                dest_x = {getfield {dest_path} x}
                dest_y = {getfield {dest_path} y}
                dx     = src_x - dest_x
                dy     = src_y - dest_y

                // Don't connect neurons that are too close to or
                // too far from each other.

                xy_dist = {sqrt {dx * dx + dy * dy}}

                if (xy_dist <= FP_PYR_FB_CONNECTION_EXTENT && \
                    xy_dist > DELTA)
                    r = {rand2}

                    if (r < {FP_PYR_FB_GROUP_CONNECTION_PROB})
                        addmsg {src_path} {dest_path} SPIKE
                        //echo {src_path} -> {dest_path}
                        count = count + 1
                    end
                else
                    //echo Rejecting connection: {src_path} -> {dest_path}
                end
            end  // for
        end
    end

    echo Local pyr to fb connections: {count}
end  // if (random_connections)


if (PYR_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_set_associational_weights                                      \
    /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen                 \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_assoc_exc_syn              \
    -expdecay {PYR_FB_MAX_WT} {PYR_FB_MIN_WT} {PYR_FB_DECAY_RATE} 0.0   \
    -gaussian {PYR_FB_STDEV} {PYR_FB_MAXDEV}                            \
    -verbose {PYR_FB_VERBOSE} -debug {PYR_FB_DEBUG}


if (PYR_FB_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end

piriform_set_associational_delays                           \
    /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen     \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_assoc_exc_syn  \
    -vel_lognormal {PIRIFORM_PYR_FB_VELOCITY_MODE}          \
                   {PIRIFORM_PYR_FB_VELOCITY_MEDIAN}        \
    -mindelay {sim_mindelay}                                \
    -verbose {PYR_FB_VERBOSE} -debug {PYR_FB_DEBUG}


if (PYR_FB_VERBOSE >= 0)
    echo ----------------------------------------
    echo Normalizing synaptic weights.
    echo ----------------------------------------
    echo
end

piriform_normalize_synapses  \
    /piriform_cortex/fb_inhib_cell[]/soma/fb_assoc_exc_syn      \
    {PIRIFORM_NPYR_FB_SYNAPSES}                                 \
    -source_element_name pyr_spikegen                           \
    -sourceall                                                  \
    -gaussian {PYR_FB_STDEV} {PYR_FB_MAXDEV}                    \
    -debug {PYR_FB_DEBUG}


//
// Function to dump the pyr->fb weights to an xview file.
//

function dump_pyr_fb_weights
    if (PYR_FB_VERBOSE >= 0)
        echo "Dumping weights from pyramidal cell spikegens " -n
        echo "to fb_inhib cell synchans..."
    end

    piriform_dump_synaptic_weights  \
        /piriform_cortex/fb_inhib_cell[]/soma/fb_assoc_exc_syn          \
        {outdir_syn}/nsyn_pyr_to_fb                                     \
        -source_element_name pyr_spikegen                               \
        -sourceall                                                      \
        -xview_format                                                   \
             {PIRIFORM_NX_FB_INHIB} {PIRIFORM_NY_FB_INHIB}              \
             0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}            \
        -debug {DUMP_WEIGHTS_DEBUG}
end
