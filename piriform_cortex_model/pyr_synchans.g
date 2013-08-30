// genesis

//
// pyr_synchans.g
//
//     This script contains the final versions of various synaptic
//     objects that form part of the pyramidal cell model.
//

//
// N.B. There is no compelling experimental evidence regarding what the
//      relative proportion of NMDA to non-NMDA receptors is.  The Kapur
//      et. al. paper (J. Neurophys. 78(5): 2546-59, 1997) implies that
//      it's about 60% of the AMPA component, so that's what I'll use for
//      layer 1b. For layer 1a I'll use 20%, since the LTP evidence
//      (e.g. Kanter and Haberly, Brain Res. 525: 175-179 (1990)) suggests
//      that there's much less NMDA current in layer 1a.  Other NMDA
//      parameters are also taken from Kapur et. al.
//
//      The AMPA taus are from my own experimental work, but are similar
//      to what Kapur et. al. use (actually slightly slower).
//


// ----------------------------------------------------------------------
//
// EXCITATORY SYNAPSES ONTO PYRAMIDAL CELLS.
//
// ----------------------------------------------------------------------

// The synaptic tau values for layer 1a and 1b synapses were taken from my
// extracellular experiments.  The facilitation/depression parameters were
// taken from a parameter search; that's why there are so many decimal
// places of "accuracy".

//
// 1) Afferent (layer 1a) synapses.
//

function make_pyr_aff_exc_syn
    if ({exists pyr_aff_exc_syn})
        return
    end

    create mod_facsynchan_wNMDA pyr_aff_exc_syn
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0                       \
        Ek                   {PYR_AMPA_EREV}           \
        tau1                 0.001                     \
        tau2                 0.0016                    \
        mod_index            3                         \
        fac_depr_on          1                         \
        max_fac              2.0                       \
        fac_per_spike        3.64462                   \
        fac_tau              0.162229                  \
        depr1_per_spike      0.786772                  \
        depr1_tau            0.1262774                 \
        depr2_per_spike      0.640371                  \
        depr2_tau            0.321689                  \
        NMDA_Ek              {PYR_NMDA_EREV}           \
        NMDA_tau1            0.060                     \
        NMDA_tau2            0.066                     \
        NMDA_pGbar           {FP_PYR_AFF_NMDA_PGBAR}   \
        NMDA_Mg              1.0                       \   // mM
        NMDA_eta             {FP_NMDA_ETA}             \   // mM^(-1)
        NMDA_gamma           {FP_NMDA_GAMMA}           \   // V^(-1)
        NMDA_mod_index       3
end


//
// 2) Associational (layer 1b) synapses.
//
// Note that depr1_tau is really high for the 1b association fiber
// synapse.  This may cause weird behaviors when switching between
// the non-neuromodulated and the modulated conditions.
//

function make_pyr_assoc_exc_syn
    if ({exists pyr_assoc_exc_syn})
        return
    end

    create mod_facsynchan2_wNMDA pyr_assoc_exc_syn
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0                        \
        Ek                   {PYR_AMPA_EREV}            \
        tau1                 0.0008                     \
        tau2                 0.0028                     \
        mod_index            2                          \
        fac_depr_on          1                          \
        max_fac              2.0                        \
        mod_fac_thresh       0.5                        \
        fac_per_spike        0.127556                   \
        fac_tau              0.0100049                  \
        depr1_per_spike      0.0271728                  \
        depr1_tau            0.894174                   \
        depr2_per_spike      0.124461                   \
        depr2_tau            0.0895235                  \
        mod_fac_per_spike    1.25173                    \
        mod_fac_tau          0.15019                    \
        mod_depr1_per_spike  0.663704                   \
        mod_depr1_tau        0.139363                   \
        mod_depr2_per_spike  0.137636                   \
        mod_depr2_tau        0.126516                   \
        NMDA_Ek              {PYR_NMDA_EREV}            \
        NMDA_tau1            0.060                      \
        NMDA_tau2            0.066                      \
        NMDA_pGbar           {FP_PYR_ASSOC_NMDA_PGBAR}  \
        NMDA_Mg              1.0                        \   // mM
        NMDA_eta             {FP_NMDA_ETA}              \   // mM^(-1)
        NMDA_gamma           {FP_NMDA_GAMMA}            \   // V^(-1)
        NMDA_mod_index       2
