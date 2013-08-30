// genesis

//
// bulb_pyr_connect.g: synaptic connections from the olfactory bulb
//     "mitral" cells to the distal dendrites of the pyramidal cells
//     (in layer 1a).
//

str compt
str all_compts = "Ia_2 Ia_1 supIb_3"

if (BULB_PYR_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up olfactory bulb -> pyramidal cell synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (BULB_PYR_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

/*
foreach compt ({arglist {all_compts}})
    piriform_volume_connect  \
        /bulb/mitral_cell[]                                         \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_aff_exc_syn   \
        -sourceall                                                  \
        -destall                                                    \
        -probability {BULB_PYR_CONNECTION_PROB}                     \
        -verbose {BULB_PYR_VERBOSE} -debug {BULB_PYR_DEBUG}
end
*/

// Set up non-random connection patterns.
// Each neuron receives one of a non-overlapping group of inputs.

int i, j
int bgroup, pgroup   // bulb and pyramidal groups
str src_path, dest_path

for (i = 0; i < BULB_N; i = i + 1)
    for (j = 0; j < PIRIFORM_N_PYRAMIDAL; j = j + 1)
        // Find whether a given pyramidal cell receives inputs from
        // this group of mitral cells.
        bgroup = {getfield /groups/bulb val[{i}]}
        pgroup = {getfield /groups/pyramidal val[{j}]}

        if (bgroup == pgroup)
            // It does, so set up connections to all target compartments.
            src_path = "/bulb/mitral_cell[" @ i @ "]"

            foreach compt ({arglist {all_compts}})
                dest_path = "/piriform_cortex/pyramidal_cell[" \
                    @ {j} @ "]/" @ {compt} @ "/pyr_aff_exc_syn"
                //echo {src_path} -> {dest_path}
                addmsg {src_path} {dest_path} SPIKE
            end
        end
    end
end



if (BULB_PYR_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

function bulb_pyr_wt_mult(compt)
    str   compt
    float mult

    if (compt == "Ia_2")
        mult = {BULB_PYR_DIA_2}
    elif (compt == "Ia_1")
        mult = {BULB_PYR_DIA_1}
    elif (compt == "supIb_3")
        mult = {BULB_PYR_DSUPIB_3}
    else
        error
        echo bulb_pyr_minwt: invalid compartment {compt}
    end

    return {mult}
end


function bulb_pyr_maxwt(compt)
    str compt
    float scale = {BULB_PYR_MAX_WT} * {bulb_pyr_wt_mult {compt}}
    return scale
end


function bulb_pyr_minwt(compt)
    str compt
    float scale = {BULB_PYR_MIN_WT} * {bulb_pyr_wt_mult {compt}}
    return scale
end


foreach compt ({arglist {all_compts}})
    piriform_set_afferent_weights  \
        /bulb/mitral_cell[]                                         \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_aff_exc_syn   \
        -expdecay1 0.0                                              \
                   {bulb_pyr_maxwt {compt}}                         \
                   {bulb_pyr_minwt {compt}}                         \
                   {BULB_PYR_DECAY_RATE1}                           \
        -expdecay2 {bulb_pyr_minwt {compt}}                         \
                   {BULB_PYR_DECAY_RATE2}                           \
        -transition_factor {FP_LOT_TRANSITION_FACTOR}               \
        -axes {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}               \
        -gaussian {BULB_PYR_STDEV} {BULB_PYR_MAXDEV}                \
        -verbose {BULB_PYR_VERBOSE} -debug {BULB_PYR_DEBUG}
end


if (BULB_PYR_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end


foreach compt ({arglist {all_compts}})
    piriform_set_afferent_delays  \
        /bulb/mitral_cell[]                                             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_aff_exc_syn       \
        -vel1 {PIRIFORM_AFFERENT_LOT_VELOCITY}                          \
        -vel2_lognormal {PIRIFORM_AFFERENT_COLLATERAL_VELOCITY_MODE}    \
                        {PIRIFORM_AFFERENT_COLLATERAL_VELOCITY_MEDIAN}  \
        -axes {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                   \
        -mindelay {sim_mindelay}                                        \
        -verbose {BULB_PYR_VERBOSE} -debug {BULB_PYR_DEBUG}
end


//
// Function to dump the bulb->pyr weights to xview files.
//

function dump_bulb_to_pyr_weights
    if (BULB_PYR_VERBOSE >= 0)
        echo "Dumping weights from olfactory bulb mitral cells "
        echo "    to pyramidal cell synchans..."
    end

    str compt
    str all_compts = "Ia_2 Ia_1 supIb_3"

    foreach compt ({arglist {all_compts}})
        piriform_dump_synaptic_weights  \
            /piriform_cortex/pyramidal_cell[]/{compt}/pyr_aff_exc_syn   \
            {outdir_syn}/nsyn_bulb_to_pyr_{compt}                       \
            -source_element_name mitral_cell                            \
            -sourceall                                                  \
            -xview_format                                               \
                {PIRIFORM_NX_PYRAMIDAL} {PIRIFORM_NY_PYRAMIDAL}         \
                0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}         \
            -debug {DUMP_WEIGHTS_DEBUG}
    end
end



