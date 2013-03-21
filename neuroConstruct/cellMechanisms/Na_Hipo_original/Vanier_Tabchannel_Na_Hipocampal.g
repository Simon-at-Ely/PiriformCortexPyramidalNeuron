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
//                Tabchannel Na Hippocampal cell channel
//========================================================================

function make_%Name%
	str chanpath = "/library/%Name%"
	if ( {exists {chanpath}} )
        return
    end

    create tabchannel {chanpath}
    setfield {chanpath}               \
        Ek     {ENA}         \      // Volts
        Gbar   %Max Conductance Density%             \      // Siemens
        Ik     0             \     
        Gk     0             \  
        Xpower 2             \
        Ypower 1             \
        Zpower 0

    float THRESHOLD_OFFSET = 0.025

    setupalpha {chanpath} X  \
        {320.0e3 * (0.0131 + EREST_ACT + THRESHOLD_OFFSET)} \
        -320.0e3                                            \
        -1.0                                                \
        {-1.0*(0.0131 + EREST_ACT + THRESHOLD_OFFSET)}      \
        -0.004                                              \
        {-280.0e3*(0.0401 + EREST_ACT + THRESHOLD_OFFSET)}  \
        280.0e3                                             \
        -1.0                                                \
        {-1.0*(0.0401 + EREST_ACT + THRESHOLD_OFFSET)}      \
        5.0e-3                                              \
        -size 3000 -range -0.1 0.1

    THRESHOLD_OFFSET = 0.025 

    setupalpha {chanpath} Y   \
        128.0                                               \
        0.0                                                 \
        0.0                                                 \
        {-1.0*(0.017 + EREST_ACT + THRESHOLD_OFFSET)}       \
        0.018                                               \
        4.0e3                                               \
        0.0                                                 \
        1.0                                                 \
        {-1.0*(0.040 + EREST_ACT + THRESHOLD_OFFSET)}       \
        -5.0e-3                                             \
        -size 3000 -range -0.1 0.1
end
