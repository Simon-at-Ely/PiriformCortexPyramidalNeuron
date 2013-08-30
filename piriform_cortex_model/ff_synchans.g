// genesis

//
// ff_synchans.g
//
//     This script contains the final versions of various synaptic
//     objects that form part of the feedforward inhibitory interneuron
//     model.
//


// ----------------------------------------------------------------------
//
// LOT AFFERENT TO FF INHIBITORY INTERNEURON SYNAPSE.
//
// ----------------------------------------------------------------------

//
// The tau1 and tau2 values for this synaptic connection are set to be
// identical to those of the mitral cell -> pyramidal cell excitatory
// synaptic connection.
//

function make_ff_aff_exc_syn
    if ({exists ff_aff_exc_syn})
        return
    end

    create mod_synchan ff_aff_exc_syn
    setfield ^ \
        Gbar                 0.0              \  // set by cellreader
        Ek                   {FF_AMPA_EREV}   \
        tau1                 0.001            \
        tau2                 0.0016           \
        mod_index           -1
end


// ----------------------------------------------------------------------
//
// ASSOCIATION FIBER TO FF INHIBITORY INTERNEURON SYNAPSE.
//
// ----------------------------------------------------------------------

//
// This channel is not used by feedforward inhibitory cells but
// is used by the feedforward/feedback inhibitory cells.
//

// NOTE: We have no data for this channel.  I'm making the tau2 value
// bigger than that for the pyramidal cell fast GABA-A channel in order
// to model (to some extent) the delaying action of the dendrites (which
// we aren't simulating here).

function make_ff_assoc_exc_syn
    if ({exists ff_assoc_exc_syn})
        return
    end

    create mod_synchan ff_assoc_exc_syn
    setfield ^ \
        Gbar                 0.0              \  // set by cellreader
        Ek                   {FF_AMPA_EREV}   \
        tau1                 0.0008           \
        tau2                 0.020            \
        mod_index           -1

    // Use this if you want synaptic depression.
/*
    create mod_facsynchan ff_assoc_exc_syn
    setfield ^ \
        Gbar             0.0                \    // set by cellreader
        Ek               {FF_AMPA_EREV}     \
        tau1             0.0008             \
        tau2             0.020              \
        mod_index       -1                  \
        fac_depr_on      1                  \
        max_fac          1.0                \
        fac_per_spike    0.0                \
        fac_tau          0.0                \
        depr1_per_spike  0.0                \
        depr1_tau        0.0                \
        depr2_per_spike 10.0                \
        depr2_tau        0.005
*/

end


// ----------------------------------------------------------------------
//
// FF INHIBITORY TO FF INHIBITORY INTERNEURON SYNAPSE.
//
// ----------------------------------------------------------------------

// This channel is an invention of mine.
// It's basically the same as the ff inhibitory synchan onto
// pyramidal cells, but without depression.  I've also tweaked
// the slow GABA-A rise time.

function make_ff_ff_inh_syn
    if ({exists ff_ff_inh_syn})
        return
    end

    create triple_synchan ff_ff_inh_syn
    setfield ^ \
        Gbar             0.0                        \  // set by cellreader
        Ek               {FF_GABA_A_EREV}           \
        tau1             0.00124                    \
        tau2             {FP_FAST_GABA_A_TAU2}      \
        pGbar1           {FP_FF_PGBAR1}             \  // fast GABA-A
        pGbar2           {FP_FF_PGBAR2}             \  // slow GABA-A
        ch2_Ek           {FF_GABA_A_EREV}           \
        ch2_tau1         0.010                      \
        ch2_tau2         {FP_SLOW_GABA_A_TAU2}      \
        pGbar3           {FP_FF_PGBAR3}             \  // GABA-B
        ch3_Ek           {FF_GABA_B_EREV}           \
        ch3_tau1         {FP_GABA_B_TAU1}           \
        ch3_tau2         {FP_GABA_B_TAU2}
end
