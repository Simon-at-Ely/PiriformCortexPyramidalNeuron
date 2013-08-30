// genesis

//
// pyr_vdepchans.g: Voltage-dependent channels for the
//     layer 2 pyramidal cell simulation.
//

//
// BOGOSITY ALERT:
//
// Not all these potassium channels have the same reversal potentials.
// This is a minor buglet.  However, I don't have the time to re-run
// all the parameter searches with all the potassium Ek's set to the same
// value.
//

//
// NOTE: although the calc_mode for the various gates aren't set here,
// they are equal to 1.0 by default.  They should be set explicitly,
// though.  FIXME.
//


int pyr_std_xdivs = 4000

// ========================================================================
//                Tabchannel Na Hippocampal cell channel
// ========================================================================

function make_pyr_Na
    if ({exists pyr_Na})
        return
    end

    create mod_tabchannel pyr_Na
    setfield pyr_Na          \
        Ek        {PYR_ENA}  \
        Gbar      0          \
        Ik        0          \
        Gk        0          \
        Xpower    2          \
        Ypower    1          \
        Zpower    0          \
        mod_index 0

    float THRESHOLD_OFFSET = 0.025

    mod_setupalpha pyr_Na X  \
            {320.0e3 * (0.0131 + PYR_EREST_ACT + THRESHOLD_OFFSET)}    \
            -320.0e3                                                   \
            -1.0                                                       \
            {-1.0 * (0.0131 + PYR_EREST_ACT + THRESHOLD_OFFSET)}       \
            -0.004                                                     \
            {-280.0e3 * (0.0401 + PYR_EREST_ACT + THRESHOLD_OFFSET)}   \
            280.0e3                                                    \
            -1.0                                                       \
            {-1.0 * (0.0401 + PYR_EREST_ACT + THRESHOLD_OFFSET)}       \
            5.0e-3                                                     \
            -size {pyr_std_xdivs} -range -0.1 0.1

    THRESHOLD_OFFSET = 0.025

    mod_setupalpha pyr_Na Y  \
            128.0                                                      \
            0.0                                                        \
            0.0                                                        \
            {-1.0 * (0.017 + PYR_EREST_ACT + THRESHOLD_OFFSET)}        \
            0.018                                                      \
            4.0e3                                                      \
            0.0                                                        \
            1.0                                                        \
            {-1.0 * (0.040 + PYR_EREST_ACT + THRESHOLD_OFFSET)}        \
            -5.0e-3                                                    \
            -size {pyr_std_xdivs} -range -0.1 0.1

    call pyr_Na INITREFCOUNT
end



// ========================================================================
//                        Persistent Na Current
// ========================================================================

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

function make_pyr_Na_pers
    if ({exists pyr_Na_pers})
        return
    end

    int   i
    float x, dx, y

    create mod_tabchannel pyr_Na_pers
    setfield pyr_Na_pers     \
        Ek        {PYR_ENA}  \
        Ik        0          \
        Gk        0          \
        Xpower    1          \
        Ypower    0          \
        Zpower    0          \
        mod_index 0

    call pyr_Na_pers TABCREATE X 49 -0.1 0.1
    x  = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = 1.0 / (91e3 * (x + 0.048) / \
          (1.0 - {exp {(-0.048 - x) /    0.005}}) \
          + -62e3 * (x + 0.048) / (1.0 - {exp {(x + 0.048) / 0.005}}))
        setfield pyr_Na_pers X_A->table[{i}] {y}

        y = 1.0 / (1.0 + {exp {(-0.043 - x) / 0.005}})
        setfield pyr_Na_pers X_B->table[{i}] {y}

        x = x + dx
    end

    mod_tweaktau pyr_Na_pers X
    call pyr_Na_pers TABFILL X {pyr_std_xdivs} 0

    // Parameter search adjustments:

    mod_scaletabchan pyr_Na_pers X tau 1 0.227573 0 0

    call pyr_Na_pers INITREFCOUNT
end



// ========================================================================
//                Tabchannel K(DR) Hippocampal cell channel
// ========================================================================

function make_pyr_Kdr
    if (({exists pyr_Kdr}))
        return
    end

    create mod_tabchannel pyr_Kdr
    setfield pyr_Kdr          \
        Ek          {PYR_EK}  \
        Gbar        0         \
        Ik          0         \
        Gk          0         \
        Xpower      1         \
        Ypower      0         \
        Zpower      0         \
        mod_index   5

    mod_setupalpha pyr_Kdr X  \
        {16.0e3 * (0.0351 + PYR_EREST_ACT)}  \
        -16.0e3                              \
        -1.0                                 \
        {-1.0 * (0.0351 + PYR_EREST_ACT)}    \
        -0.005                               \
        250.0                                \
        0.0                                  \
        0.0                                  \
        {-1.0 * (0.02 + PYR_EREST_ACT)}      \
        0.04                                 \
        -size {pyr_std_xdivs} -range -0.1 0.1

    call pyr_Kdr INITREFCOUNT
