// genesis

//
// piriform_neuromod.g -- setting up the neuromodulation control objects.
//

//
// A concentration of neuromodulator is used to set several global
// neuromodulation values.
//

//
// All neuromodulator concentrations will be in micromolar (uM).
//
// Here are the different kinds of neuromodulations for the pyramidal
// cell model.  Only the first two are fully parameterized from real data.
// Note that changes referred to as "modulation" can be positive or negative.
//
//  0) dummy multiplicative modulation (always 1.0)
//  1) dummy additive modulation (always 0.0)
//
//  [Pyramidal cells:]
//  2) suppression of layer 1b excitatory synaptic activity
//     -- also used to control augmentation of facilitation
//        in layer 1b excitatory synapses
//  3) augmentation of layer 1a excitatory synaptic activity
//  4) modulation of membrane potential of pyramidal cells
//  5) modulation of Kdr current of pyramidal cells
//  6) modulation of Ka current of pyramidal cells
//  7) modulation of KM current of pyramidal cells
//  8) modulation of Kahp current of pyramidal cells
//
//  [Feedback inhibitory cells:]
//  9) augmentation of membrane potential of feedback inhibitory cells
//
//  [Feedforward inhibitory cells: none]
//  [Feedforward/feedback inhibitory cells: none]
//
//  [Olfactory bulb mitral cells:]
//  10) Decrease in background firing rate of mitral cells
//

//float NEconc = 0.0    // uM
int   NMODS  = 11     // number of types of modulation

float pyr_Em_start, pyr_Em_offset
float pyr_Kdr_scale, pyr_Ka_scale, pyr_KM_scale, pyr_Kahp_scale

pyr_Em_start  = -0.0746751

// Parameters:
pyr_Em_offset   = 0.0025964966043862261827
pyr_Kdr_scale   = 1.2863717419605584791
pyr_Ka_scale    = 0.26786661484743701234
pyr_KM_scale    = 0.75540299918972664273
pyr_Kahp_scale  = 0.54347847632484413971

//
// WARNING: minor bogosity alert!  The Kd values for params 4-8 are
// set very low so that a concentration of 10.0 uM has about the same
// effect as a concentration of 100.0 uM.  I do this because I want
// to use 100 uM for the network simulations, but my data is for 10 uM.
// I have no data whatever that can help me determine the "true" Kd value,
// so I'm assuming that 10.0 uM gives a near-maximal response.  This may,
// of course, be totally false.
//

create neuromod /nmod
call /nmod INITIALIZE {NMODS}

setfield /nmod      \
    conc  {NEconc}  \    // Fixed concentration of NE (uM)
    param[0].type  1  param[0].dummy 1  param[0].start 1.0                  \
    param[1].type  0  param[1].dummy 1  param[1].start 0.0                  \
    param[2].type  1  param[2].m  0.20              param[2].Kd   4.7       \
        param[2].start  1.0                                                 \
    param[3].type  2  param[3].m  0.23              param[3].Kd   8.8       \
        param[3].start  1.0                                                 \
    param[4].type  0  param[4].m  {pyr_Em_offset}   param[4].Kd   0.1       \
        param[4].start  {pyr_Em_start}                                      \
    param[5].type  1  param[5].m  {pyr_Kdr_scale}   param[5].Kd   0.1       \
        param[5].start  1.0                                                 \
    param[6].type  1  param[6].m  {pyr_Ka_scale}    param[6].Kd   0.1       \
        param[6].start  1.0                                                 \
    param[7].type  1  param[7].m  {pyr_KM_scale}    param[7].Kd   0.1       \
        param[7].start  1.0                                                 \
    param[8].type  1  param[8].m  {pyr_Kahp_scale}  param[8].Kd   0.1       \
        param[8].start  1.0                                                 \
    param[9].type  0  param[9].m  0.010             param[9].Kd   0.1       \
        param[9].start -0.070                                               \
    param[10].type 1  param[10].m 0.40              param[10].Kd  0.1       \
        param[10].start 1.0  // 1.0


//    param[9].type  0  param[9].m  0.010             param[9].Kd  10.0       \
//        param[9].start -0.070                                               \


function set_NE(level)
    float level
    NEconc = {level}  // For bookkeeping.
    setfield /nmod conc {NEconc}
end


function get_NE
    return {getfield /nmod conc}
end


//
// Record outputs, if desired.
//


/*
create asc_file /mod0
setfield ^ flush 1 leave_open 1
useclock /mod0 1
addmsg /nmod /mod0 SAVE mod[0]

create asc_file /mod1
setfield ^ flush 1 leave_open 1
useclock /mod1 1
addmsg /nmod /mod1 SAVE mod[1]

create asc_file /mod2
setfield ^ flush 1 leave_open 1
useclock /mod2 1
addmsg /nmod /mod2 SAVE mod[2]

create asc_file /mod3
setfield ^ flush 1 leave_open 1
useclock /mod3 1
addmsg /nmod /mod3 SAVE mod[3]

create asc_file /mod4
setfield ^ flush 1 leave_open 1
useclock /mod4 1
addmsg /nmod /mod4 SAVE mod[4]

create asc_file /mod5
setfield ^ flush 1 leave_open 1
useclock /mod5 1
addmsg /nmod /mod5 SAVE mod[5]


create asc_file /mod6
setfield ^ flush 1 leave_open 1
useclock /mod6 1
addmsg /nmod /mod6 SAVE mod[6]

create asc_file /mod7
setfield ^ flush 1 leave_open 1
useclock /mod7 1
addmsg /nmod /mod7 SAVE mod[7]

create asc_file /mod8
setfield ^ flush 1 leave_open 1
useclock /mod8 1
addmsg /nmod /mod8 SAVE mod[8]

create asc_file /mod9
setfield ^ flush 1 leave_open 1
useclock /mod9 1
addmsg /nmod /mod9 SAVE mod[9]

create asc_file /mod10
setfield ^ flush 1 leave_open 1
useclock /mod10 1
addmsg /nmod /mod10 SAVE mod[10]

*/