end


//
// 3) Local excitatory (layer 3) synapses.
//
//
// Here I'm guessing that layer 3 associational synapses behave
// the same way as layer 1b associational synapses.  I have no
// evidence to support that, and in fact it would be interesting
// to see what would happen if, for instance, layer 3 synapses
// respond differently to neuromodulators compared to layer 1b
// associational synapses.
//
// TODO: see what happens to the network dynamics when this synapse
// is insensitive to NE.
//

function make_pyr_local_exc_syn
    if ({exists pyr_local_exc_syn})
        return
    end

    create mod_facsynchan2_wNMDA pyr_local_exc_syn
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0                        \
        Ek                   {PYR_AMPA_EREV}            \
        tau1                 0.0008                     \
        tau2                 0.0028                     \
        mod_index            2                          \
        fac_depr_on          1                          \
        max_fac              2.0                        \
        mod_fac_thresh       0.5                        \
        fac_per_spike        0.127556                   \
        fac_tau              0.0100049                  \
        depr1_per_spike      0.0271728                  \
        depr1_tau            0.894174                   \
        depr2_per_spike      0.124461                   \
        depr2_tau            0.0895235                  \
        mod_fac_per_spike    1.25173                    \
        mod_fac_tau          0.15019                    \
        mod_depr1_per_spike  0.663704                   \
        mod_depr1_tau        0.139363                   \
        mod_depr2_per_spike  0.137636                   \
        mod_depr2_tau        0.126516                   \
        NMDA_Ek              {PYR_NMDA_EREV}            \
        NMDA_tau1            0.060                      \
        NMDA_tau2            0.066                      \
        NMDA_pGbar           {FP_PYR_ASSOC_NMDA_PGBAR}  \
        NMDA_Mg              1.0                        \   // mM
        NMDA_eta             {FP_NMDA_ETA}              \   // mM^(-1)
        NMDA_gamma           {FP_NMDA_GAMMA}            \   // V^(-1)
        NMDA_mod_index       2
end


//
// 4) Random synaptic input.
//
// These synapses are meant to represent the aggregate effect of synapses
// from areas external to the piriform cortex (not including the bulb);
// their effect is to bias the cell so that it's closer to the firing
// threshold.  `ext' stands for "external".
//

function make_pyr_ext_exc_syn
    if ({exists pyr_ext_exc_syn})
        return
    end

/*
    create fsynchan pyr_ext_exc_syn
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0                \
        Ek                   {PYR_AMPA_EREV}    \
        tau1                 0.0008             \
        tau2                 0.0028             \
        frequency            0.0                \    // Set later
        bg_weight            0.0                     // Set later
*/

     create mod_synchan_wNMDA pyr_ext_exc_syn
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0                       \
        Ek                   {PYR_AMPA_EREV}           \
        tau1                 0.0008                    \
        tau2                 0.0028                    \
        frequency            0.0                       \    // Set later
        bg_weight            0.0                       \    // Set later
        mod_index           -1                         \
        NMDA_Ek              {PYR_NMDA_EREV}           \
        NMDA_tau1            0.060                     \
        NMDA_tau2            0.066                     \
        NMDA_pGbar           {FP_PYR_EXT_NMDA_PGBAR}   \
        NMDA_Mg              1.0                       \   // mM
        NMDA_eta             {FP_NMDA_ETA}             \   // mM^(-1)
        NMDA_gamma           {FP_NMDA_GAMMA}           \   // V^(-1)
        NMDA_mod_index      -1
end


