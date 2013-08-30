// genesis

//
// ff_vdepchans.g: Voltage-dependent channels for the
//     feedforward inhibitory cell simulation.
//


// ========================================================================
// Feedforward inhibitory neuron fast Na channel.
// Derived from: Na hippocampal cell channel.
// ========================================================================

function make_ff_Na
    if ({exists ff_Na})
        return
    end

    create tabchannel ff_Na
    setfield ^  \
        Ek      {FF_ENA}  \
        Gbar    0         \
        Ik      0         \
        Gk      0         \
        Xpower  2         \
        Ypower  1         \
        Zpower  0

    setupalpha ff_Na X   \
        {320.0e3 * (0.0131 + {FF_EREST_ACT})}   \
        -320.0e3                                \
        -1.0                                    \
        {-1.0 * (0.0131 + {FF_EREST_ACT})}      \
        -0.004                                  \
        {-280.0e3 * (0.0401 + {FF_EREST_ACT})}  \
        280.0e3                                 \
        -1.0                                    \
        {-1.0 * (0.0401 + {FF_EREST_ACT})}      \
        5.0e-3


    setupalpha ff_Na Y  \
        128.0                                   \
        0.0                                     \
        0.0                                     \
        {-1.0 * (0.017 + {FF_EREST_ACT})}       \
        0.018                                   \
        4.0e3                                   \
        0.0                                     \
        1.0                                     \
        {-1.0 * (0.040 + {FF_EREST_ACT})}       \
        -5.0e-3

    setfield ff_Na X_A->calc_mode 1 X_B->calc_mode 1
    setfield ff_Na Y_A->calc_mode 1 Y_B->calc_mode 1

    // Kinetics adjustment:
    scaletabchan ff_Na X minf 1.0 1.0 -0.003 0.0
end



// ========================================================================
// Feedforward inhibitory neuron delayed-rectifier K channel.
// Derived from: K(DR) hippocampal cell channel.
// ========================================================================

function make_ff_Kdr
    if ({exists ff_Kdr})
        return
    end

    create tabchannel ff_Kdr
    setfield ^  \
        Ek     {FF_EK}  \
        Gbar   0        \
        Ik     0        \
        Gk     0        \
        Xpower 1        \
        Ypower 0        \
        Zpower 0

    setupalpha ff_Kdr X  \
        {16.0e3 * (0.0351 + {FF_EREST_ACT})}    \
        -16.0e3                                 \
        -1.0                                    \
        {-1.0 * (0.0351 + {FF_EREST_ACT})}      \
        -0.005                                  \
        250.0                                   \
        0.0                                     \
        0.0                                     \
        {-1.0 * (0.02 + {FF_EREST_ACT})}        \
        0.04

    setfield ff_Kdr X_A->calc_mode 1 X_B->calc_mode 1

    // Kinetics adjustments:
    scaletabchan ff_Kdr X minf 1.0 1.0 0.0 0.0
    scaletabchan ff_Kdr X tau  1.0 0.27 0.0 0.0
end


// ========================================================================
// Feedforward inhibitory neuron A current.
// Derived from: Inspired conjecture.
// ========================================================================

function make_ff_Ka
    if ({exists ff_Ka})
        return
    end

    int i
    float x, y

    create tabchannel ff_Ka
    setfield ^           \
        Ek     {FF_EK}   \
        Gbar   0         \
        Ik     0         \
        Gk     0         \
        Xpower 1         \
        Ypower 1         \
        Zpower 0


    // Define the activation gate kinetics.

    call ff_Ka TABCREATE X 49 -0.1 0.05

    float x  = -0.1
    float dx =  0.15 / 49.0

    for (i = 0; i < 50; i = i + 1)
        y = 0.0005  // The activation time constant is constant :-)
        setfield ff_Ka X_A->table[{i}] {y}

        // Sigmoid function: sigmoid(x, mid, deltay, deltax, low, high)

        y = {sigmoid {x} -0.060 1.0 0.010 0.0 1.0}
        setfield ff_Ka X_B->table[{i}] {y}
        x = x + dx
    end

    tweaktau ff_Ka X
    setfield ff_Ka X_A->calc_mode 1 X_B->calc_mode 1
    call ff_Ka TABFILL X 3000 0


    // Define the inactivation gate kinetics.

    call ff_Ka TABCREATE Y 49 -0.1 0.05

    float x  = -0.1
    float dx =  0.15 / 49.0

    for (i = 0; i < 50; i = i + 1)
        y = {sigmoid {x} -0.060 0.048 0.010 0.0001 0.050}
        setfield ff_Ka Y_A->table[{i}] {y}

        // Use a negative sigmoid for inactivation.

        y = {negative_sigmoid {x} -0.060 1.0 0.010 1.0 0.0}
        setfield ff_Ka Y_B->table[{i}] {y}
        x = x + dx
    end

    tweaktau ff_Ka Y
    setfield ff_Ka Y_A->calc_mode 1 Y_B->calc_mode 1
    call ff_Ka TABFILL Y 3000 0
end



// ========================================================================
// Feedforward inhibitory neuron A current #2
// Derived from: Inspired conjecture.
// ========================================================================

function make_ff_Ka_2
    if ({exists ff_Ka_2})
        return
    end

    int i
    float x, y

    create tabchannel ff_Ka_2
    setfield ^           \
        Ek     {FF_EK}   \
        Gbar   0         \
        Ik     0         \
        Gk     0         \
        Xpower 1         \
        Ypower 1         \
        Zpower 0


    // Define the activation gate kinetics.

    call ff_Ka_2 TABCREATE X 49 -0.1 0.05

    float x  = -0.1
    float dx =  0.15 / 49.0

    for (i = 0; i < 50; i = i + 1)
        y = 0.0005  // The activation time constant is constant :-)
        setfield ff_Ka_2 X_A->table[{i}] {y}

        // Sigmoid function: sigmoid(x, mid, deltay, deltax, low, high)

        y = {sigmoid {x} -0.060 1.0 0.010 0.0 1.0}
        setfield ff_Ka_2 X_B->table[{i}] {y}
        x = x + dx
    end

    tweaktau ff_Ka_2 X
    setfield ff_Ka_2 X_A->calc_mode 1 X_B->calc_mode 1
    call ff_Ka_2 TABFILL X 3000 0


    // Define the inactivation gate kinetics.

    call ff_Ka_2 TABCREATE Y 49 -0.1 0.05

    float x  = -0.1
    float dx =  0.15 / 49.0

    for (i = 0; i < 50; i = i + 1)
        y = {sigmoid {x} -0.060 0.048 0.001 0.010 0.500}
        setfield ff_Ka Y_A->table[{i}] {y}

        // Use a negative sigmoid for inactivation.

        y = {negative_sigmoid {x} -0.060 1.0 0.020 1.0 0.0}
        setfield ff_Ka Y_B->table[{i}] {y}
        x = x + dx
    end

    tweaktau ff_Ka_2 Y
    setfield ff_Ka_2 Y_A->calc_mode 1 Y_B->calc_mode 1
    call ff_Ka_2 TABFILL Y 3000 0
end



// ========================================================================
//                      Channel library:
// ========================================================================

function delete_ff_channel_library
    str chan

    foreach chan (ff_Na ff_Kdr ff_Ka ff_Ka_2)
        call /library/{chan} TABDELETE
    end

    delete /library
    reclaim
end

