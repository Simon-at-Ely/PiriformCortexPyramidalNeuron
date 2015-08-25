// genesis

//
// fb_vdepchans.g: Voltage-dependent channels for the
//     feedback inhibitory cell simulation.
//

// channel equilibrium potentials (V)
   float FB_EREST_ACT = -0.0743 // superficial pyramidal cell resting potential
   float FB_ENA       =  0.055
   float FB_EK        = -0.075
   float FB_ECA       =  0.080

// ========================================================================
// Feedback inhibitory neuron fast Na channel.
// Derived from: Na hippocampal cell channel.
// ========================================================================

function make_fb_Na
    if ( {exists fb_Na} )
        return
    end

    create tabchannel fb_Na
    setfield ^               \
        Ek     {FB_ENA}         \      // Volts
        Gbar   0             \      // Amperes
        Ik     0             \      // Siemens
        Gk     0             \  
        Xpower 2             \
        Ypower 1             \
        Zpower 0

    float THRESHOLD_OFFSET = 0.025

    setupalpha fb_Na X  \
        {320.0e3 * (0.0131 + FB_EREST_ACT + THRESHOLD_OFFSET)} \
        -320.0e3                                            \
        -1.0                                                \
        {-1.0*(0.0131 + FB_EREST_ACT + THRESHOLD_OFFSET)}      \
        -0.004                                              \
        {-280.0e3*(0.0401 + FB_EREST_ACT + THRESHOLD_OFFSET)}  \
        280.0e3                                             \
        -1.0                                                \
        {-1.0*(0.0401 + FB_EREST_ACT + THRESHOLD_OFFSET)}      \
        5.0e-3                                              \
        -size 3000 -range -0.1 0.1

    THRESHOLD_OFFSET = 0.025 

    setupalpha fb_Na Y   \
        128.0                                               \
        0.0                                                 \
        0.0                                                 \
        {-1.0*(0.017 + FB_EREST_ACT + THRESHOLD_OFFSET)}       \
        0.018                                               \
        4.0e3                                               \
        0.0                                                 \
        1.0                                                 \
        {-1.0*(0.040 + FB_EREST_ACT + THRESHOLD_OFFSET)}       \
        -5.0e-3                                             \
        -size 3000 -range -0.1 0.1
end



// ========================================================================
// Feedback inhibitory neuron delayed-rectifier K channel.
// Derived from: K(DR) hippocampal cell channel.
// ========================================================================

function make_fb_Kdr
    if (({exists fb_Kdr}))
        return
    end

    create tabchannel fb_Kdr
    setfield ^ \
        Ek      {FB_EK}     \
        Gbar    0        \
        Ik      0        \
        Gk      0        \
        Xpower  1        \
        Ypower  0        \
        Zpower  0

    setupalpha fb_Kdr X       \
        {16.0e3*(0.0351 + FB_EREST_ACT)}  \
        -16.0e3                        \
        -1.0                           \
        {-1.0 * (0.0351 + FB_EREST_ACT)}  \
        -0.005                         \
        250.0                          \
        0.0                            \
        0.0                            \
        {-1.0*(0.02 + FB_EREST_ACT)}      \
        0.04                           \
        -size 3000 -range -0.1 0.1
end

// ========================================================================
// Feedback inhibitory neuron A current.
// Derived from: Inspired conjecture.
// ========================================================================

function make_fb_Ka
    if ({exists fb_Ka})
        return
    end

    create tabchannel fb_Ka
    setfield ^ \
        Ek     {FB_EK}      \
        Gbar   0         \
        Ik     0         \
        Gk     0         \
        Xpower 3         \
        Ypower 1         \
        Zpower 0

    setupalpha fb_Ka X \
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

    setupalpha fb_Ka Y \
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