function set_pyramidal_bg_input
    str i, j
    float x, y
    str region

    foreach i ({el /piriform_cortex/pyramidal_cell[]/#/pyr_ext_exc_syn})
        x = {getfield {i} x}
        y = {getfield {i} y}
        region = {get_region {x} {y}}

        if (region == "VAPC")
            setfield {i}  frequency {FP_BG_FREQ_VAPC}  \
                bg_weight {FP_BG_WT_VAPC}
        elif (region == "DAPC")
            setfield {i}  frequency {FP_BG_FREQ_DAPC}  \
                bg_weight {FP_BG_WT_DAPC}
        elif (region == "PPC")
            setfield {i}   frequency {FP_BG_FREQ_PPC}  \
                bg_weight {FP_BG_WT_PPC}
        else
            echo set_pyramidal_bg_input: ERROR! invalid region {region}
        end
    end
end


function clear_pyramidal_bg_input
    str i, j

    foreach i ({el /piriform_cortex/pyramidal_cell[]/#/pyr_ext_exc_syn})
        setfield {i}  frequency 0.0  bg_weight 0.0
    end
end



// ----------------------------------------------------------------------
//
// INHIBITORY SYNAPSES ONTO PYRAMIDAL CELLS.
//
// ----------------------------------------------------------------------

//
// Inhibitory synapses.  These have multiple synaptic components
// (fast GABA-A, slow GABA-A, GABA-B) and also show synaptic
// depression for the GABA-A components.  The depression is different
// for fast and slow GABA-A components, presumably reflecting the greater
// sensitivity of slow GABA-A synapses to presynaptic GABA-B inhibition.
// This data is mainly from Kapur et. al., J. Neurophys. 78(5):2531-45
// and Kapur et. al., J. Neurophys. 78(5):2546-59.  Note that our taus
// look different because we represent them as a difference of
// exponentials, whereas they use a slightly different equation.  The
// effect is the same.
//
// They use in their model:
//
// -- 100 synapses @ Gbar = 1.15 nS GABA-A (fast) from 100-400 um from soma
//    i.e. 115 nS GABA-A (fast)
// -- 100 synapses @ Gbar = 0.25 nS GABA-A (slow) from 200-600 um from soma
//    i.e. 25 nS GABA-A (slow)
// -- 100 synapses @ Gbar = 0.03 nS GABA-B from 100-600 um from soma
//    i.e. 3 nS GABA-B
//
// Assuming that all my layer 1 dendrites are about 50 um long, this gives
// (roughly) going from most proximal to most distal (note that with our
// cell, the distalmost tip is only about 450 um from the soma):
//
// -- deep Ib #1:  no inhibitory input
// -- deep Ib #2:  no inhibitory input
// -- deep Ib #3:  fast GABA-A, GABA-B               -- inh1
// -- sup  Ib #1:  fast GABA-A, GABA-B               -- inh1
// -- sup  Ib #2:  fast GABA-A, slow GABA-A, GABA-B  -- inh2
// -- sup  Ib #3:  fast GABA-A, slow GABA-A, GABA-B  -- inh2
// -- Ia #1:       slow GABA-A, GABA-B               -- inh3
// -- Ia #2:       slow GABA-A, GABA-B               -- inh3
//
// We thus need three types of inhibitory synchans along the apical
// dendrite; we use triple_depsynchans for all three types of synchans
// since they all have a GABA-B component.
//
// Here are approximate maximal conductances (in nS) for all the inhibitory
// synaptic conductances in each of the pyramidal cell's compartments
// scaled to give the total conductance values in the Kapur et. al.
// paper:
//
// -- deep Ib #1:  none
// -- deep Ib #2:  none
// -- deep Ib #3:  Afast: 28.75                 B: 0.5  -- layer1_inh_syn_1
// -- sup Ib  #1:  Afast: 28.75                 B: 0.5  -- layer1_inh_syn_1
// -- sup Ib  #2:  Afast: 28.75   Aslow: 6.25   B: 0.5  -- layer1_inh_syn_2
// -- sup Ib  #3:  Afast: 28.75   Aslow: 6.25   B: 0.5  -- layer1_inh_syn_2
// -- Ia #1:                      Aslow: 6.25   B: 0.5  -- layer1_inh_syn_3
// -- Ia #2:                      Aslow: 6.25   B: 0.5  -- layer1_inh_syn_3
//
//
// If we set the Gbar to correspond to the fast GABA-A conductance,
// we get the following pGbars:
//
// -- deep Ib #1:  none
// -- deep Ib #2:  none
// -- deep Ib #3:  Afast: 1.0                 B: 0.0167 -- layer1_inh_syn_1
// -- sup Ib  #1:  Afast: 1.0                 B: 0.0167 -- layer1_inh_syn_1
// -- sup Ib  #2:  Afast: 1.0   Aslow: 0.22   B: 0.0167 -- layer1_inh_syn_2
// -- sup Ib  #3:  Afast: 1.0   Aslow: 0.22   B: 0.0167 -- layer1_inh_syn_2
// -- Ia #1:                    Aslow: 0.22   B: 0.0167 -- layer1_inh_syn_3
// -- Ia #2:                    Aslow: 0.22   B: 0.0167 -- layer1_inh_syn_3
//
// If we want the same conductance values as the Kapur model, we have to
// assume that we have 25 inhibitory synapses (with individual conductance
// values of 1.15 nS each) per compartment.
//
// It's important to realize that the Kapur et. al. model parameters were
// adjusted to fit IPSC data evoked by shock stimuli.  However, their
// experimental estimates of fast/slow GABA-A ratios are somewhat
// different.  In their defense, their experiments didn't have as high a
// spatial resolution as their model did.
//


// Used for deep 1b #1 and #2 compartments.  The Kapur model doesn't
// have this.

function make_pyr_layer1_inh_syn_0
    if ({exists pyr_inh_syn_0})
        return
    end

    //create triple_depsynchan pyr_layer1_inh_syn_0
    create triple_synchan pyr_layer1_inh_syn_0
    setfield ^ \
        Gbar             0.0                       \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}         \
        tau1             0.00124                   \
        tau2             {FP_FAST_GABA_A_TAU2}     \
        pGbar1           {FP_PYR_INH_1_0_PGBAR1}   \  // fast GABA-A
        pGbar2           {FP_PYR_INH_1_0_PGBAR2}   \  // slow GABA-A
        ch2_Ek           {PYR_GABA_A_EREV}         \
        ch2_tau1         0.00074                   \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}     \
        pGbar3           {FP_PYR_INH_1_0_PGBAR3}   \  // GABA-B
        ch3_Ek           {PYR_GABA_B_EREV}         \
        ch3_tau1         {FP_GABA_B_TAU1}          \
        ch3_tau2         {FP_GABA_B_TAU2}
/*
        depr_on          1                         \
        max_depr         5.0                       \
        depr1_per_spike  1.03                      \  // fast GABA-A depr
        depr1_tau        0.090                     \
        depr2_per_spike  0.66                      \  // slow GABA-A depr
        depr2_tau1       0.200                     \
        depr2_tau2       0.200
*/
end


// Used for deep 1b #3 and sup 1b #1 compartments:

function make_pyr_layer1_inh_syn_1
    if ({exists pyr_inh_syn_1})
        return
    end

    create triple_depsynchan pyr_layer1_inh_syn_1
    setfield ^ \
        Gbar             0.0                       \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}         \
        tau1             0.00124                   \
        tau2             {FP_FAST_GABA_A_TAU2}     \
        pGbar1           {FP_PYR_INH_1_1_PGBAR1}   \  // fast GABA-A
        pGbar2           {FP_PYR_INH_1_1_PGBAR2}   \  // slow GABA-A
        ch2_Ek           {PYR_GABA_A_EREV}         \
        ch2_tau1         0.00074                   \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}     \
        pGbar3           {FP_PYR_INH_1_1_PGBAR3}   \  // GABA-B
        ch3_Ek           {PYR_GABA_B_EREV}         \
        ch3_tau1         {FP_GABA_B_TAU1}          \
        ch3_tau2         {FP_GABA_B_TAU2}          \
        depr_on          {FP_INH_DEPR}             \
        max_depr         5.0                       \
        depr1_per_spike  1.03                      \  // fast GABA-A depr
        depr1_tau        0.090                     \
        depr2_per_spike  0.66                      \  // slow GABA-A depr
        depr2_tau1       0.200                     \
        depr2_tau2       0.200
