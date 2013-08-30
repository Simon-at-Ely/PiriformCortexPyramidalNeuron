// genesis

//
// piriform_free_params.g: "free" parameters for the model.
//     Note that in many (most?) cases, the free parameters are
//     constrained by data to some extent, but I call them "free"
//     since precise values are not available.  These are the parameters
//     that I allow myself to tweak in order to match the network's
//     behavior to that of the real system.  All such parameters
//     will have the prefix "FP_".
//
// Many of these parameters are discussed in greater detail in the file
// "piriform_params_conn.g"; my goal here is to collect in one place
// the parameters I need to adjust to make my model fit the data with
// as little extraneous information as possible.
//
// The only connection-related parameters that I have left out of this
// file that could conceivably be here are the distribution factors
// for distributing synapses onto different compartments of the pyramidal
// cells.  In most cases there is some idea of what the correct values
// could be, but in some cases (notably the basal dendritic region) there
// isn't.
//

//
// Fundamental scale of network:
//
// So far, we have "small", "medium-small", "medium", and "large" scales,
// which correspond to about 100, 200, 400, and 1000 pyramidal cells,
// respectively.
//

str scale = "small"


//
// Local connection extents.
//

float FP_PYR_FB_CONNECTION_EXTENT        = 1.5e-3
float FP_FB_PYR_CONNECTION_EXTENT        = 1.5e-3
float FP_FF_PYR_CONNECTION_EXTENT        = 1.5e-3
float FP_PYR_FF_FB_CONNECTION_EXTENT     = 1.5e-3
float FP_FF_FB_PYR_CONNECTION_EXTENT     = 1.5e-3
float FP_FF_FB_FF_FB_CONNECTION_EXTENT   = 1.5e-3
float FP_FB_FB_CONNECTION_EXTENT         = 1.5e-3
float FP_PYR_PYR_LOCAL_CONNECTION_EXTENT = 1.5e-3

//
// Connection holes.  "LR" stands for "long-range".
//

if (scale == "small")
    float FP_PYR_PYR_LR_VAPC_CONNECTION_HOLE = 0.5e-3 // 1.5e-3
    float PYR_PYR_VAPC_CONNECTION_OFFSET     = 1.5e-3
    float FP_PYR_PYR_LR_DAPC_CONNECTION_HOLE = 1.5e-3
    float FP_PYR_PYR_LR_PPC_CONNECTION_HOLE  = 3.5e-3
elif (scale == "medium-small")
    float FP_PYR_PYR_LR_VAPC_CONNECTION_HOLE = 1.8e-3
    float FP_PYR_PYR_LR_DAPC_CONNECTION_HOLE = 1.8e-3
    float FP_PYR_PYR_LR_PPC_CONNECTION_HOLE  = 3.5e-3
elif (scale == "medium")
    // FIXME: probably need to adjust these:
    float FP_PYR_PYR_LR_VAPC_CONNECTION_HOLE = 1.8e-3
    float FP_PYR_PYR_LR_DAPC_CONNECTION_HOLE = 1.8e-3
    float FP_PYR_PYR_LR_PPC_CONNECTION_HOLE  = 3.5e-3
elif (scale == "large")
    // FIXME: probably need to adjust these:
    float FP_PYR_PYR_LR_VAPC_CONNECTION_HOLE = 1.8e-3
    float FP_PYR_PYR_LR_DAPC_CONNECTION_HOLE = 1.8e-3
    float FP_PYR_PYR_LR_PPC_CONNECTION_HOLE  = 3.5e-3
end



//
// Connection probabilities.  These aren't as significant as you'd think,
// since most of the effect of the change in connection probabilities
// as a function of distance is subsumed in the code that sets the
// connection weights.  These mainly just add noise to the model.
// However, in some cases it's also very important that cells receive a
// different set of inputs since the weights are all going to be in the
// same range. Ideally we would use the same probabilities throughout,
// but our computers can only handle a certain number of connections.
// Since the connection probabilities fall into several classes, we define
// hyperparameters here that are used in the file "piriform_params_conn.g".
//

float FP_BULB_CONNECTION_PROB
float FP_PYR_PYR_LOCAL_CONNECTION_PROB
float FP_PYR_PYR_LR_CONNECTION_PROB
float FP_INTERNEURON_CONNECTION_PROB

