// genesis

//
// ff_inhib.p:
//     Layer 1 feedforward inhibitory interneuron in piriform cortex.
//     It is quite simple; the only synaptic inputs it receives are
//     afferent inputs from the olfactory bulb, and there is no
//     synaptic facilitation, synaptic depression, NMDA currents, or
//     neuromodulation.  All of these can easily be added.
//

*set_compt_param    RM              0.08
*set_compt_param    RA              3.5
*set_compt_param    CM              0.1
*set_compt_param    Em             -0.073
*set_compt_param    initVm         -0.073

*compt /library/ff_compartment

// The excitatory Gbar is the same as that for the
// mitral cell inputs to pyramidal cells.

soma    none   0  0  25  25                       \
        ff_Na                          1700.0     \
        ff_Kdr                          700.0     \
        ff_aff_exc_syn                    0.5e-9  \
        ff_spikegen                       0.0





