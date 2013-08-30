// genesis

//
// piriform_pyr_pyr_local_connect.g: synaptic connections from
//     pyramidal cells to nearby pyramidal cells (onto basal dendrites
//     in layer 3).
//

str compt
str all_compts = "basal_1 basal_2 basal_3 basal_4 basal_5 basal_6"

if (PYR_PYR_LOCAL_VERBOSE >= -1)
    echo
    echo -------------------------------------------------------------------
    echo Setting up local layer 3 pyramidal cell -> pyramidal cell
    echo     synaptic connections...
    echo -------------------------------------------------------------------
    echo
end

if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo ----------------------------------------
    echo Setting up connections.
    echo ----------------------------------------
    echo
end

// NOTE: we set up a desthole to prevent the cells from projecting
//       to themselves. DELTA is a small nominal value.

if (!FP_PYR_PYR_NON_RANDOM_CONNECTIONS)
    foreach compt ({arglist {all_compts}})
        piriform_volume_connect \
            /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
            /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
            -relative                                                       \
            -sourceall                                                      \
            -destmask ellipsoid 0.0 0.0 0.0                                 \
                {PYR_PYR_LOCAL_CONNECTION_X_EXTENT}                         \
                {PYR_PYR_LOCAL_CONNECTION_Y_EXTENT}                         \
                {PYR_PYR_LOCAL_CONNECTION_Z_EXTENT}                         \
            -desthole ellipsoid 0.0 0.0 0.0 {DELTA} {DELTA} {DELTA}         \
            -probability {PYR_PYR_LOCAL_CONNECTION_PROB}                    \
            -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}
    end
else
    // Set up non-random connection patterns.
    // Each neuron belongs to one of several non-overlapping groups and
    // only receives connections from other members of its group.
    // We manually simulate the source mask and destination hole.
    
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
    
        pgroup1 = {getfield /groups/pyramidal val[{i}]}
    
        for (j = 0; j < PIRIFORM_N_PYRAMIDAL; j = j + 1)
            pgroup2 = {getfield /groups/pyramidal val[{j}]}
    
            // Only set up connections within the same group.
            if (pgroup1 == pgroup2)
                foreach compt ({arglist {all_compts}})
                    dest_path = "/piriform_cortex/pyramidal_cell[" \
                        @ {j} @ "]/" @ {compt} @ "/pyr_local_exc_syn"
                    dest_x = {getfield {dest_path} x}
                    dest_y = {getfield {dest_path} y}
                    dx     = src_x - dest_x
                    dy     = src_y - dest_y
    
                    // Don't connect neurons that are too close to or
                    // too far from each other.
    
                    xy_dist = {sqrt {dx * dx + dy * dy}}
    
                    if (xy_dist <= FP_PYR_PYR_LOCAL_CONNECTION_EXTENT && \
                        xy_dist > DELTA)
                        r = {rand2}
    
                        if (r < {FP_PYR_PYR_GROUP_CONNECTION_PROB})
                            addmsg {src_path} {dest_path} SPIKE
                            //echo {src_path} -> {dest_path}
                            count = count + 1
                        end
                    else
                        //echo Rejecting connection: {src_path} -> {dest_path}
                    end
                end  // foreach
            end  // for
        end
    end
    
    echo Local pyr to pyr connections: {count}
end


if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up synaptic weights.
    echo ----------------------------------------
    echo
end

//
// The strength of local excitatory connections is a function of
// the location of the pyramidal cells.  Cells in the posterior
// piriform cortex (PPC) have dense local excitatory connections,
// cells in the dorsal anterior piriform cortex (dAPC) have weaker
// local excitatory connections, and cells in the ventral anterior
// piriform cortex (vAPC) have very weak or absent local excitatory
// connections.
//

