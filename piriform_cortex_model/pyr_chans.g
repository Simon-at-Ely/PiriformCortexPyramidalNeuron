// genesis

//
// pyr_chans.g: Define the channel library for the
//     layer 2 pyramidal cell simulation.
//

include pyr_reversal_potentials.g
include pyr_synchans.g
include pyr_vdepchans.g


// List of channels.

str pyr_chan_list = \
    "pyr_Na pyr_Na_pers pyr_Kdr pyr_Ka pyr_KM pyr_Kahp pyr_Ca"


function make_pyramidal_channel_library
    //
    // If the library doesn't exist, create it;
    // otherwise just add our channels to it.
    //

    str chan

    if (!{exists /library})
        create neutral /library
        disable /library
    end

    ce /library

    create mod_compartment pyr_compartment
    setfield ^ mod_index 4 mod_initVm_flag 1

    // Voltage-dependent channels.

    make_pyr_Na
    make_pyr_Na_pers
    make_pyr_Kdr
    make_pyr_Ka
    make_pyr_KM
    make_pyr_Kahp
    make_pyr_Ca
    make_pyr_Ca2
    make_pyr_Ca_conc

    // Synaptic channels.

    // 1) Excitatory:
    make_pyr_aff_exc_syn       // LOT -> pyr, layer 1a
    make_pyr_assoc_exc_syn     // pyr -> pyr, layer 1b
    make_pyr_local_exc_syn     // pyr -> pyr, layer 3
    make_pyr_ext_exc_syn       // external background input (not from bulb)

    // 2) Inhibitory:
    make_pyr_layer1_inh_syn_0   // deepIb_1, deepIb_2
    make_pyr_layer1_inh_syn_1   // deepIb_3, supIb_1
    make_pyr_layer1_inh_syn_2   // supIb_2, supIb_3
    make_pyr_layer1_inh_syn_3   // Ia
    make_pyr_layer2_3_inh_syn   // soma, basal dendrites
    // Extra channels for ff inhibitory synapses:
    make_pyr_layer1_inh_syn_0b
    make_pyr_layer1_inh_syn_1b
    make_pyr_layer1_inh_syn_2b
    make_pyr_layer1_inh_syn_3b

    // Spike generator.

    create mod_spikegen pyr_spikegen
    setfield ^ abs_refract 0.002 thresh 0.0

    ce /
end

