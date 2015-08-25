// genesis

//
// ff_vdepchans.g: Voltage-dependent channels for the
//     feedforward inhibitory cell simulation.
//

// channel equilibrium potentials (V)
float FF_EREST_ACT = -0.0743 // superficial pyramidal cell resting potential
float FF_ENA       =  0.055
float FF_EK        = -0.075
float ff_ECA       =  0.080


// ========================================================================
// Feedforward inhibitory neuron fast Na channel.
// Derived from: Na hippocampal cell channel.
// ========================================================================

function make_ff_Na
    if ( {exists ff_Na} )
        return
    end

    create tabchannel ff_Na
    setfield ^               \
        Ek     {FF_ENA}         \      // Volts
        Gbar   0             \      // Amperes
        Ik     0             \      // Siemens
        Gk     0             \  
        Xpower 2             \
        Ypower 1             \
        Zpower 0

    float THRESHOLD_OFFSET = 0.025

    setupalpha ff_Na X  \
        {320.0e3 * (0.0131 + FF_EREST_ACT + THRESHOLD_OFFSET)} \
        -320.0e3                                            \
        -1.0                                                \
        {-1.0*(0.0131 + FF_EREST_ACT + THRESHOLD_OFFSET)}      \
        -0.004                                              \
        {-280.0e3*(0.0401 + FF_EREST_ACT + THRESHOLD_OFFSET)}  \
        280.0e3                                             \
        -1.0                                                \
        {-1.0*(0.0401 + FF_EREST_ACT + THRESHOLD_OFFSET)}      \
        5.0e-3                                              \
        -size 3000 -range -0.1 0.1

    THRESHOLD_OFFSET = 0.025 

    setupalpha ff_Na Y   \
        128.0                                               \
        0.0                                                 \
        0.0                                                 \
        {-1.0*(0.017 + FF_EREST_ACT + THRESHOLD_OFFSET)}       \
        0.018                                               \
        4.0e3                                               \
        0.0                                                 \
        1.0                                                 \
        {-1.0*(0.040 + FF_EREST_ACT + THRESHOLD_OFFSET)}       \
        -5.0e-3                                             \
        -size 3000 -range -0.1 0.1
end




// ========================================================================
// Feedforward inhibitory neuron delayed-rectifier K channel.
// Derived from: K(DR) hippocampal cell channel.
// ========================================================================

function make_ff_Kdr
    if (({exists ff_Kdr}))
        return
    end

    create tabchannel ff_Kdr
    setfield ^ \
        Ek      {FF_EK}     \
        Gbar    0        \
        Ik      0        \
        Gk      0        \
        Xpower  1        \
        Ypower  0        \
        Zpower  0

    setupalpha ff_Kdr X       \
        {16.0e3*(0.0351 + FF_EREST_ACT)}  \
        -16.0e3                        \
        -1.0                           \
        {-1.0 * (0.0351 + FF_EREST_ACT)}  \
        -0.005                         \
        250.0                          \
        0.0                            \
        0.0                            \
        {-1.0*(0.02 + FF_EREST_ACT)}      \
        0.04                           \
        -size 3000 -range -0.1 0.1
end



// ========================================================================
// Feedforward inhibitory neuron A current.
// Derived from: Inspired conjecture.
// ========================================================================

function make_ff_Ka
    if ({exists ff_Ka})
        return
    end

    create tabchannel ff_Ka
    setfield ^ \
        Ek     {FF_EK}      \
        Gbar   0         \
        Ik     0         \
        Gk     0         \
        Xpower 3         \
        Ypower 1         \
        Zpower 0

    setupalpha ff_Ka X \
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

    setupalpha ff_Ka Y \
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



// ========================================================================
// Feedforward inhibitory neuron A current #2
// Derived from: Inspired conjecture.
// ========================================================================

function make_ff_Ka_2
    if ({exists ff_Ka_2})
        return
    end

    create tabchannel ff_Ka_2
    setfield ^ \
        Ek     {FF_EK}      \
        Gbar   0         \
        Ik     0         \
        Gk     0         \
        Xpower 3         \
        Ypower 1         \
        Zpower 0

    setupalpha ff_Ka_2 X \
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

    setupalpha ff_Ka_2 Y \
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

