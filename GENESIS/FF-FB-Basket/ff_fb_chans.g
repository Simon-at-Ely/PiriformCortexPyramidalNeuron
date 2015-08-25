// genesis

//
// ff_fb_chans.g: Define the channel library for the
//     feedforward inhibitory cell simulation.
//

include compartments

include ff_fb_reversal_potentials.g
include ff_fb_vdepchans.g


function make_ff_fb_inhib_channel_library
    //
    // If the library doesn't exist, create it;
    // otherwise just add our channels to it.
    //



    if (!{exists /library})
        create neutral /library
        disable /library
    end

    pushe /library

    make_cylind_compartment 
    

    make_ff_fb_Na
    make_ff_fb_Kdr
    make_ff_fb_Ka


    pope /
end