//
// NOTE: Matt used:
// -- 0.1  for bulb->any
// -- 0.1  for pyr->pyr local
// -- 0.01 for pyr->pyr distant
// -- 0.5  for all interneurons
//
// This was presumably independent of scale.  Here we adjust things
// for scale because otherwise the granularity of the simulation
// causes strange artifacts.  Note that the weight distribution is
// essentially independent of this, except that the variation goes up
// as the connection probabilities decrease.
//

if (scale == "small")
    FP_BULB_CONNECTION_PROB           = 0.2
    FP_PYR_PYR_LOCAL_CONNECTION_PROB  = 0.2
    FP_PYR_PYR_LR_CONNECTION_PROB     = 0.2
    FP_INTERNEURON_CONNECTION_PROB    = 1.0
elif (scale == "medium-small")
    FP_BULB_CONNECTION_PROB           = 0.2
    FP_PYR_PYR_LOCAL_CONNECTION_PROB  = 0.15
    FP_PYR_PYR_LR_CONNECTION_PROB     = 0.15
    FP_INTERNEURON_CONNECTION_PROB    = 0.75
elif (scale == "medium")
    FP_BULB_CONNECTION_PROB           = 0.2
    FP_PYR_PYR_LOCAL_CONNECTION_PROB  = 0.1
    FP_PYR_PYR_LR_CONNECTION_PROB     = 0.1
    FP_INTERNEURON_CONNECTION_PROB    = 0.5
elif (scale == "large")
    FP_BULB_CONNECTION_PROB           = 0.2
    FP_PYR_PYR_LOCAL_CONNECTION_PROB  = 0.05
    FP_PYR_PYR_LR_CONNECTION_PROB     = 0.05
    FP_INTERNEURON_CONNECTION_PROB    = 0.25
end

//
// Group->group connection probabilities.
//

float FP_PYR_PYR_GROUP_CONNECTION_PROB
float FP_PYR_FB_GROUP_CONNECTION_PROB
float FP_FB_PYR_GROUP_CONNECTION_PROB

if (scale == "small")
    FP_PYR_PYR_GROUP_CONNECTION_PROB = 1.0
    FP_PYR_FB_GROUP_CONNECTION_PROB  = 0.0  // not used
    FP_FB_PYR_GROUP_CONNECTION_PROB  = 0.0  // not used
elif (scale == "medium-small")
    FP_PYR_PYR_GROUP_CONNECTION_PROB = 1.0
    FP_PYR_FB_GROUP_CONNECTION_PROB  = 0.0 // not used
    FP_FB_PYR_GROUP_CONNECTION_PROB  = 0.0 // not used
elif (scale == "medium")
    FP_PYR_PYR_GROUP_CONNECTION_PROB = 0.5
    FP_PYR_FB_GROUP_CONNECTION_PROB  = 0.0 // not used
    FP_FB_PYR_GROUP_CONNECTION_PROB  = 0.0 // not used
end


//
// Synapse numbers per cell.  These are pretty much derived from guesswork
// or borrowed from other models, notably Matt Wilson's piriform cortex
// model and the Kapur/Lytton/Haberly model.
//

int no_pyr_Kahp = 0  // Flag for no Kahp current in pyramidal cells.

if (no_pyr_Kahp)
    if (scale == "small")
        float FP_PIRIFORM_NAFF_PYR_SYNAPSES             =  155.0
    elif (scale == "medium-small")
        float FP_PIRIFORM_NAFF_PYR_SYNAPSES             =  155.0
    elif (scale == "medium")
        float FP_PIRIFORM_NAFF_PYR_SYNAPSES             =  155.0
    end
else  // normal case
    if (scale == "small")
        float FP_PIRIFORM_NAFF_PYR_SYNAPSES             =  250.0 // 170.0
    elif (scale == "medium-small")
        float FP_PIRIFORM_NAFF_PYR_SYNAPSES             =  250.0 // 170.0
    elif (scale == "medium")
        float FP_PIRIFORM_NAFF_PYR_SYNAPSES             =  250.0 // 170.0
    end
end

float FP_PIRIFORM_NAFF_FF_SYNAPSES              =    0.0 // 90.0
float FP_PIRIFORM_NAFF_FF_FB_SYNAPSES           =    0.0 // 5.0

