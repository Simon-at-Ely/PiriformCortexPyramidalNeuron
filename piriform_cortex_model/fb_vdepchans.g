// genesis

//
// fb_vdepchans.g: Voltage-dependent channels for the
//     feedback inhibitory cell simulation.
//


// ========================================================================
// Feedback inhibitory neuron fast Na channel.
// Derived from: Na hippocampal cell channel.
// ========================================================================

function make_fb_Na
    if ({exists fb_Na})
        return
    end

    create mod_tabchannel fb_Na
    setfield fb_Na           \
        Ek         {FB_ENA}  \
        Gbar       0         \
        Ik         0         \
        Gk         0         \
        Xpower     2         \
        Ypower     1         \
        Zpower     0         \
        mod_index -1

    mod_setupalpha fb_Na X   \
        {320.0e3 * (0.0131 + {FB_EREST_ACT})}   \
        -320.0e3                                \
        -1.0                                    \
        {-1.0 * (0.0131 + {FB_EREST_ACT})}      \
        -0.004                                  \
        {-280.0e3 * (0.0401 + {FB_EREST_ACT})}  \
        280.0e3                                 \
        -1.0                                    \
        {-1.0 * (0.0401 + {FB_EREST_ACT})}      \
        5.0e-3


    mod_setupalpha fb_Na Y  \
        128.0                                   \
        0.0                                     \
        0.0                                     \
        {-1.0 * (0.017 + {FB_EREST_ACT})}       \
        0.018                                   \
        4.0e3                                   \
        0.0                                     \
        1.0                                     \
        {-1.0 * (0.040 + {FB_EREST_ACT})}       \
        -5.0e-3

    setfield fb_Na X_A->calc_mode 1  X_B->calc_mode 1
    setfield fb_Na Y_A->calc_mode 1  Y_B->calc_mode 1

    // Kinetics adjustment:
    mod_scaletabchan fb_Na X minf 1.0 1.0 -0.003 0.0
end



// ========================================================================
// Feedback inhibitory neuron delayed-rectifier K channel.
// Derived from: K(DR) hippocampal cell channel.
// ========================================================================

function make_fb_Kdr
    if ({exists fb_Kdr})
        return
    end

    create mod_tabchannel fb_Kdr
    setfield fb_Kdr         \
        Ek         {FB_EK}  \
        Gbar       0        \
        Ik         0        \
        Gk         0        \
        Xpower     1        \
        Ypower     0        \
        Zpower     0        \
        mod_index -1

    mod_setupalpha fb_Kdr X  \
        {16.0e3 * (0.0351 + {FB_EREST_ACT})}    \
        -16.0e3                                 \
        -1.0                                    \
        {-1.0 * (0.0351 + {FB_EREST_ACT})}      \
        -0.005                                  \
        250.0                                   \
        0.0                                     \
        0.0                                     \
        {-1.0 * (0.02 + {FB_EREST_ACT})}        \
        0.04

    setfield fb_Kdr X_A->calc_mode 1  X_B->calc_mode 1

    // Kinetics adjustments:
    mod_scaletabchan fb_Kdr X minf 1.0 1.0 0.0 0.0
    mod_scaletabchan fb_Kdr X tau  1.0 0.27 0.0 0.0
end


// ========================================================================
// Feedback inhibitory neuron A current.
// Derived from: Inspired conjecture.
// ========================================================================

function make_fb_Ka
    if ({exists fb_Ka})
        return
    end

    int i
    float x, y

    create mod_tabchannel fb_Ka
    setfield fb_Ka           \
        Ek         {FB_EK}   \
        Gbar       0         \
        Ik         0         \
        Gk         0         \
        Xpower     1         \
        Ypower     1         \
        Zpower     0         \
        mod_index -1


    // Define the activation gate kinetics.

    call fb_Ka TABCREATE X 49 -0.1 0.05

    float x  = -0.1
    float dx =  0.15 / 49.0

    for (i = 0; i < 50; i = i + 1)
        y = 0.0005  // The activation time constant is constant :-)
        setfield fb_Ka X_A->table[{i}] {y}

        // Sigmoid function: sigmoid(x, mid, deltay, deltax, low, high)

        y = {sigmoid {x} -0.060 1.0 0.010 0.0 1.0}
        setfield fb_Ka X_B->table[{i}] {y}
        x = x + dx
    end

    mod_tweaktau fb_Ka X
    setfield fb_Ka X_A->calc_mode 1 X_B->calc_mode 1
    call fb_Ka TABFILL X 3000 0


    // Define the inactivation gate kinetics.

    call fb_Ka TABCREATE Y 49 -0.1 0.05

    float x  = -0.1
    float dx =  0.15 / 49.0

    for (i = 0; i < 50; i = i + 1)
        y = {sigmoid {x} -0.060 0.048 0.010 0.0001 0.050}
        setfield fb_Ka Y_A->table[{i}] {y}

        // Use a negative sigmoid for inactivation.

        y = {negative_sigmoid {x} -0.060 1.0 0.010 1.0 0.0}
        setfield fb_Ka Y_B->table[{i}] {y}
        x = x + dx
    end

    mod_tweaktau fb_Ka Y
    setfield fb_Ka Y_A->calc_mode 1 Y_B->calc_mode 1
    call fb_Ka TABFILL Y 3000 0
end



// ========================================================================
//                      Channel library:
// ========================================================================

function delete_fb_channel_library
    str chan

    foreach chan (fb_Na fb_Kdr fb_Ka)
        call /library/{chan} TABDELETE
    end

    delete /library
    reclaim
end

