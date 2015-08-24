// genesis

//
// pyr_chans.g: Define the channel library for the
//     layer 2 pyramidal cell simulation.
//

include compartments

include pyr_reversal_potentials.g
include pyr_vdepchans.g




function make_pyramidal_channel_library
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


    // Voltage-dependent channels.

    make_Na
    make_Na_pers
    make_Kdr
    make_Ka
    make_KM
    make_Ca
    make_Kahp2
    make_Ca_conc



    pope /
end