end


// Used for sup 1b #2 and #3 compartments:

function make_pyr_layer1_inh_syn_2
    if ({exists pyr_layer1_inh_syn_2})
        return
    end

    create triple_depsynchan pyr_layer1_inh_syn_2
    setfield ^ \
        Gbar             0.0                        \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}          \
        tau1             0.00124                    \
        tau2             {FP_FAST_GABA_A_TAU2}      \
        pGbar1           {FP_PYR_INH_1_2_PGBAR1}    \  // fast GABA-A
        pGbar2           {FP_PYR_INH_1_2_PGBAR2}    \  // slow GABA-A
        ch2_Ek           {PYR_GABA_A_EREV}          \
        ch2_tau1         0.00074                    \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}      \
        pGbar3           {FP_PYR_INH_1_2_PGBAR3}    \  // GABA-B
        ch3_Ek           {PYR_GABA_B_EREV}          \
        ch3_tau1         {FP_GABA_B_TAU1}           \
        ch3_tau2         {FP_GABA_B_TAU2}           \
        depr_on          {FP_INH_DEPR}              \
        max_depr         5.0                        \
        depr1_per_spike  1.03                       \  // fast GABA-A depr
        depr1_tau        0.090                      \
        depr2_per_spike  0.66                       \  // slow GABA-A depr
        depr2_tau1       0.200                      \
        depr2_tau2       0.200
