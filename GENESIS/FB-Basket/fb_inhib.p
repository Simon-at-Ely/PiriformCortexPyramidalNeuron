// genesis

//
// fb_inhib.p:
//     layer 2/3 feedback inhibitory interneuron in piriform cortex.
//     This is a canonical feedback inhibitory cell model.  It
//     doesn't include afferent->fb synapses, NMDA synapses, synaptic
//     facilitation, synaptic depression, or synaptic neuromodulation.
//     All of these can of course be added.  It does include fast and
//     slow GABA-A channels impinging on the cell.
//
*relative
*cartesian
*asymmetric

*set_compt_param    RM              0.08
*set_compt_param    RA              3.5
*set_compt_param    CM              0.1
*set_compt_param    Em             -0.070
*set_compt_param    initVm         -0.070



// 15 uM is probably the best guess for the diameter.
// It really makes no difference as long as the input
// resistance and time constant are in the ballpark.

// The excitatory Gbar is the same as that for the
// association fiber inputs to pyramidal cells.  Similarly,
// the inhibitory Gbar is the same as that for the
// fb inhib interneuron -> pyramidal cell connection.

soma    none   0  0  15  15  fb_Na   1500.0   fb_Kdr   250.0  fb_Ka  20.0








