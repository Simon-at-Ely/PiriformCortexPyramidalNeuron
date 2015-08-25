// genesis

//
// ff_chans.g: Define the channel library for the
//     feedforward inhibitory cell simulation.
//

include compartments

include ff_reversal_potentials.g
include ff_vdepchans.g


function make_ff_inhib_channel_library
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
    

    make_ff_Na
    make_ff_Kdr
    make_ff_Ka
    make_ff_Ka_2

    pope /
end