function pyr_pyr_local_maxwt(compt, region)
    str compt, region
    int vapc = 0
    int dapc = 0
    int ppc  = 0

    // Check that the region is valid.

    if (region == "VAPC")
        vapc = 1
    elif (region == "DAPC")
        dapc = 1
    elif (region == "PPC")
        ppc = 1
    else
        error
        echo pyr_pyr_local_maxwt: invalid region: {region}
        return 0.0
    end

    // Return the maximum weight value for the given
    // compartment/region pair.

    if (compt == "basal_1")
        if (vapc)
            return {PYR_PYR_LOCAL_BASAL_1_VAPC_MAX_WT}
        elif (dapc)
            return {PYR_PYR_LOCAL_BASAL_1_DAPC_MAX_WT}
        elif (ppc)
            return {PYR_PYR_LOCAL_BASAL_1_PPC_MAX_WT}
        end
    elif (compt == "basal_2")
        if (vapc)
            return {PYR_PYR_LOCAL_BASAL_2_VAPC_MAX_WT}
        elif (dapc)
            return {PYR_PYR_LOCAL_BASAL_2_DAPC_MAX_WT}
        elif (ppc)
            return {PYR_PYR_LOCAL_BASAL_2_PPC_MAX_WT}
        end
    elif (compt == "basal_3")
        if (vapc)
            return {PYR_PYR_LOCAL_BASAL_3_VAPC_MAX_WT}
        elif (dapc)
            return {PYR_PYR_LOCAL_BASAL_3_DAPC_MAX_WT}
        elif (ppc)
            return {PYR_PYR_LOCAL_BASAL_3_PPC_MAX_WT}
        end
    elif (compt == "basal_4")
        if (vapc)
            return {PYR_PYR_LOCAL_BASAL_4_VAPC_MAX_WT}
        elif (dapc)
            return {PYR_PYR_LOCAL_BASAL_4_DAPC_MAX_WT}
        elif (ppc)
            return {PYR_PYR_LOCAL_BASAL_4_PPC_MAX_WT}
        end
    elif (compt == "basal_5")
        if (vapc)
            return {PYR_PYR_LOCAL_BASAL_5_VAPC_MAX_WT}
        elif (dapc)
            return {PYR_PYR_LOCAL_BASAL_5_DAPC_MAX_WT}
        elif (ppc)
            return {PYR_PYR_LOCAL_BASAL_5_PPC_MAX_WT}
        end
    elif (compt == "basal_6")
        if (vapc)
            return {PYR_PYR_LOCAL_BASAL_6_VAPC_MAX_WT}
        elif (dapc)
            return {PYR_PYR_LOCAL_BASAL_6_DAPC_MAX_WT}
        elif (ppc)
            return {PYR_PYR_LOCAL_BASAL_6_PPC_MAX_WT}
        end
    else
        error
        echo pyr_pyr_local_maxwt: invalid compartment {compt}
    end
end


if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo
    echo Setting up weights for associational fibers originating from
    echo cells located in the ventral anterior piriform cortex (vAPC).
    echo
end

foreach compt ({arglist {all_compts}})
    // Anteriorly-directed weights:
    piriform_set_associational_weights \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask ellipse                                             \
            0.0 0.0                                                     \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                     \
        -destmask box -1.0 -1.0 0.0 1.0                                 \
        -relative                                                       \
        -expdecay {{pyr_pyr_local_maxwt {compt} "VAPC"}                 \
                  * PYR_PYR_LOCAL_PA_SCALE}                             \
                  {PYR_PYR_LOCAL_MIN_WT}                                \
                  {PYR_PYR_LOCAL_DECAY_RATE} 0.0                        \
        -gaussian {PYR_PYR_LOCAL_STDEV} {PYR_PYR_LOCAL_MAXDEV}          \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}

    // Posteriorly-directed weights:
    piriform_set_associational_weights \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask ellipse                                             \
            0.0 0.0                                                     \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                     \
        -destmask box 0.0 -1.0 1.0 1.0                                  \
        -relative                                                       \
        -expdecay {{pyr_pyr_local_maxwt {compt} "VAPC"}                 \
                  * PYR_PYR_LOCAL_AP_SCALE}                             \
                  {PYR_PYR_LOCAL_MIN_WT}                                \
                  {PYR_PYR_LOCAL_DECAY_RATE} 0.0                        \
        -gaussian {PYR_PYR_LOCAL_STDEV} {PYR_PYR_LOCAL_MAXDEV}          \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}
