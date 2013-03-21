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

function make_Na
    if ( {exists Na} )
        return
    end

    create tabchannel Na
    setfield ^               \
        Ek     {ENA}         \      // Volts
        Gbar   0             \      // Amperes
        Ik     0             \      // Siemens
        Gk     0             \  
        Xpower 2             \
        Ypower 1             \
        Zpower 0

    float THRESHOLD_OFFSET = 0.025

    setupalpha Na X  \
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

    setupalpha Na Y   \
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

function make_Na_pers
    if ({exists Na_pers})
        return
    end

    int   i
    float x, dx, y

    create tabchannel Na_pers
    setfield Na_pers  \
        Ek     {ENA}  \
        Ik     0      \
        Gk     0      \
        Xpower 1      \
        Ypower 0      \
        Zpower 0

    call Na_pers TABCREATE X 49 -0.1 0.1
    x  = -0.1
    dx = 0.2/49.0

    for (i = 0; i <= 49; i = i + 1)
        y = 1.0 / (91e3*(x + 0.048)/(1.0 - {exp {(-0.048 - x)/0.005}}) + \
            -62e3 * (x + 0.048)/(1.0 - {exp {(x + 0.048)/0.005}}))
        setfield Na_pers X_A->table[{i}] {y}

        y = 1.0 / (1.0 + {exp {(-0.043 - x)/0.005}})
        setfield Na_pers X_B->table[{i}] {y}

        x = x + dx
    end

    tweaktau Na_pers X
    setfield Na_pers X_A->calc_mode 0  \
        X_B->calc_mode 0
    call Na_pers TABFILL X 3000 0
end


//========================================================================
//                Tabchannel K(DR) Hippocampal cell channel
//========================================================================

function make_Kdr
    if (({exists Kdr}))
        return
    end

    create tabchannel Kdr
    setfield ^ \
        Ek      {EK}     \
        Gbar    0        \
        Ik      0        \
        Gk      0        \
        Xpower  1        \
        Ypower  0        \
        Zpower  0

    setupalpha Kdr X       \
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


//===========================================================================
//            Piriform A-Current
//===========================================================================

function make_Ka
    if ({exists Ka})
        return
    end

    create tabchannel Ka
    setfield ^ \
        Ek     {EK}      \
        Gbar   0         \
        Ik     0         \
        Gk     0         \
        Xpower 3         \
        Ypower 1         \
        Zpower 0

    setupalpha Ka X \
        500.0   \
        0.0     \
        0.0     \
        0.0393  \   
       -0.0308  \
        500.0   \
        0.0     \
        0.0     \
        0.0393  \
        0.0308  \
        -size 3000 -range -0.1 0.1

    setupalpha Ka Y \
        40.0    \
        0.0     \
        0.0     \
        0.0657  \
        0.00762 \
        40.0    \
        0.0     \
        0.0     \
        0.0657  \
       -0.0686  \
        -size 3000 -range -0.1 0.1
end


//===========================================================================
//                Non-inactivating Muscarinic K current
//===========================================================================

// ----------- KINETICS ADJUSTED FOR BODY TEMPERATURE -------------

function make_KM
    if ( {exists KM} )
        return
    end

    int i
    float x, dx, y

    create tabchannel KM
    setfield KM \
        Ek     -96.0e-03          \
        Gbar   0                  \
        Ik     0                  \
        Gk     0                  \
        Xpower 1                  \
        Ypower 0                  \
        Zpower 0

    float OFFSET = 0.0

    call KM TABCREATE X 49 -0.1 0.1
    x = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = 0.33 * \
            (0.033 + 1.0 / (11.3*({exp {(x + 0.035 + OFFSET)/0.02}}) + \
            {exp {-(x + 0.035 + OFFSET)/0.01}}))

        setfield KM X_A->table[{i}] {y}
        y = 1.0 / (1.0 + {exp {-(x + 0.035 + OFFSET)/0.01}})
        setfield KM X_B->table[{i}] {y}
        x = x + dx
    end

    tweaktau KM X
    setfield KM X_A->calc_mode 0 X_B->calc_mode 0
    call KM TABFILL X 3000 0
end


//========================================================================
//             Tabulated Ca-dependent K AHP Channel
//========================================================================

function make_Kahp
    if ( {exists Kahp} )
        return
    end

    create tabchannel Kahp
    setfield ^             \
        Ek     -96e-03     \
        Gbar   0           \
        Ik     0           \    
        Gk     0           \
        Xpower 0           \
        Ypower 0           \
        Zpower 1

    float xmin  = 0.0
    float xmax  = 5.2e-06
    int   xdivs = 50

    call Kahp TABCREATE Z {xdivs} {xmin} {xmax}

    int i
    float x, dx, y

    dx = (xmax - xmin) / xdivs
    x  = xmin

    for (i = 0; i <= xdivs; i = i + 1)
        if (x < 4.2e-06)
            y = 10.0 * x / 8.2e-06
        else
            y = 10.0
        end

        setfield Kahp Z_A->table[{i}] {y}
        setfield Kahp Z_B->table[{i}] {y + 0.5}
        x = x + dx
    end

    setfield Kahp Z_A->calc_mode 0 Z_B->calc_mode 0
    call Kahp TABFILL Z 3000 0

    if (!{exists Kahp addmsg1})
        addfield Kahp addmsg1
    end

    setfield  Kahp addmsg1 "../Ca_conc . CONCEN Ca"
