// M. C. Vanier and J. M. Bower
// A Comparative Survey of Automated Parameter-Searching Methods
// for Compartmental Neural Models

// Description of the simplified layer 2 pyramidal cell model
// (model 5).  Morphology, passive parameters, and initial values 
// of the channel conductance densities.

*compt /library/compartment

// RM: the specific membrane resistivity in units of ohm-(meter^2
// RA: the specific axial resistivity in units of ohm-meter
// CM: the specific membrane capacitance in units of farad/(meter^2)
// Em: passive membrane "reversal potential" in units of volts
// initVm: starting value of the resting potential in volts

*set_compt_param     RM	     	  0.5029  
*set_compt_param     RA	     	  0.5829 
*set_compt_param     CM	     	  0.0436
*set_compt_param     Em          -0.0594
*set_compt_param     initVm      -0.0594

// Format: compartment_name parent_name x y z diameter 
//    [Channel density]...
//
// The xyz coordinates are of the end of the compartment only.
// x, y, z, and diameter coordinates are in microns.
// Channel densities represent the maximum conductance of the
// channel per unit area, and are in units of siemens/(meter^2) 
// Ca_conc is not a channel but a calcium buffer; the density
// value represents the scaling between total current through 
// Ca channels and increase in Ca concentration; it scales with
// compartment _volume_, not area.  Its units are M/(ampere-sec)/(meter^3)

soma   none     0.0       0.0   21.3 10.4 \
    Na 2800  Kdr 270 Ka 200  \
    Ca 10.0

// Na_pers 65 KM 100.0  Kahp 4.0 Kahp2 20.0 Ca_conc 1.0e+21