end


if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo
    echo Setting up weights for associational fibers originating from
    echo cells located in the dorsal anterior piriform cortex (dAPC).
    echo
end

foreach compt ({arglist {all_compts}})
    // Anteriorly-directed weights:
    piriform_set_associational_weights \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask box                                                 \
            0.0 0.0                                                     \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_EXTENT}                     \
        -sourcehole ellipse                                             \
            0.0 0.0                                                     \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                     \
        -destmask box -1.0 -1.0 0.0 1.0                                 \
        -relative                                                       \
        -expdecay {{pyr_pyr_local_maxwt {compt} "DAPC"}                 \
                  * PYR_PYR_LOCAL_PA_SCALE}                             \
                  {PYR_PYR_LOCAL_MIN_WT}                                \
                  {PYR_PYR_LOCAL_DECAY_RATE} 0.0                        \
        -gaussian {PYR_PYR_LOCAL_STDEV} {PYR_PYR_LOCAL_MAXDEV}          \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}

    // Posteriorly-directed weights:
    piriform_set_associational_weights \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask box                                                 \
            0.0 0.0                                                     \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_EXTENT}                     \
        -sourcehole ellipse                                             \
            0.0 0.0                                                     \
            {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}                     \
        -destmask box 0.0 -1.0 1.0 1.0                                  \
        -relative                                                       \
        -expdecay {{pyr_pyr_local_maxwt {compt} "DAPC"}                 \
                  * PYR_PYR_LOCAL_AP_SCALE}                             \
                  {PYR_PYR_LOCAL_MIN_WT}                                \
                  {PYR_PYR_LOCAL_DECAY_RATE} 0.0                        \
        -gaussian {PYR_PYR_LOCAL_STDEV} {PYR_PYR_LOCAL_MAXDEV}          \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}
end


if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo
    echo Setting up weights for associational fibers originating from
    echo cells located in the posterior piriform cortex (PPC).
    echo
end

foreach compt ({arglist {all_compts}})
    // Anteriorly-directed weights:
    piriform_set_associational_weights \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask box                                                 \
            {PIRIFORM_X_CENTER} 0.0                                     \
            {PIRIFORM_X_EXTENT} {PIRIFORM_Y_EXTENT}                     \
        -destmask box -1.0 -1.0 0.0 1.0                                 \
        -relative                                                       \
        -expdecay {{pyr_pyr_local_maxwt {compt} "PPC"}                  \
                  * PYR_PYR_LOCAL_PA_SCALE}                             \
                  {PYR_PYR_LOCAL_MIN_WT}                                \
                  {PYR_PYR_LOCAL_DECAY_RATE} 0.0                        \
        -gaussian {PYR_PYR_LOCAL_STDEV} {PYR_PYR_LOCAL_MAXDEV}          \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}

    // Posteriorly-directed weights:
    piriform_set_associational_weights \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask box                                                 \
            {PIRIFORM_X_CENTER} 0.0                                     \
            {PIRIFORM_X_EXTENT} {PIRIFORM_Y_EXTENT}                     \
        -destmask box 0.0 -1.0 1.0 1.0                                  \
        -relative                                                       \
        -expdecay {{pyr_pyr_local_maxwt {compt} "PPC"}                  \
                  * PYR_PYR_LOCAL_AP_SCALE}                             \
                  {PYR_PYR_LOCAL_MIN_WT}                                \
                  {PYR_PYR_LOCAL_DECAY_RATE} 0.0                        \
        -gaussian {PYR_PYR_LOCAL_STDEV} {PYR_PYR_LOCAL_MAXDEV}          \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}
end


if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo
    echo ----------------------------------------
    echo Setting up axonal conduction delays.
    echo ----------------------------------------
    echo
end