if (scale == "small")
    float FP_PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES  =   25.0 // 50.0
    float FP_PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES  =   35.0 // 75.0
    float FP_PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES   =   50.0 // 100.0
    float FP_PIRIFORM_NPYR_PYR_VAPC_SYNAPSES        =  150.0 // 150.0
    float FP_PIRIFORM_NPYR_PYR_DAPC_SYNAPSES        =    0.0 // 100.0
    float FP_PIRIFORM_NPYR_PYR_PPC_SYNAPSES         =    0.0 // 50.0
elif (scale == "medium-small")
    float FP_PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES  =   20.0 // 50.0
    float FP_PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES  =   30.0 // 75.0
    float FP_PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES   =   40.0 // 100.0
    float FP_PIRIFORM_NPYR_PYR_VAPC_SYNAPSES        =  150.0 // 150.0
    float FP_PIRIFORM_NPYR_PYR_DAPC_SYNAPSES        =    0.0 // 100.0
    float FP_PIRIFORM_NPYR_PYR_PPC_SYNAPSES         =    0.0 // 50.0
elif (scale == "medium")
    float FP_PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES  =   14.0 // 50.0
    float FP_PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES  =   19.0 // 75.0
    float FP_PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES   =   28.0 // 100.0
    float FP_PIRIFORM_NPYR_PYR_VAPC_SYNAPSES        =  150.0 // 150.0
    float FP_PIRIFORM_NPYR_PYR_DAPC_SYNAPSES        =    0.0 // 100.0
    float FP_PIRIFORM_NPYR_PYR_PPC_SYNAPSES         =    0.0 // 50.0
end

float FP_PIRIFORM_NPYR_FB_SYNAPSES              =  100.0
float FP_PIRIFORM_NFB_PYR_SYNAPSES              =   35.0
float FP_PIRIFORM_NFB_FB_SYNAPSES               =   50.0
float FP_PIRIFORM_NPYR_FF_FB_SYNAPSES           =    5.0

if (scale == "small")
    float FP_PIRIFORM_NFF_FB_PYR_SYNAPSES           =   27.0
else  // medium, no NE only; untested on others
    float FP_PIRIFORM_NFF_FB_PYR_SYNAPSES           =   12.0
end

float FP_PIRIFORM_NFF_PYR_SYNAPSES              =  500.0
float FP_PIRIFORM_NFF_FB_FF_FB_SYNAPSES         =    0.0

//
// Scaling factors for the feedback inhibitory cells in different zones.
//

// BOGOSITY ALERT: this variable is duplicated from piriform_params.g
// due to problems with the include order.  There, it is called
// PIRIFORM_X_EXTENT.  I could fix this if I had time and interest...
float X_EXTENT = 8.0e-3  // 8 mm

float FP_PYR_FB_SCALE1 = 1.0
float FP_X1 = X_EXTENT * (1.0 / 4.0)
float FP_PYR_FB_SCALE2 = 1.0
float FP_X2 = X_EXTENT * (1.0 / 2.0)
float FP_PYR_FB_SCALE3 = 1.0
float FP_X3 = X_EXTENT * (3.0 / 4.0)
float FP_PYR_FB_SCALE4 = 1.0

//
// LOT transition factor.  This reflects a decrease in afferent connection
// density as the LOT is crossed.  There is some indirect evidence for this,
// in that tufted cells in the olfactory bulb only seem to project to the
// ventral afferent piriform cortex.
//

float FP_LOT_TRANSITION_FACTOR = 1.0


//
// Directional weight modification scale factors: these are weight multipliers
// which depend on which direction the connections are going (anterior
// to posterior or vice-versa).
//

float FP_PYR_PYR_LOCAL_PA_SCALE = 1.0   // posterior->anterior
float FP_PYR_PYR_LOCAL_AP_SCALE = 1.0   // anterior->posterior

float FP_PYR_PYR_VAPC_PA_SCALE  = 1.0
float FP_PYR_PYR_VAPC_AP_SCALE  = 1.0

float FP_PYR_PYR_DAPC_PA_SCALE  = 1.0
float FP_PYR_PYR_DAPC_AP_SCALE  = 1.0

float FP_PYR_PYR_PPC_PA_SCALE   = 1.0
float FP_PYR_PYR_PPC_AP_SCALE   = 1.0



