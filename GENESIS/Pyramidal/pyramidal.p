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

*compt /library/pyr_compartment

*set_compt_param     RA           0.5829
*set_compt_param     CM           0.0436
*set_compt_param     Em          -0.0746751
*set_compt_param     initVm      -0.0746751

*set_compt_param     RM           0.451628

//*lambda_unwarn

soma           none         0.0       0.0     21.3487     10.4300 \
    Na               2006.63           \
    Na_pers            64.8558         \
    Kdr               241.793          \  // 251.793
    Ka                440.684          \
    KM                 57.1509         \
    Ca                 11.1791         \
    Ca_conc             1.26684e+19    \
    Kahp               15.3955         \
//  Kahp2 ???
    pyr_layer2_3_inh_syn_fGABA_A   0.5e-9  \
    pyr_layer2_3_inh_syn_sGABA_A   0.5e-9  \
    pyr_ext_exc_syn_NMDA           0.2e-9  \
    pyr_ext_exc_syn_AMPA           0.2e-9  \
    pyr_spikegen            0.0


*set_compt_param     RM  0.605363

deepIb_1       .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn_NMDA 0.5e-9  pyr_assoc_exc_syn_AMPA 0.5e-9\ 
	pyr_layer1_inh_syn_0_fGABA_A  1.15e-9  pyr_layer1_inh_syn_0_sGABA_A  1.15e-9  pyr_layer1_inh_syn_0_GABA_B  1.15e-9   \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9     \
        Kdr 10.0
deepIb_2       .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn_NMDA 0.5e-9  pyr_assoc_exc_syn_AMPA 0.5e-9  pyr_layer1_inh_syn_0_fGABA_A  1.15e-9  \
	pyr_layer1_inh_syn_0_sGABA_A  1.15e-9  pyr_layer1_inh_syn_0_GABA_B  1.15e-9   \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9     \
        Kdr 10.0
deepIb_3       .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn_NMDA 0.5e-9  pyr_assoc_exc_syn_AMPA 0.5e-9  pyr_layer1_inh_syn_1_fGABA_A  1.15e-9  \
	pyr_layer1_inh_syn_1_sGABA_A  1.15e-9  pyr_layer1_inh_syn_1_GABA_B  1.15e-9  \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9     \
        Kdr 10.0
supIb_1        .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn_NMDA 0.5e-9  pyr_assoc_exc_syn_AMPA 0.5e-9  pyr_layer1_inh_syn_1_fGABA_A  1.15e-9  \
	pyr_layer1_inh_syn_1_sGABA_A  1.15e-9  pyr_layer1_inh_syn_1_GABA_B  1.15e-9  \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9     \
        Kdr 10.0
supIb_2        .          0.0       0.0     57.8940      1.6016   \
        pyr_assoc_exc_syn_NMDA 0.5e-9  pyr_assoc_exc_syn_AMPA 0.5e-9  pyr_layer1_inh_syn_2_fGABA_A  1.15e-9   \
	pyr_layer1_inh_syn_2_sGABA_A  1.15e-9   pyr_layer1_inh_syn_2_GABA_B  1.15e-9   \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9     \
        Kdr 10.0
supIb_3        .          0.0       0.0     57.8940      1.6016   \
        pyr_aff_exc_syn_AMPA   0.5e-9  pyr_aff_exc_syn_NMDA   0.5e-9	\
	pyr_assoc_exc_syn_NMDA 0.5e-9  pyr_assoc_exc_syn_AMPA 0.5e-9        \
        pyr_layer1_inh_syn_2_fGABA_A  1.15e-9   pyr_layer1_inh_syn_2_sGABA_A  1.15e-9   pyr_layer1_inh_syn_2_GABA_B  1.15e-9   \                             \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9     \
        Kdr 10.0
Ia_1           .          0.0       0.0     57.8940      1.6016   \
        pyr_aff_exc_syn_AMPA   0.5e-9  pyr_aff_exc_syn_NMDA   0.5e-9	\
	pyr_layer1_inh_syn_3_fGABA_A  1.15e-9   \
	pyr_layer1_inh_syn_3_sGABA_A  1.15e-9   pyr_layer1_inh_syn_3_GABA_B  1.15e-9   \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9     \
        Kdr 10.0
Ia_2           .          0.0       0.0     57.8940      1.6016   \
        pyr_aff_exc_syn_AMPA   0.5e-9  pyr_aff_exc_syn_NMDA   0.5e-9	\
	pyr_layer1_inh_syn_3_fGABA_A  1.15e-9   \
	pyr_layer1_inh_syn_3_sGABA_A  1.15e-9   pyr_layer1_inh_syn_3_GABA_B  1.15e-9   \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9     \
        Kdr 10.0
basal_1        soma       0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn_AMPA 0.5e-9  pyr_local_exc_syn_NMDA 0.5e-9  \
	pyr_layer2_3_inh_syn_fGABA_A   0.5e-9   pyr_layer2_3_inh_syn_sGABA_A   0.5e-9  \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9                                    \
        Kdr 10.0
basal_2        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn_AMPA 0.5e-9  pyr_local_exc_syn_NMDA 0.5e-9  \
	pyr_layer2_3_inh_syn_fGABA_A   0.5e-9   pyr_layer2_3_inh_syn_sGABA_A   0.5e-9  \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9                                    \
        Kdr 10.0
basal_3        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn_AMPA 0.5e-9  pyr_local_exc_syn_NMDA 0.5e-9  \
	pyr_layer2_3_inh_syn_fGABA_A   0.5e-9   pyr_layer2_3_inh_syn_sGABA_A   0.5e-9  \
        pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9                                    \
        Kdr 10.0
basal_4        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn_AMPA 0.5e-9  pyr_local_exc_syn_NMDA 0.5e-9  \
	pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9          \
        Kdr 10.0
basal_5        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn_AMPA 0.5e-9  pyr_local_exc_syn_NMDA 0.5e-9  \
	pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9          \
        Kdr 10.0
basal_6        .          0.0       0.0    -79.6812      3.2010   \
        pyr_local_exc_syn_AMPA 0.5e-9  pyr_local_exc_syn_NMDA 0.5e-9  \
	pyr_ext_exc_syn_NMDA 0.2e-9  pyr_ext_exc_syn_AMPA 0.2e-9          \
        Kdr 10.0



