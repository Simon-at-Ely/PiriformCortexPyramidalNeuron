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
// float EREST_ACT = -0.0743 // superficial pyramidal cell resting potential
float ENA       =  0.055
// float EK        = -0.075
// float ECA       =  0.080

// ===========================================================================
//                        Persistent Na Current
// ===========================================================================

/*
Based on experimental data from hippocampus:
      French, Sah, Buckett, and Gage J. Gen. Physiol. (1990)
      95: 1139-1157
Based on implementation for thalamo cortical cells:
      McCormick and Huguenard J. Neurophysiol. (1992)
      68(4):1384-1399

There is no evidence one way or another that this current exists or
does not exist in the superficial pyramidal cells of the piriform 
cortex.  I have made one change in the original McCormick equations: 
I have increased the potential required to activate the channel.
*/

function make_%Name%
	str chanpath = "/library/%Name%"
	if ({exists {chanpath}})
	    return
	end

    int   i
    float x, dx, y

    create tabchannel {chanpath}
    setfield {chanpath}  \
        ENA     {ENA}  \
	Gbar           	%Max Conductance Density%                  \ 
        Ik     0      \
        Gk     0      \
        Xpower 1      \
        Ypower 0      \
        Zpower 0

    float tab_divs = 3000
    
    float v_min = -0.1

    float v_max = 0.1

    float x, dx, i
            
        // Creating table for gate m, using name X for it here

    float dx = ({v_max} - {v_min})/{tab_divs}
            
    call {chanpath} TABCREATE X {tab_divs} {v_min} {v_max}
                
    x = {v_min}

//    call {chanpath} TABCREATE X 49 -0.1 0.1
//    x  = -0.1
//    dx = 0.2/49.0

    for (i = 0; i <= ({tab_divs}); i = i + 1)
        y = 1.0 / (91e3*(x + 0.048)/(1.0 - {exp {(-0.048 - x)/0.005}}) + \
            -62e3 * (x + 0.048)/(1.0 - {exp {(x + 0.048)/0.005}}))
        setfield {chanpath} X_A->table[{i}] {y}

        y = 1.0 / (1.0 + {exp {(-0.043 - x)/0.005}})
        setfield {chanpath} X_B->table[{i}] {y}

        x = x + dx
    end

    tweaktau {chanpath} X
    setfield {chanpath} X_A->calc_mode 0  \
        X_B->calc_mode 0
    call {chanpath} TABFILL X 3000 0
end
