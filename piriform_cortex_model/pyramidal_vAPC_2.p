//
// pyramidal_vAPC_2.p: superficial layer 2 pyramidal cell in piriform cortex.
//     This file represents cells in the ventral anterior piriform cortex
//     only.
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

*compt /library/pyr_compartment

*set_compt_param     RA           0.5829
*set_compt_param     CM           0.0436
*set_compt_param     Em          -0.0578
*set_compt_param     initVm      -0.0578

*set_compt_param     RM           0.451628

*lambda_unwarn

soma           none         0.0       0.0     21.3487     10.4300 \
    pyr_Na               2006.63           \
    pyr_Na_pers            64.8558         \
    pyr_Kdr               251.793          \
    pyr_Ka                440.684          \
    pyr_KM                 57.1509         \
    pyr_Ca                 11.1791         \
    pyr_Ca_conc             1.26684e+19    \
    pyr_Kahp               15.3955         \
    pyr_layer2_3_inh_syn    0.5e-9         \
    pyr_ext_exc_syn         0.2e-9         \
    pyr_spikegen            0.0


*set_compt_param     RM  0.605363

deepIb_1       .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn 0.5e-9  pyr_ext_exc_syn 0.2e-9
deepIb_2       .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn 0.5e-9  pyr_ext_exc_syn 0.2e-9
deepIb_3       .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn 0.5e-9  pyr_layer1_inh_syn_1  1.15e-9   \
        pyr_ext_exc_syn 0.2e-9
supIb_1        .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn 0.5e-9  pyr_layer1_inh_syn_1  1.15e-9   \
        pyr_ext_exc_syn 0.2e-9
supIb_2        .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn 0.5e-9  pyr_layer1_inh_syn_2  1.15e-9   \
        pyr_ext_exc_syn 0.2e-9
supIb_3        .          0.0       0.0     57.8940      1.6016   \
        pyr_aff_exc_syn   0.5e-9  pyr_assoc_exc_syn 0.5e-9        \
        pyr_layer1_inh_syn_2  1.15e-9  pyr_ext_exc_syn 0.2e-9
Ia_1           .          0.0       0.0     57.8940      1.6016   \
        pyr_aff_exc_syn   0.5e-9  pyr_layer1_inh_syn_3  1.15e-9   \
        pyr_ext_exc_syn 0.2e-9
Ia_2           .          0.0       0.0     57.8940      1.6016   \
        pyr_aff_exc_syn   0.5e-9  pyr_layer1_inh_syn_3  1.15e-9   \
        pyr_ext_exc_syn 0.2e-9
basal_1        soma       0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn 0.5e-9  pyr_layer2_3_inh_syn   0.5e-9   \
        pyr_ext_exc_syn 0.2e-9
basal_2        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn 0.5e-9  pyr_layer2_3_inh_syn    0.5e-9  \
        pyr_ext_exc_syn 0.2e-9
basal_3        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn 0.5e-9  pyr_layer2_3_inh_syn    0.5e-9  \
        pyr_ext_exc_syn 0.2e-9
basal_4        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn 0.5e-9  pyr_ext_exc_syn 0.2e-9
basal_5        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn 0.5e-9  pyr_ext_exc_syn 0.2e-9
basal_6        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn 0.5e-9  pyr_ext_exc_syn 0.2e-9