end



// ========================================================================
//            Piriform A-Current
// ========================================================================

function make_pyr_Ka
    if ({exists pyr_Ka})
        return
    end

    create mod_tabchannel pyr_Ka
    setfield ^  \
        Ek          {PYR_EK}  \
        Gbar        0         \
        Ik          0         \
        Gk          0         \
        Xpower      3         \
        Ypower      1         \
        Zpower      0         \
        mod_index   6

    mod_setupalpha pyr_Ka X  \
        500.0            \
        0.0              \
        0.0              \
        0.0393           \
       -0.0308           \
        500.0            \
        0.0              \
        0.0              \
        0.0393           \
        0.0308           \
       -size {pyr_std_xdivs} -range -0.1 0.1

    mod_setupalpha pyr_Ka Y  \
        40.0             \
        0.0              \
        0.0              \
        0.0657           \
        0.00762          \
        40.0             \
        0.0              \
        0.0              \
        0.0657           \
       -0.0686           \
       -size {pyr_std_xdivs} -range -0.1 0.1

    // Shift the inactivation curve to the left.

    mod_scaletabchan pyr_Ka Y minf 1.0 1.0 -0.010 0.0

    // Slow down the inactivation kinetics.

    mod_scaletabchan pyr_Ka Y tau 1.0 10.0 0.0 0.0

    // Parameter search adjustments:

    mod_scaletabchan pyr_Ka X tau 1.0  1.39532   0.0  0.0
    mod_scaletabchan pyr_Ka Y tau 1.0  0.538194  0.0  0.0

    call pyr_Ka INITREFCOUNT
end



// ========================================================================
//                Non-inactivating Muscarinic K current
// ========================================================================

// ----------- KINETICS ADJUSTED FOR BODY TEMPERATURE -------------

function make_pyr_KM
    if ({exists pyr_KM})
        return
    end

    int i
    float x, dx, y

    create mod_tabchannel pyr_KM
    setfield pyr_KM  \
        Ek         -96.0e-03   \
        Gbar        0          \
        Ik          0          \
        Gk          0          \
        Xpower      1          \
        Ypower      0          \
        Zpower      0          \
        mod_index   7

    float OFFSET = 0.0

    call pyr_KM TABCREATE X 49 -0.1 0.1
    x = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = 0.33 * (0.033 + 1.0 / \
            (11.3 * ({exp {(x + 0.035 + OFFSET) / 0.02}}) + \
            {exp {-(x + 0.035 + OFFSET) / 0.01}}))

        setfield pyr_KM X_A->table[{i}] {y}
        y = 1.0 / (1.0 + {exp {-(x + 0.035 + OFFSET) / 0.01}})
        setfield pyr_KM X_B->table[{i}] {y}
        x = x + dx
    end

    mod_tweaktau pyr_KM X
    call pyr_KM TABFILL X {pyr_std_xdivs} 0

    // Parameter search adjustments:

    mod_scaletabchan pyr_KM  X  minf  1.0  1.0      -0.000561139  0.0
    mod_scaletabchan pyr_KM  X  tau   1.0  0.601309  0.0          0.0

    call pyr_KM INITREFCOUNT
end



// ========================================================================
//             Tabulated Ca-dependent K AHP Channel
// ========================================================================

function make_pyr_Kahp
    if ({exists pyr_Kahp})
        return
    end

    create mod_tabchannel pyr_Kahp
    setfield ^  \
        Ek         -96e-03   \
        Gbar        0        \
        Ik          0        \
        Gk          0        \
        Xpower      0        \
        Ypower      0        \
        Zpower      1        \
        mod_index   8

    float xmin  = 0.0
    float xmax  = 5.0e-06
    int   xdivs = 50

    call pyr_Kahp TABCREATE Z {xdivs} {xmin} {xmax}

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

        setfield pyr_Kahp Z_A->table[{i}] {y}
        setfield pyr_Kahp Z_B->table[{i}] {y + 0.5}
        x = x + dx
    end

    call pyr_Kahp TABFILL Z {pyr_std_xdivs} 0

    if (!{exists pyr_Kahp addmsg1})
        addfield pyr_Kahp addmsg1
    end

    setfield  pyr_Kahp addmsg1 "../pyr_Ca_conc . CONCEN Ca"

    // Parameter search adjustments:

    mod_scaletabchan pyr_Kahp Z tau  1.0  0.332033  0.0 0.0

    call pyr_Kahp INITREFCOUNT
end



// ========================================================================
//                      Olfactory Ca Current
// ========================================================================

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

// ----------- KINETICS ADJUSTED FOR BODY TEMPERATURE -------------

