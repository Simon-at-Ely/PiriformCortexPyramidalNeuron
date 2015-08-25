// genesis

//
// ff_fb_inhib.p:
//     layer 1 feedforward/feedback inhibitory interneuron in piriform
//     cortex.  This cell is identical to the ff_inhib cell except that
//
//     a) it's meant to be located deeper in the cortex (below layer 1a);
//     b) it receives both feedforward input from the olfactory bulb
//        through the LOT and feedback input from pyramidal cells.
//
// Evidence for inhibitory cells with these projection patterns:
//   -- Ekstrand and Haberly (1995) Soc. Neurosci. Abstr. 21:1186
//
// The compartments/channels still use the ff_ naming convention.  This
// underscores the fact that these cells are simply more deeply located
// ff inhibitory cells, and is not a mistake.
//

// Passive numbers from a single experiment by Alfredo Fontanini (!)

*relative
*cartesian
*asymmetric

*set_compt_param    RM              0.12
*set_compt_param    RA              3.5
*set_compt_param    CM              0.16
*set_compt_param    Em             -0.065 // -0.070
*set_compt_param    initVm         -0.065 // -0.070


// The excitatory Gbars are the same as that for the
// afferent/associational inputs to pyramidal cells.
// We use ff_fb_spikegen instead of ff_spikegen because
// you need to distinguish the two when setting up connections.

soma    none   0  0  15  15 ff_fb_Na   1500.0   ff_fb_Kdr   250.0  ff_fb_Ka  20.0