end


//========================================================================
//             Tabulated Ca-dependent K AHP Channel #2
//========================================================================

// This channel is 10x faster than Kahp #1.

function make_Kahp2
    if ({exists Kahp2})
        return
    end

    create tabchannel Kahp2
    setfield ^             \
        Ek     -96e-03     \
        Gbar   0           \
        Ik     0           \    
        Gk     0           \
        Xpower 0           \
        Ypower 0           \
        Zpower 1

    float xmin  = 0.0
    float xmax  = 5.2e-06
    int   xdivs = 50

    call Kahp2 TABCREATE Z {xdivs} {xmin} {xmax}

    int i
    float x, dx, y

    dx = (xmax - xmin) / xdivs
    x  = xmin

    for (i = 0; i <= xdivs; i = i + 1)
        if (x < 4.2e-06)
            y = 10.0 * x / 8.2e-06
        else
            y = 10.0
        end

        setfield Kahp2 Z_A->table[{i}] {y}
        setfield Kahp2 Z_B->table[{i}] {y + 0.5}
        x = x + dx
    end

    setfield Kahp2 Z_A->calc_mode 0 Z_B->calc_mode 0
    call Kahp2 TABFILL Z 3000 0

    // Scale the time constants down by a factor of 10.

    scaletabchan Kahp2 Z tau 1.0 0.1 0.0 0.0 

    if (!{exists Kahp2 addmsg1})
        addfield Kahp2 addmsg1
    end

    setfield  Kahp2 addmsg1 "../Ca_conc . CONCEN Ca"
end


// ===========================================================================
//                      Olfactory Ca Current
// ===========================================================================

/*
Slow Ca current based on voltage clamp data from:
     Constanti, Galvan, Franz, and Sim Pfulgers Arch (1985)
     404:259-265
Assumptions about the existence of distinct slow current from:
     Halliwell and Scholfield Neurosci Letters (1984)
     50:13-18
Other papers about Ca currents in piriform pyramidal cells:
     Galvan, Constanti, and Franz Pfulgers Arch (1985)
     404:252-258
*/

/*----------- KINETICS ADJUSTED FOR BODY TEMPERATURE -------------*/

function make_Ca
    if ({exists Ca})
        return
    end

    float ECa = 0.113
    int i
    float x, dx, y

    create tabchannel Ca
    setfield Ca       \
        Ek     {ECa}             \
        Gbar   0                 \
        Ik     0                 \  
        Gk     0                 \
        Xpower 1                 \
        Ypower 1                 \
        Zpower 0

    call Ca TABCREATE X 49 -0.1 0.1
    x = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = 1.0e-03 / \
            ({exp {(x + .0032)/(-.0067)}} + {exp {(x + 0.0168)/0.0182}}) + 0.003
        setfield Ca X_A->table[{i}] {y}
        y = 1.0 / (1.0 + {exp {(x + 0.032)/(-0.010)}})
        setfield Ca X_B->table[{i}] {y}
        x = x + dx
    end

    call Ca TABCREATE Y 49 -0.1 0.1
    x  = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = (0.35 / ({exp {(x + 0.035)/0.012}} + {exp {(-0.025 - x)/0.012}})) + 0.01
        setfield Ca Y_A->table[{i}] {y}
        y = 1.0 / (1.0 + {exp {(x + 0.040)/(0.035)}})
        setfield Ca Y_B->table[{i}] {y}
        x = x + dx
    end

    tweaktau Ca X
    setfield Ca X_A->calc_mode 0 X_B->calc_mode 0
    call Ca TABFILL X 3000 0

    tweaktau Ca Y
    setfield Ca Y_A->calc_mode 0 Y_B->calc_mode 0
    call Ca TABFILL Y 3000 0

    addfield Ca addmsg1
    setfield Ca addmsg1 "../Ca_conc . CONCEN Ca"
end


// ===========================================================================
//                      Calcium buffer
// ===========================================================================

function make_Ca_conc
    if ( {exists Ca_conc})
        return
    end

    create Ca_concen Ca_conc

    setfield Ca_conc            \
        tau     0.025           \  // sec
        B       7.4e+6          \  // (asymptotic) conc/current
        Ca_base 50e-09             // M

    addfield Ca_conc addmsg1
    setfield Ca_conc addmsg1 "../Ca . I_Ca Ik"
end



// ===========================================================================
//                    Channel library:
// ===========================================================================

function make_channel_library
    if ({exists /library})
        str chan
        foreach chan ( {arglist {chan_list}} )
            call /library/{chan} TABDELETE  // Free up memory in tabchannel tables.
        end

        delete /library
        reclaim
    end

    create  neutral  /library
    disable /library
    ce /library

    create compartment compartment

    make_Na
    make_Na_pers
    make_Kdr
    make_Ka
    make_KM
    make_Kahp
    make_Kahp2
    make_Ca
    make_Ca_conc

    ce /
end