function make_pyr_Ca
    if ({exists pyr_Ca})
        return
    end

    int i
    float x, dx, y

    create mod_tabchannel pyr_Ca
    setfield pyr_Ca          \
        Ek        {PYR_ECA}  \
        Gbar      0          \
        Ik        0          \
        Gk        0          \
        Xpower    1          \
        Ypower    1          \
        Zpower    0          \
        mod_index 0

    call pyr_Ca TABCREATE X 49 -0.1 0.1
    x = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = (1.0e-03 / ({exp {(x + .0032) / (-.0067)}} +  \
            {exp {(x + 0.0168) / 0.0182}}) + 0.003)  // /3.0
        setfield pyr_Ca X_A->table[{i}] {y}
        y = 1.0 / (1.0 + {exp {(x + 0.032) / (-0.010)}})
        setfield pyr_Ca X_B->table[{i}] {y}
        x = x + dx
    end

    call pyr_Ca TABCREATE Y 49 -0.1 0.1
    x  = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = (0.35 / ({exp {(x + 0.035) / 0.012}} +  \
            {exp {(-0.025 - x) / 0.012}})) + 0.01  // /3.0
        setfield pyr_Ca Y_A->table[{i}] {y}
        y = 1.0 / (1.0 + {exp {(x + 0.040) / 0.035}})
        setfield pyr_Ca Y_B->table[{i}] {y}
        x = x + dx
    end

    mod_tweaktau pyr_Ca X
    call pyr_Ca TABFILL X {pyr_std_xdivs} 0

    mod_tweaktau pyr_Ca Y
    call pyr_Ca TABFILL Y {pyr_std_xdivs} 0

    addfield pyr_Ca addmsg1
    setfield pyr_Ca addmsg1 "../pyr_Ca_conc . CONCEN Ca"

    // Parameter search adjustments:

    mod_scaletabchan pyr_Ca X tau  1.0  0.705070  0.0  0.0
    mod_scaletabchan pyr_Ca Y tau  1.0  1.84388  0.0  0.0

    call pyr_Ca INITREFCOUNT
end


//
// "Naked" calcium channel i.e. one that isn't connected to
// a Ca_conc element.
//

function make_pyr_Ca2
    if ({exists pyr_Ca2})
        return
    end

    int i
    float x, dx, y

    create mod_tabchannel pyr_Ca2
    setfield pyr_Ca2         \
        Ek        {PYR_ECA}  \
        Gbar      0          \
        Ik        0          \
        Gk        0          \
        Xpower    1          \
        Ypower    1          \
        Zpower    0          \
        mod_index 0

    call pyr_Ca2 TABCREATE X 49 -0.1 0.1
    x = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = (1.0e-03 / ({exp {(x + .0032) / (-.0067)}} +  \
            {exp {(x + 0.0168) / 0.0182}}) + 0.003)  // /3.0
        setfield pyr_Ca2 X_A->table[{i}] {y}
        y = 1.0 / (1.0 + {exp {(x + 0.032) / (-0.010)}})
        setfield pyr_Ca2 X_B->table[{i}] {y}
        x = x + dx
    end

    call pyr_Ca2 TABCREATE Y 49 -0.1 0.1
    x  = -0.1
    dx = 0.2 / 49.0

    for (i = 0; i <= 49; i = i + 1)
        y = (0.35 / ({exp {(x + 0.035) / 0.012}} +  \
            {exp {(-0.025 - x) / 0.012}})) + 0.01  // /3.0
        setfield pyr_Ca2 Y_A->table[{i}] {y}
        y = 1.0 / (1.0 + {exp {(x + 0.040) / 0.035}})
        setfield pyr_Ca2 Y_B->table[{i}] {y}
        x = x + dx
    end

    mod_tweaktau pyr_Ca2 X
    call pyr_Ca2 TABFILL X {pyr_std_xdivs} 0

    mod_tweaktau pyr_Ca2 Y
    call pyr_Ca2 TABFILL Y {pyr_std_xdivs} 0

    // Parameter search adjustments:

    mod_scaletabchan pyr_Ca2 X tau  1.0  0.705070  0.0  0.0
    mod_scaletabchan pyr_Ca2 Y tau  1.0  1.84388  0.0  0.0

    call pyr_Ca2 INITREFCOUNT
end



// ========================================================================
//                      Calcium buffer
// ========================================================================

function make_pyr_Ca_conc
    if ({exists pyr_Ca_conc})
        return
    end

    create Ca_concen pyr_Ca_conc

    setfield pyr_Ca_conc \
        tau     0.0960198      \  // sec (adjusted by parameter search)
        B       7.4e+6         \  // (asymptotic) conc/current
        Ca_base 0.0               // M; was 50e-09


    addfield pyr_Ca_conc addmsg1
    setfield pyr_Ca_conc addmsg1 "../pyr_Ca . I_Ca Ik"
end

