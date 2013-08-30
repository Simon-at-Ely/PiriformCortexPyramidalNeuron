// genesis

//
// fb_chans.g: Define the channel library for the
//     feedback inhibitory cell simulation.
//

include fb_reversal_potentials.g
include fb_synchans.g
include fb_vdepchans.g


function make_fb_inhib_channel_library
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

    create mod_compartment fb_compartment
    setfield ^ mod_index 9 mod_initVm_flag 1

    make_fb_Na
    make_fb_Kdr
    make_fb_Ka

    // Define the synapse types.

    make_fb_assoc_exc_syn
    make_fb_fb_inh_syn

    // Spike generator.

    create mod_spikegen fb_spikegen
    setfield ^ abs_refract 0.002 thresh 0.0

    ce /
end

