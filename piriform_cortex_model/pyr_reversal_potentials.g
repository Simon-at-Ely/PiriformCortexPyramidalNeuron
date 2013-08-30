// genesis

// pyr_reversal_potentials.g
//     This script contains global variables that define ionic
//     reversal potentials for the layer 2 pyramidal cell model.

// Reversal potentials

// CHECKME: where is the evidence for these numbers?
//   Ketchum and Haberly (J. Neurophys 69(1):261 (1993)) suggest a lower
//   Erev for GABA-A (5 mV depolarized from resting membrane potential).
//   The K reversal potential seems OK, though; you could put it up to
//   -85 mV.

float PYR_EREST_ACT       = -0.0743
float PYR_ENA             =  0.055
float PYR_EK              = -0.075
float PYR_ECA             =  0.113
float PYR_AMPA_EREV       =  0.0
float PYR_NMDA_EREV       =  0.0
float PYR_GABA_A_EREV     = FP_GABA_A_EREV
float PYR_GABA_B_EREV     = FP_GABA_B_EREV