//
// Background synaptic input onto pyramidal cells.
// Without this you need a very large amount of afferent input to
// get the cells to fire at all.
//

float FP_BG_FREQ_VAPC =   0.0
float FP_BG_WT_VAPC   =   0.1
float FP_BG_FREQ_DAPC =   0.0
float FP_BG_WT_DAPC   =   0.1
float FP_BG_FREQ_PPC  =   0.0
float FP_BG_WT_PPC    =   0.1


//
// Synaptic weight decay parameters.
//

// Hyperparameters.

float FP_DECAY_RATE1 = 1.0 / 20.0e-3
float FP_DECAY_RATE2 = 1.0 / 4.0e-3
float FP_DECAY_RATE3 = 1.0 / 6.0e-3
float FP_DECAY_RATE4 = 1.0 / 1.0e-3

float FP_BULB_PYR_DECAY_RATE1       =  FP_DECAY_RATE1
float FP_BULB_PYR_DECAY_RATE2       =  FP_DECAY_RATE2
float FP_BULB_FF_DECAY_RATE1        =  FP_DECAY_RATE1
float FP_BULB_FF_DECAY_RATE2        =  1.0 / 7.0e-3
float FP_BULB_FF_FB_DECAY_RATE1     =  FP_DECAY_RATE1
float FP_BULB_FF_FB_DECAY_RATE2     =  1.0 / 8.0e-3

float FP_PYR_PYR_LOCAL_DECAY_RATE   =  FP_DECAY_RATE4
float FP_PYR_PYR_VAPC_DECAY_RATE    =  1.0 / 4.0e-3
float FP_PYR_PYR_DAPC_DECAY_RATE    =  1.0 / 4.0e-3
float FP_PYR_PYR_PPC_DECAY_RATE     =  1.0 / 16.0e-3

float FP_PYR_FB_DECAY_RATE          =  FP_DECAY_RATE2
float FP_FB_PYR_DECAY_RATE          =  FP_DECAY_RATE2
float FP_FB_FB_DECAY_RATE           =  FP_DECAY_RATE2

float FP_PYR_FF_FB_DECAY_RATE       =  FP_DECAY_RATE2
float FP_FF_FB_PYR_DECAY_RATE       =  FP_DECAY_RATE2
float FP_FF_FB_FF_FB_DECAY_RATE     =  FP_DECAY_RATE2
float FP_FF_PYR_DECAY_RATE          =  FP_DECAY_RATE2


//
// Synaptic weight randomization parameters.
//

float FP_WT_STDEV  = 0.05 // 0.10  // % variation: 0.1 = 10%
float FP_WT_MAXDEV = 0.15 // 0.30


//
// NMDA synapse-related parameters.
//

//
//     Because the synaptic weights are higher than they would be in the
//     real system to compensate for scaling effects, there is an
//     "induced synchrony" whereby one presynaptic spike is really like a
//     whole lot of presynaptic spikes occurring synchronously in the real
//     system.  This may not be a big problem for AMPA synapses, but for
//     NMDA synapses it could magnify the effect of NMDA because the
//     postsynaptic membrane potentials will often be much higher than
//     usual.  One way to compensate for this might by making the "gamma"
//     or "eta" parameters of the NMDA conductances larger than they should
//     really be, which is why they are free parameters.  Another way to
//     compensate is simply to reduce the NMDA maximal conductances.
//

float FP_NMDA_GAMMA           =  80.0   // V^(-1)
float FP_NMDA_ETA             =   3.3   // mM^(-1)
float FP_PYR_AFF_NMDA_PGBAR   =   0.1
float FP_PYR_ASSOC_NMDA_PGBAR =   0.1
float FP_PYR_EXT_NMDA_PGBAR   =   0.0
float FP_FB_ASSOC_NMDA_PGBAR  =   0.0


//
// Inhibition-related parameters.
//

float FP_FAST_GABA_A_TAU2       = 0.00725 // 0.00725
float FP_SLOW_GABA_A_TAU2       = 0.037   // 0.037
float FP_GABA_B_TAU1            = 0.070   // 0.070
float FP_GABA_B_TAU2            = 0.070   // 0.070

// Flag for whether to use synaptic depression on inhibitory synapses:
float FP_INH_DEPR               = 1

