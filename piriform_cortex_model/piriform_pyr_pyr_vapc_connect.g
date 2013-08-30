// genesis

//
// piriform_pyr_pyr_vapc_connect.g: long-range synaptic connections from
//     pyramidal cells located in the ventral anterior piriform
//     cortex.
//

//
// According to Haberly (SOB 4th ed), cells in the vAPC project
// mainly to superficial Ib dendrites in the rest of the piriform
// cortex.
//

str compt
str all_compts = "supIb_3 supIb_2 supIb_1 deepIb_3"

if (PYR_PYR_VAPC_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up long-range pyramidal cell -> pyramidal cell
    echo     synaptic connections originating from the ventral
    echo     anterior piriform cortex.
    echo -------------------------------------------------------------------
    echo
end

if (PYR_PYR_VAPC_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

// NOTE: we set up a desthole to prevent the cells from projecting locally.

if (!FP_PYR_PYR_NON_RANDOM_CONNECTIONS)
    foreach compt ({arglist {all_compts}})
        piriform_volume_connect  \
            /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
            /piriform_cortex/pyramidal_cell[]/{compt}/pyr_assoc_exc_syn     \
            -relative                                                       \
            -sourcemask xy_ellipse 0.0 0.0 any                              \
                {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} any                 \
            -destall                                                        \
            -desthole xy_ellipse 0.0 0.0 any                                \
                {PYR_PYR_VAPC_CONNECTION_X_HOLE}                            \
                {PYR_PYR_VAPC_CONNECTION_Y_HOLE}                            \
                any                                                         \
            -probability {PYR_PYR_VAPC_CONNECTION_PROB}                     \
            -verbose {PYR_PYR_VAPC_VERBOSE} -debug {PYR_PYR_VAPC_DEBUG}
    end
else
    // Set up non-random connection patterns.
    // Each neuron belongs to one of several non-overlapping groups and
    // only receives connections from other members of its group.
    // We manually simulate the source mask and destination hole.
    
    float VAPC_x_extent    = PIRIFORM_X_EXTENT / 2.0
    float VAPC_y_extent    = PIRIFORM_Y_EXTENT / 2.0
    float VAPC_x_extent_sq = VAPC_x_extent * VAPC_x_extent
    float VAPC_y_extent_sq = VAPC_y_extent * VAPC_y_extent
    
    function is_in_VAPC(x, y, i)
        float x, y
        int   i    // For debugging; contains index of neuron.
        float q
    
        q = x * x / VAPC_x_extent_sq + y * y / VAPC_y_extent_sq
    
        if (q < 1.0)
            //echo VAPC: {i}
            return 1
        else
            return 0
        end
    end
    
    
    int   i, j, count
    int   pgroup1, pgroup2   // pyramidal groups
    str   src_path, dest_path
    float src_x, src_y, dest_x, dest_y, dx, dy, xy_dist
    float r
    
    count = 0
    
    for (i = 0; i < PIRIFORM_N_PYRAMIDAL; i = i + 1)
        src_path = "/piriform_cortex/pyramidal_cell[" \
                    @ {i} @ "]/soma/pyr_spikegen"
        src_x = {getfield {src_path} x}
        src_y = {getfield {src_path} y}
    
        // Check that the source is in fact in the vAPC.
        if ({is_in_VAPC {src_x} {src_y} {i}})
            pgroup1 = {getfield /groups/pyramidal val[{i}]}
    
            for (j = 0; j < PIRIFORM_N_PYRAMIDAL; j = j + 1)
                pgroup2 = {getfield /groups/pyramidal val[{j}]}
    
                // Only set up connections within the same group.
                if (pgroup1 == pgroup2)
                    foreach compt ({arglist {all_compts}})
                        // FIXME: this is inefficient; the xy values
                        // are the same for all compts on the cell.
                        dest_path = "/piriform_cortex/pyramidal_cell[" \
                            @ {j} @ "]/" @ {compt} @ "/pyr_assoc_exc_syn"
                        dest_x = {getfield {dest_path} x}
                        dest_y = {getfield {dest_path} y}
                        dx     = src_x - dest_x
                        dy     = src_y - dest_y
    
                        // Don't connect neurons that are too close
                        // to each other; these are long-range
                        // connections only.
    
                        xy_dist = {sqrt {dx * dx + dy * dy}}
    
                        // FIXME: This is a hack; should use both X and Y.
                        // In this case they're the same, so it shouldn't matter.
                        if (xy_dist > {PYR_PYR_VAPC_CONNECTION_X_HOLE})
    
                            // Set it up so that no VAPC cell connects
                            // to another VAPC cell unless the destination
                            // cell is caudal to the source cell.
    
                            if (!{is_in_VAPC {dest_x} {dest_y} {j}} \
                                || {dest_x > src_x})
                                r = {rand2}
    
                                if (r < {FP_PYR_PYR_GROUP_CONNECTION_PROB})
                                    addmsg {src_path} {dest_path} SPIKE
                                    //echo {src_path} -> {dest_path}
                                    count = count + 1
                                end
                            end
    
                            /*
                            r = {rand2}
    
                            if (r < {FP_PYR_PYR_GROUP_CONNECTION_PROB})
                                addmsg {src_path} {dest_path} SPIKE
                                //echo {src_path} -> {dest_path}
                                count = count + 1
                            end
                            */
                        end
                    end  // foreach
                end  // if
            end  // for
        end
    end
    
    echo Long-range connections originating from VAPC region: {count}
end


if (PYR_PYR_VAPC_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

function pyr_pyr_vapc_maxwt(compt)
    str compt

    // Return the maximum weight value for the given compartment.

    if (compt == "supIb_3")
        return {PYR_PYR_VAPC_SUPIB_3_MAX_WT}
    elif (compt == "supIb_2")
        return {PYR_PYR_VAPC_SUPIB_2_MAX_WT}
    elif (compt == "supIb_1")
        return {PYR_PYR_VAPC_SUPIB_1_MAX_WT}
    elif (compt == "deepIb_3")
        return {PYR_PYR_VAPC_DEEPIB_3_MAX_WT}
    else
        error
        echo pyr_pyr_vapc_maxwt: invalid compartment {compt}
    end
end

foreach compt ({arglist {all_compts}})
    // Anteriorly-directed weights:
    piriform_set_associational_weights  \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen                 \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_assoc_exc_syn         \
        -sourcemask ellipse                                                 \
            0.0 0.0                                                         \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                         \
        -destmask box -1.0 -1.0 0.0 1.0                                     \
        -relative                                                           \
        -planar_xy                                                          \
        -expdecay {{pyr_pyr_vapc_maxwt {compt}} * PYR_PYR_VAPC_PA_SCALE}    \
                  {PYR_PYR_VAPC_MIN_WT}                                     \
                  {PYR_PYR_VAPC_DECAY_RATE}                                 \
                  {PYR_PYR_VAPC_CONNECTION_OFFSET}                          \
        -gaussian {PYR_PYR_VAPC_STDEV} {PYR_PYR_VAPC_MAXDEV}                \
        -verbose {PYR_PYR_VAPC_VERBOSE} -debug {PYR_PYR_VAPC_DEBUG}

    // Posteriorly-directed weights:
    piriform_set_associational_weights  \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen                 \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_assoc_exc_syn         \
        -sourcemask ellipse                                                 \
            0.0 0.0                                                         \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                         \
        -destmask box 0.0 -1.0 1.0 1.0                                      \
        -relative                                                           \
        -planar_xy                                                          \
        -expdecay {{pyr_pyr_vapc_maxwt {compt}} * PYR_PYR_VAPC_AP_SCALE}    \
                  {PYR_PYR_VAPC_MIN_WT}                                     \
                  {PYR_PYR_VAPC_DECAY_RATE}                                 \
                  {PYR_PYR_VAPC_CONNECTION_OFFSET}                          \
        -gaussian {PYR_PYR_VAPC_STDEV} {PYR_PYR_VAPC_MAXDEV}                \
        -verbose {PYR_PYR_VAPC_VERBOSE} -debug {PYR_PYR_VAPC_DEBUG}
end


if (PYR_PYR_VAPC_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end


foreach compt ({arglist {all_compts}})
    piriform_set_associational_delays  \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_assoc_exc_syn     \
        -sourcemask ellipse                                             \
            0.0 0.0                                                     \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                     \
        -planar_xy                                                      \
        -vel_lognormal {PIRIFORM_ASSOCIATIONAL_VAPC_VELOCITY_MODE}      \
                       {PIRIFORM_ASSOCIATIONAL_VAPC_VELOCITY_MEDIAN}    \
        -mindelay {sim_mindelay}                                        \
        -verbose {PYR_PYR_VAPC_VERBOSE} -debug {PYR_PYR_VAPC_DEBUG}
end


//
// Function to dump the pyr(vapc)->pyr long-range weights to xview files.
//

function dump_pyr_vapc_to_pyr_lr_weights
    str compt
    str all_compts = "supIb_3 supIb_2 supIb_1 deepIb_3"

    if (PYR_PYR_VAPC_VERBOSE >= 0)
        echo "Dumping weights from VAPC pyramidal cell spikegens "
        echo "    to pyramidal cell synchans (long-range connections)..."
    end

    foreach compt ({arglist {all_compts}})
        piriform_dump_synaptic_weights  \
            /piriform_cortex/pyramidal_cell[]/{compt}/pyr_assoc_exc_syn \
            {outdir_syn}/nsyn_pyr_vapc_to_pyr_{compt}_lr                \
            -source_element_name pyr_spikegen                           \
            -sourcemask xy_ellipse                                      \
            0.0 0.0 any                                                 \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} any                 \
            -xview_format                                               \
                {PIRIFORM_NX_PYRAMIDAL} {PIRIFORM_NY_PYRAMIDAL}         \
                0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}         \
            -debug {DUMP_WEIGHTS_DEBUG}
    end
end

