// genesis

//
// ff_chans.g: Define the channel library for the
//     feedforward inhibitory cell simulation.
//

include ff_reversal_potentials
include ff_synchans
include ff_vdepchans


function make_ff_inhib_channel_library
    //
    // If the library doesn't exist, create it;
    // otherwise just add our channels to it.
    //

    if (!{exists /library})
        create neutral /library
        disable /library
    end

    ce /library

    // The compartment's resting potential can be
    // changed by neuromodulation.

    create mod_compartment ff_compartment

    make_ff_Na
    make_ff_Kdr
    make_ff_Ka
    make_ff_Ka_2

    // Synaptic channel objects.

    make_ff_aff_exc_syn
    make_ff_assoc_exc_syn
    make_ff_ff_inh_syn

    // Spike generators.
    // We set up duplicate objects for ff and ff_fb cells because
    // they have to have different names for the purpose of the
    // weight setting code.

    create mod_spikegen ff_spikegen
    setfield ^ abs_refract 0.002 thresh 0.0

    create mod_spikegen ff_fb_spikegen
    setfield ^ abs_refract 0.002 thresh 0.0

    ce /
end