// ff/fb inhibitory cells only:
// Used for 1a #1 and #2 compartments:
float FP_PYR_INH_1_3_PGBAR1     = 0.0     // 0.0
float FP_PYR_INH_1_3_PGBAR2     = 1.0     // 0.22
float FP_PYR_INH_1_3_PGBAR3     = 0.0     // 0.0167

// Used for sup 1b #2 and #3 compartments:
float FP_PYR_INH_1_2_PGBAR1     = 0.0     // 1.0
float FP_PYR_INH_1_2_PGBAR2     = 1.0     // 0.22
float FP_PYR_INH_1_2_PGBAR3     = 0.0     // 0.0167

// Used for deep 1b #3 and sup 1b #1 compartments:
float FP_PYR_INH_1_1_PGBAR1     = 0.0     // 1.0
float FP_PYR_INH_1_1_PGBAR2     = 1.0     // 0.0
float FP_PYR_INH_1_1_PGBAR3     = 0.0     // 0.0167

// Used for deep 1b #1 and #2 compartments:
float FP_PYR_INH_1_0_PGBAR1     = 0.0
float FP_PYR_INH_1_0_PGBAR2     = 1.0
float FP_PYR_INH_1_0_PGBAR3     = 0.0


// ff inhibitory cells only:
// Used for 1a #1 and #2 compartments:
float FP_PYR_INH_1_3_B_PGBAR1   = 0.0       // 0.0
float FP_PYR_INH_1_3_B_PGBAR2   = 0.2       // 0.22
float FP_PYR_INH_1_3_B_PGBAR3   = 0.0       // 0.0167

// Used for sup 1b #2 and #3 compartments:
float FP_PYR_INH_1_2_B_PGBAR1   = 0.0       // 1.0
float FP_PYR_INH_1_2_B_PGBAR2   = 0.2       // 0.22
float FP_PYR_INH_1_2_B_PGBAR3   = 0.0       // 0.0167

// Used for deep 1b #3 and sup 1b #1 compartments:
float FP_PYR_INH_1_1_B_PGBAR1   = 0.0       // 1.0
float FP_PYR_INH_1_1_B_PGBAR2   = 1.0       // 0.0
float FP_PYR_INH_1_1_B_PGBAR3   = 0.0       // 0.0167

// Used for deep 1b #1 and #2 compartments:
float FP_PYR_INH_1_0_B_PGBAR1   = 0.0
float FP_PYR_INH_1_0_B_PGBAR2   = 1.0
float FP_PYR_INH_1_0_B_PGBAR3   = 0.0


// Used for feedback inhibition onto soma and basal dendrites:
float FP_PYR_INH_2_3_PGBAR1     = 1.0     // 1.0
float FP_PYR_INH_2_3_PGBAR2     = 0.0     // 0.1     // 0.3

float FP_FB_INH_PGBAR1          = 1.0     // 1.0
float FP_FB_INH_PGBAR2          = 0.0     // 0.1     // 0.3

// Used for ff->ff inhibition:
float FP_FF_PGBAR1              = 0.0
float FP_FF_PGBAR2              = 0.0
float FP_FF_PGBAR3              = 0.0



//
// Extra delay for afferent inputs to feedforward inhibitory cells.
//

float FF_DELAY = 0.005   // hyperparameter

float FP_PIRIFORM_EXTRA_FF_DELAY    = FF_DELAY
float FP_PIRIFORM_EXTRA_FF_FB_DELAY = FF_DELAY


//
// Reversal potentials.
//

float FP_GABA_A_EREV = -0.060 // -0.070
float FP_GABA_B_EREV = -0.090


//
// Shock strengths.
//

float FP_WEAK_SHOCK   = 0.2
float FP_STRONG_SHOCK = 1.0

//
// Location of surface field electrodes.  z = 0 is the location of the somata
// of the piriform cortex network.
//

float FP_SURFACE_FIELD_LOCATION = 500.0e-6

//
// Flag for whether to distribute inhibitory channels over the entire
// apical dendrite or not.
//

int FP_FF_DEND_INHIB_FLAG    = 1
int FP_FF_FB_DEND_INHIB_FLAG = 1


//
// CSD output parameters.
//

int FP_CSD_SYNAPTIC_ONLY = 1


//
// Flag for whether to use random or non-random connections in the
// excitatory associational fibers.
//

int FP_PYR_PYR_NON_RANDOM_CONNECTIONS = 1

