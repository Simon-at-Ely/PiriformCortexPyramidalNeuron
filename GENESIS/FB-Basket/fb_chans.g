// genesis

//
// fb_chans.g: Define the channel library for the
//     feedback inhibitory cell simulation.
//

include compartments

include fb_reversal_potentials.g
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

    pushe /library

    make_cylind_compartment 


    make_fb_Na
    make_fb_Kdr
    make_fb_Ka

    
    pope /
end