end


// Used for 1a #1 and #2 compartments:

function make_pyr_layer1_inh_syn_3
    if ({exists pyr_layer1_inh_syn_3})
        return
    end

    create triple_depsynchan pyr_layer1_inh_syn_3
    setfield ^ \
        Gbar             0.0                        \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}          \
        tau1             0.00124                    \
        tau2             {FP_FAST_GABA_A_TAU2}      \
        pGbar1           {FP_PYR_INH_1_3_PGBAR1}    \  // fast GABA-A
        pGbar2           {FP_PYR_INH_1_3_PGBAR2}    \  // slow GABA-A
        ch2_Ek           {PYR_GABA_A_EREV}          \
        ch2_tau1         0.00074                    \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}      \
        pGbar3           {FP_PYR_INH_1_3_PGBAR3}    \  // GABA-B
        ch3_Ek           {PYR_GABA_B_EREV}          \
        ch3_tau1         {FP_GABA_B_TAU1}           \
        ch3_tau2         {FP_GABA_B_TAU2}           \
        depr_on          {FP_INH_DEPR}              \
        max_depr         5.0                        \
        depr1_per_spike  1.03                       \  // fast GABA-A depr
        depr1_tau        0.090                      \
        depr2_per_spike  0.66                       \  // slow GABA-A depr
        depr2_tau1       0.200                      \
        depr2_tau2       0.200
end


//
// Synapse from feedback inhibitory neuron to pyramidal cell.
// This has no GABA-B component.
// The GABA-A fast/slow ratio is taken from Kapur et. al.
// (J. Neurophys. 78(5): 2531-45, 1997; table 1).
//

function make_pyr_layer2_3_inh_syn
    if ({exists pyr_layer2_3_inh_syn})
        return
    end

    create double_depsynchan pyr_layer2_3_inh_syn
    setfield ^ \
        Gbar             0.0                        \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}          \  // fast GABA-A
        tau1             0.00124                    \
        tau2             {FP_FAST_GABA_A_TAU2}      \
        pGbar1           {FP_PYR_INH_2_3_PGBAR1}    \
        pGbar2           {FP_PYR_INH_2_3_PGBAR2}    \
        ch2_Ek           {PYR_GABA_A_EREV}          \  // slow GABA-A
        ch2_tau1         0.00074                    \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}      \
        depr_on          {FP_INH_DEPR}              \
        max_depr         1.0                        \
        depr1_per_spike  1.03                       \  // fast GABA-A depr
        depr1_tau        0.090                      \
        depr2_per_spike  0.66                       \  // slow GABA-A depr
        depr2_tau1       0.200                      \
        depr2_tau2       0.200
end


//
// Extra versions of the feedforward inhibitory synapses that can be
// used as alternatives to the above channels.
//

function make_pyr_layer1_inh_syn_0b
    if ({exists pyr_inh_syn_0b})
        return
    end

    create triple_synchan pyr_layer1_inh_syn_0b
    setfield ^ \
        Gbar             0.0                       \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}         \
        tau1             0.00124                   \
        tau2             {FP_FAST_GABA_A_TAU2}     \
        pGbar1           {FP_PYR_INH_1_0_B_PGBAR1} \  // fast GABA-A
        pGbar2           {FP_PYR_INH_1_0_B_PGBAR2} \  // slow GABA-A
        ch2_Ek           {PYR_GABA_A_EREV}         \
        ch2_tau1         0.00074                   \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}     \
        pGbar3           {FP_PYR_INH_1_0_B_PGBAR3} \  // GABA-B
        ch3_Ek           {PYR_GABA_B_EREV}         \
        ch3_tau1         {FP_GABA_B_TAU1}          \
        ch3_tau2         {FP_GABA_B_TAU2}
/*
        depr_on          1                         \
        max_depr         5.0                       \
        depr1_per_spike  1.03                      \  // fast GABA-A depr
        depr1_tau        0.090                     \
        depr2_per_spike  0.66                      \  // slow GABA-A depr
        depr2_tau1       0.200                     \
        depr2_tau2       0.200
*/
end


