//
// pyramidal.p: superficial layer 2 pyramidal cell in piriform cortex.
//

// N.B. the high "accuracy" of some numbers is because these numbers
//      were derived from a parameter search.

//
// NOTE: the synaptic conductances are estimates of the conductance of
//       a single synaptic connection, and have been taken from
//       Kapur et. al. J. Neurophys. 78(5): pp. 2546-2559.
//       The weight-setting commands multiply this "unitary" conductance
//       by a scaling factor to get the total conductance in that
//       region of membrane.
//
// NOTE2: Matt Wilson used:
//        --  50 pS/synapse for GABA-B conductances
//        -- 500 pS/synapse for GABA-A conductances
//        -- 200 pS/synapse for AMPA conductances
//        This means our channels are about twice as big as Matt's on average.
//
// The conductance values used are:
//
// excitatory AMPA:        0.5  nS
// inhibitory fast GABA-A: 1.15 nS
//
// Note that excitatory NMDA is implemented as a proportion of the total
// AMPA conductance, so we don't need it here.  This is also true for
// inhibitory slow GABA-A and inhibitory slow GABA-B conductances.
// For the ratios used see pyr_synchans.g.
//
*relative
*cartesian
*asymmetric

*set_compt_param     RA           0.5829
*set_compt_param     CM           0.0436
*set_compt_param     Em          -0.0746751
*set_compt_param     initVm      -0.0746751

*set_compt_param     RM           0.451628

//*lambda_unwarn

soma           none         0.0       0.0     21.3487     10.4300 Na  2006.63   Na_pers  64.8558 Kdr  241.793 Ka  440.684 KM 57.1509 Ca_conc 1.26684e+19  Ca 11.1791 Kahp2 15.3955 

*set_compt_param     RM  0.605363

deepIb_1       .          0.0       0.0     57.8940      1.6016   Kdr 10.0
deepIb_2       .          0.0       0.0     57.8940      1.6016   Kdr 10.0
deepIb_3       .          0.0       0.0     57.8940      1.6016   Kdr 10.0
supIb_1        .          0.0       0.0     57.8940      1.6016   Kdr 10.0
supIb_2        .          0.0       0.0     57.8940      1.6016   Kdr 10.0
supIb_3        .          0.0       0.0     57.8940      1.6016   Kdr 10.0
Ia_1           .          0.0       0.0     57.8940      1.6016   Kdr 10.0
Ia_2           .          0.0       0.0     57.8940      1.6016   Kdr 10.0
basal_1        soma       0.0       0.0    -79.6812      3.2010   Kdr 10.0
basal_2        .          0.0       0.0    -79.6812      3.2010   Kdr 10.0
basal_3        .          0.0       0.0    -79.6812      3.2010   Kdr 10.0
basal_4        .          0.0       0.0    -79.6812      3.2010   Kdr 10.0
basal_5        .          0.0       0.0    -79.6812      3.2010   Kdr 10.0
basal_6        .          0.0       0.0    -79.6812      3.2010   Kdr 10.0



