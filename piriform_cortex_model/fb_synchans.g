// genesis

//
// fb_synchans.g
//
//     This script contains the final versions of various synaptic
//     objects that form part of the feedforward inhibitory interneuron
//     model.
//

//
// Since there is little or no evidence on synaptic parameters for synapses
// onto the feedback inhibitory cells, I'm basically assuming that
// they don't have NMDA currents, synaptic facilitation or depression, or
// neuromodulation, because there is no evidence for these one way or the
// other.  However, I'm also providing alternate versions that have these
// features in case I want to experiment with them later.
//
// I'm also assuming that there are no afferent to feedback inhibitory
// neuron synapses.
//


// ----------------------------------------------------------------------
//
// ASSOCIATION FIBER TO FB INHIBITORY INTERNEURON SYNAPSE.
//
// ----------------------------------------------------------------------

//
// The tau1 and tau2 values for this synaptic connection are set to be
// identical to those of the association fiber synapses onto pyramidal
// cells.
//

//
// Note that depr1_tau is really high for the 1b association fiber
// synapse.  This may cause weird behaviors.  It's safest to use this
// when neuromodulation is fully on or off at the beginning of the
// simulation.
//

// This version has NMDA and facilitation.  Neuromodulation is there,
// but is turned off.

function make_fb_assoc_exc_syn_NMDA_fac_mod
    if ({exists fb_assoc_exc_syn_NMDA_fac_mod})
        return
    end

    create mod_facsynchan2_wNMDA fb_assoc_exc_syn_NMDA_fac_mod
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0                       \
        Ek                   {FB_AMPA_EREV}            \
        tau1                 0.0008                    \
        tau2                 0.0028                    \
        mod_index           -1                         \
        fac_depr_on          1                         \
        max_fac              2.0                       \
        mod_fac_thresh       0.5                       \
        fac_per_spike        0.127556                  \
        fac_tau              0.0100049                 \
        depr1_per_spike      0.0271728                 \
        depr1_tau            0.894174                  \
        depr2_per_spike      0.124461                  \
        depr2_tau            0.0895235                 \
        mod_fac_per_spike    1.25173                   \
        mod_fac_tau          0.15019                   \
        mod_depr1_per_spike  0.663704                  \
        mod_depr1_tau        0.139363                  \
        mod_depr2_per_spike  0.137636                  \
        mod_depr2_tau        0.126516                  \
        NMDA_Ek              {FB_NMDA_EREV}            \
        NMDA_tau1            0.060                     \
        NMDA_tau2            0.066                     \
        NMDA_pGbar           {FP_FB_ASSOC_NMDA_PGBAR}  \
        NMDA_Mg              1.0                       \   // mM
        NMDA_eta             {FP_NMDA_ETA}             \   // mM^(-1)
        NMDA_gamma           {FP_NMDA_GAMMA}           \   // V^(-1)
        NMDA_mod_index      -1
end


// This version has no NMDA current.

function make_fb_assoc_exc_syn_fac_mod
    if ({exists fb_assoc_exc_syn_fac_mod})
        return
    end

    create mod_facsynchan2 fb_assoc_exc_syn_fac_mod
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0              \
        Ek                   {FB_AMPA_EREV}   \
        tau1                 0.0008           \
        tau2                 0.0028           \
        mod_index           -1                \
        fac_depr_on          1                \
        max_fac              2.0              \
        mod_fac_thresh       0.5              \
        fac_per_spike        0.127556         \
        fac_tau              0.0100049        \
        depr1_per_spike      0.0271728        \
        depr1_tau            0.894174         \
        depr2_per_spike      0.124461         \
        depr2_tau            0.0895235        \
        mod_fac_per_spike    1.25173          \
        mod_fac_tau          0.15019          \
        mod_depr1_per_spike  0.663704         \
        mod_depr1_tau        0.139363         \
        mod_depr2_per_spike  0.137636         \
        mod_depr2_tau        0.126516
end


// This version has no facilitation or depression.

function make_fb_assoc_exc_syn_NMDA_mod
    if ({exists fb_assoc_exc_syn_NMDA_mod})
        return
    end

    create mod_synchan_wNMDA fb_assoc_exc_syn_NMDA_mod
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0                       \
        Ek                   {FB_AMPA_EREV}            \
        tau1                 0.0008                    \
        tau2                 0.0028                    \
        mod_index           -1                         \
        NMDA_Ek              {FB_NMDA_EREV}            \
        NMDA_tau1            0.060                     \
        NMDA_tau2            0.066                     \
        NMDA_pGbar           {FP_FB_ASSOC_NMDA_PGBAR}  \
        NMDA_Mg              1.0                       \   // mM
        NMDA_eta             0.33                      \   // mM^(-1)
        NMDA_gamma           {FP_NMDA_GAMMA}           \   // V^(-1)
        NMDA_mod_index      -1
end


// This version has no NMDA component or facilitation or depression.
// It has neuromodulation, but it's turned off.

function make_fb_assoc_exc_syn
    if ({exists fb_assoc_exc_syn})
        return
    end

    create mod_synchan fb_assoc_exc_syn
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar                 0.0              \
        Ek                   {FB_AMPA_EREV}   \
        tau1                 0.0008           \
        tau2                 0.0028           \
        mod_index           -1
end



// ----------------------------------------------------------------------
//
// FB INHIBITORY INTERNEURON TO FB INHIBITORY INTERNEURON SYNAPSE.
//
// ----------------------------------------------------------------------

// N.B. This has no GABA-B component.  It is identical to the corresponding
//      channel from fb interneurons to pyramidal cells.

function make_fb_fb_inh_syn_dep
    if ({exists fb_fb_inh_syn_dep})
        return
    end

    create double_depsynchan fb_fb_inh_syn_dep
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar             0.0                   \
        Ek               {FB_GABA_A_EREV}      \  // fast GABA-A
        tau1             0.00124               \
        tau2             0.00725               \
        pGbar1           {FP_FB_INH_PGBAR1}    \
        pGbar2           {FP_FB_INH_PGBAR2}    \
        ch2_Ek           {FB_GABA_A_EREV}      \  // slow GABA-A
        ch2_tau1         0.00074               \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2} \
        depr_on          1                     \
        max_depr         1.0                   \
        depr1_per_spike  1.03                  \  // fast GABA-A depression
        depr1_tau        0.090                 \
        depr2_per_spike  0.66                  \  // slow GABA-A depression
        depr2_tau1       0.200                 \
        depr2_tau2       0.200
end


// This is the same, without depression.

function make_fb_fb_inh_syn
    if ({exists fb_fb_inh_syn})
        return
    end

    create double_synchan fb_fb_inh_syn
    // N.B. Gbar is set by the cellreader.
    setfield ^ \
        Gbar             0.0                   \
        Ek               {FB_GABA_A_EREV}      \  // fast GABA-A
        tau1             0.00124               \
        tau2             0.00725               \
        pGbar1           {FP_FB_INH_PGBAR1}    \
        pGbar2           {FP_FB_INH_PGBAR2}    \
        ch2_Ek           {FB_GABA_A_EREV}      \  // slow GABA-A
        ch2_tau1         0.00074               \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}
end