// Used for deep 1b #3 and sup 1b #1 compartments:

function make_pyr_layer1_inh_syn_1b
    if ({exists pyr_inh_syn_1b})
        return
    end

    create triple_depsynchan pyr_layer1_inh_syn_1b
    setfield ^ \
        Gbar             0.0                       \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}         \
        tau1             0.00124                   \
        tau2             {FP_FAST_GABA_A_TAU2}     \
        pGbar1           {FP_PYR_INH_1_1_B_PGBAR1} \  // fast GABA-A
        pGbar2           {FP_PYR_INH_1_1_B_PGBAR2} \  // slow GABA-A
        ch2_Ek           {PYR_GABA_A_EREV}         \
        ch2_tau1         0.00074                   \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}     \
        pGbar3           {FP_PYR_INH_1_1_B_PGBAR3} \  // GABA-B
        ch3_Ek           {PYR_GABA_B_EREV}         \
        ch3_tau1         {FP_GABA_B_TAU1}          \
        ch3_tau2         {FP_GABA_B_TAU2}          \
        depr_on          1                         \
        max_depr         5.0                       \
        depr1_per_spike  1.03                      \  // fast GABA-A depr
        depr1_tau        0.090                     \
        depr2_per_spike  0.66                      \  // slow GABA-A depr
        depr2_tau1       0.200                     \
        depr2_tau2       0.200
end


// Used for sup 1b #2 and #3 compartments:

function make_pyr_layer1_inh_syn_2b
    if ({exists pyr_layer1_inh_syn_2b})
        return
    end

    create triple_depsynchan pyr_layer1_inh_syn_2b
    setfield ^ \
        Gbar             0.0                        \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}          \
        tau1             0.00124                    \
        tau2             {FP_FAST_GABA_A_TAU2}      \
        pGbar1           {FP_PYR_INH_1_2_B_PGBAR1}  \  // fast GABA-A
        pGbar2           {FP_PYR_INH_1_2_B_PGBAR2}  \  // slow GABA-A
        ch2_Ek           {PYR_GABA_A_EREV}          \
        ch2_tau1         0.00074                    \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}      \
        pGbar3           {FP_PYR_INH_1_2_B_PGBAR3}  \  // GABA-B
        ch3_Ek           {PYR_GABA_B_EREV}          \
        ch3_tau1         {FP_GABA_B_TAU1}           \
        ch3_tau2         {FP_GABA_B_TAU2}           \
        depr_on          1                          \
        max_depr         5.0                        \
        depr1_per_spike  1.03                       \  // fast GABA-A depr
        depr1_tau        0.090                      \
        depr2_per_spike  0.66                       \  // slow GABA-A depr
        depr2_tau1       0.200                      \
        depr2_tau2       0.200
end


// Used for 1a #1 and #2 compartments:

function make_pyr_layer1_inh_syn_3b
    if ({exists pyr_layer1_inh_syn_3b})
        return
    end

    create triple_depsynchan pyr_layer1_inh_syn_3b
    setfield ^ \
        Gbar             0.0                        \  // set by cellreader
        Ek               {PYR_GABA_A_EREV}          \
        tau1             0.00124                    \
        tau2             {FP_FAST_GABA_A_TAU2}      \
        pGbar1           {FP_PYR_INH_1_3_B_PGBAR1}  \  // fast GABA-A
        pGbar2           {FP_PYR_INH_1_3_B_PGBAR2}  \  // slow GABA-A
        ch2_Ek           {PYR_GABA_A_EREV}          \
        ch2_tau1         0.00074                    \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}      \
        pGbar3           {FP_PYR_INH_1_3_B_PGBAR3}  \  // GABA-B
        ch3_Ek           {PYR_GABA_B_EREV}          \
        ch3_tau1         {FP_GABA_B_TAU1}           \
        ch3_tau2         {FP_GABA_B_TAU2}           \
        depr_on          1                          \
        max_depr         5.0                        \
        depr1_per_spike  1.03                       \  // fast GABA-A depr
        depr1_tau        0.090                      \
        depr2_per_spike  0.66                       \  // slow GABA-A depr
        depr2_tau1       0.200                      \
        depr2_tau2       0.200
end

