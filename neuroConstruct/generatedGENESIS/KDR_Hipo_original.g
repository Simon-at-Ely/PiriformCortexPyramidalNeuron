

// **************************************************
// File generated by: neuroConstruct v1.7.0 
// **************************************************

// This file holds the implementation in GENESIS of the Cell Mechanism:
// KDR_Hipo_original (Type: Channel mechanism, Model: File Based Membrane Mechanism)

// with parameters: 
// Max Conductance Density = 1.0E-6 mS um^-2 



// M. C. Vanier and J. M. Bower
// A Comparative Survey of Automated Parameter-Searching Methods
// for Compartmental Neural Models

// Description of the simplified layer 2 pyramidal cell model
// (model 5).  Active conductances and reversal potentials.
// Channel descriptions are in the GENESIS neural modeling language;
// for more information see "The Book of GENESIS, 2nd. Ed." by J. M. 
// Bower and David Beeman, Springer/Telos.  All voltage- or calcium-
// dependent ionic channels are very standard Hodgkin-Huxley-type
// channels.

// genesis

// CONSTANTS:

// channel equilibrium potentials (V)
float EREST_ACT = -0.0743 // superficial pyramidal cell resting potential
float ENA       =  0.055
float EK        = -0.075
float ECA       =  0.080

//========================================================================
//                Tabchannel K(DR) Hippocampal cell channel
//========================================================================

function make_KDR_Hipo_original
	str chanpath = "/library/KDR_Hipo_original"
	if ({exists {chanpath}})
	    return
	end

    create tabchannel {chanpath}
    setfield {chanpath} \
        Ek      {EK}     \
        Gbar    1000.0        \
        Ik      0        \
        Gk      0        \
        Xpower  1        \
        Ypower  0        \
        Zpower  0

    setupalpha {chanpath} X       \
        {16.0e3*(0.0351 + EREST_ACT)}  \
        -16.0e3                        \
        -1.0                           \
        {-1.0 * (0.0351 + EREST_ACT)}  \
        -0.005                         \
        250.0                          \
        0.0                            \
        0.0                            \
        {-1.0*(0.02 + EREST_ACT)}      \
        0.04                           \
        -size 3000 -range -0.1 0.1
end