//
// The axonal conduction velocities for the associational fibers are
// distributed lognormally.  The parameters of the lognormal distribution
// vary depending on the site of origin of the fibers.  There are three
// regions:
//
// 1) the ventral anterior piriform cortex (vAPC)
// 2) the dorsal anterior piriform cortex (dAPC)
// 3) the posterior piriform cortex (PPC)
//
// The ventral anterior piriform cortex consists of all cells whose
// xy dimensions lie in a ellipse whose origin is the ventral-anteriormost
// part of the cortex (which is the origin of the coordinate system I'm
// using) and whose principal axes are (PIRIFORM_X_EXTENT / 2) and
// (PIRIFORM_Y_EXTENT / 2) for the x and y axis, respectively.
//
// The posterior piriform cortex is the caudal-most half of the cortex
// (i.e. where the x dimension is >= (PIRIFORM_X_EXTENT / 2)).
//
// The dorsal anterior piriform cortex is what's left.
//
// Note that Matt Wilson's model only distinguished between the rostral
// (anterior) and the caudal (posterior) piriform cortex.
//

if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo
    echo Setting up delays for associational fibers originating from
    echo cells located in the ventral anterior piriform cortex (vAPC).
    echo
end

foreach compt ({arglist {all_compts}})
    piriform_set_associational_delays \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask ellipse                                             \
            0.0 0.0 {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}             \
        -vel_lognormal {PIRIFORM_ASSOCIATIONAL_VAPC_VELOCITY_MODE}      \
                       {PIRIFORM_ASSOCIATIONAL_VAPC_VELOCITY_MEDIAN}    \
        -mindelay {sim_mindelay}                                        \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}
end


if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo
    echo Setting up delays for associational fibers originating from
    echo cells located in the dorsal anterior piriform cortex (dAPC).
    echo
end

foreach compt ({arglist {all_compts}})
    piriform_set_associational_delays \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask box                                                 \
            0.0 0.0 {PIRIFORM_X_CENTER} {PIRIFORM_Y_EXTENT}             \
        -sourcehole ellipse                                             \
            0.0 0.0 {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER}             \
        -vel_lognormal {PIRIFORM_ASSOCIATIONAL_DAPC_VELOCITY_MODE}      \
                       {PIRIFORM_ASSOCIATIONAL_DAPC_VELOCITY_MEDIAN}    \
        -mindelay {sim_mindelay}                                        \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}
end


if (PYR_PYR_LOCAL_VERBOSE >= 0)
    echo
    echo Setting up delays for associational fibers originating from
    echo cells located in the posterior piriform cortex (PPC).
    echo
end

foreach compt ({arglist {all_compts}})
    piriform_set_associational_delays \
        /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen             \
        /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn     \
        -sourcemask box                                                 \
            {PIRIFORM_X_CENTER} 0.0                                     \
            {PIRIFORM_X_EXTENT} {PIRIFORM_Y_EXTENT}                     \
        -vel_lognormal {PIRIFORM_ASSOCIATIONAL_PPC_VELOCITY_MODE}       \
                       {PIRIFORM_ASSOCIATIONAL_PPC_VELOCITY_MEDIAN}     \
        -mindelay {sim_mindelay}                                        \
        -verbose {PYR_PYR_LOCAL_VERBOSE} -debug {PYR_PYR_LOCAL_DEBUG}
end


//
// Function to dump the pyr->pyr local weights to xview files.
//

function dump_pyr_to_pyr_local_weights
    str compt
    str all_compts = "basal_1 basal_2 basal_3 basal_4 basal_5 basal_6"

    if (PYR_PYR_LOCAL_VERBOSE >= 0)
        echo "Dumping weights from pyramidal cell spikegens "
        echo "    to pyramidal cell synchans (local connections)..."
    end

    foreach compt ({arglist {all_compts}})
        piriform_dump_synaptic_weights  \
            /piriform_cortex/pyramidal_cell[]/{compt}/pyr_local_exc_syn \
            {outdir_syn}/nsyn_pyr_to_pyr_{compt}_local                  \
            -source_element_name pyr_spikegen                           \
            -sourceall                                                  \
            -xview_format                                               \
                {PIRIFORM_NX_PYRAMIDAL} {PIRIFORM_NY_PYRAMIDAL}         \
                0.0 {PIRIFORM_X_EXTENT} 0.0 {PIRIFORM_Y_EXTENT}         \
            -debug {DUMP_WEIGHTS_DEBUG}
    end
end

