// genesis

//
// piriform_params_conn.g: parameters for the piriform cortex simulation
//     specifically relating to connections.
//     Unless otherwise specified, all units are SI.
//     All "offset" parameters are relative to the origin of the
//     coordinate system.
//
// See piriform_params.g for naming conventions.
//
// NOTE: *Nothing* in this file is scale-dependent in the sense that
//       changing the number of cells in the network will require
//       changes in this file.
//
// NOTE: All "free" parameters have the prefix "FP_".  See the file
//       piriform_free_params.g for their values.  They represent the
//       network parameters that are not strongly constrained by the
//       available data.
//


// ========================================================================
//                    Verbosity and debugging flags.
// ========================================================================

int DEFAULT_DEBUG   =  0
int DEFAULT_VERBOSE = -2

int DUMP_WEIGHTS_DEBUG = 0

int BULB_FF_DEBUG         = {DEFAULT_DEBUG}
int BULB_FF_FB_DEBUG      = {DEFAULT_DEBUG}
int BULB_PYR_DEBUG        = {DEFAULT_DEBUG}
int FB_FB_DEBUG           = {DEFAULT_DEBUG}
int FB_PYR_DEBUG          = {DEFAULT_DEBUG}
int FF_FB_PYR_DEBUG       = {DEFAULT_DEBUG}
int FF_PYR_DEBUG          = {DEFAULT_DEBUG}
int PYR_FB_DEBUG          = {DEFAULT_DEBUG}
int PYR_FF_FB_DEBUG       = {DEFAULT_DEBUG}
int FF_FB_FF_FB_DEBUG     = {DEFAULT_DEBUG}
int PYR_PYR_LOCAL_DEBUG   = {DEFAULT_DEBUG}
int PYR_PYR_VAPC_DEBUG    = {DEFAULT_DEBUG}
int PYR_PYR_DAPC_DEBUG    = {DEFAULT_DEBUG}
int PYR_PYR_PPC_DEBUG     = {DEFAULT_DEBUG}

int BULB_FF_VERBOSE       = {DEFAULT_VERBOSE}
int BULB_FF_FB_VERBOSE    = {DEFAULT_VERBOSE}
int BULB_PYR_VERBOSE      = {DEFAULT_VERBOSE}
int FB_FB_VERBOSE         = {DEFAULT_VERBOSE}
int FB_PYR_VERBOSE        = {DEFAULT_VERBOSE}
int FF_FB_PYR_VERBOSE     = {DEFAULT_VERBOSE}
int FF_PYR_VERBOSE        = {DEFAULT_VERBOSE}
int PYR_FB_VERBOSE        = {DEFAULT_VERBOSE}
int PYR_FF_FB_VERBOSE     = {DEFAULT_VERBOSE}
int FF_FB_FF_FB_VERBOSE   = {DEFAULT_VERBOSE}
int PYR_PYR_LOCAL_VERBOSE = {DEFAULT_VERBOSE}
int PYR_PYR_VAPC_VERBOSE  = {DEFAULT_VERBOSE}
int PYR_PYR_DAPC_VERBOSE  = {DEFAULT_VERBOSE}
int PYR_PYR_PPC_VERBOSE   = {DEFAULT_VERBOSE}


// ========================================================================
//                    Connection extents.
// ========================================================================

float PYR_FB_CONNECTION_X_EXTENT        = {FP_PYR_FB_CONNECTION_EXTENT}
float PYR_FB_CONNECTION_Y_EXTENT        = {FP_PYR_FB_CONNECTION_EXTENT}
float PYR_FB_CONNECTION_Z_EXTENT        = {FP_PYR_FB_CONNECTION_EXTENT}

float FB_PYR_CONNECTION_X_EXTENT        = {FP_FB_PYR_CONNECTION_EXTENT}
float FB_PYR_CONNECTION_Y_EXTENT        = {FP_FB_PYR_CONNECTION_EXTENT}
float FB_PYR_CONNECTION_Z_EXTENT        = {FP_FB_PYR_CONNECTION_EXTENT}

float FF_PYR_CONNECTION_X_EXTENT        = {FP_FF_PYR_CONNECTION_EXTENT}
float FF_PYR_CONNECTION_Y_EXTENT        = {FP_FF_PYR_CONNECTION_EXTENT}
float FF_PYR_CONNECTION_Z_EXTENT        = {FP_FF_PYR_CONNECTION_EXTENT}

float PYR_FF_FB_CONNECTION_X_EXTENT     = {FP_PYR_FF_FB_CONNECTION_EXTENT}
float PYR_FF_FB_CONNECTION_Y_EXTENT     = {FP_PYR_FF_FB_CONNECTION_EXTENT}
float PYR_FF_FB_CONNECTION_Z_EXTENT     = {FP_PYR_FF_FB_CONNECTION_EXTENT}

float FF_FB_PYR_CONNECTION_X_EXTENT     = {FP_FF_FB_PYR_CONNECTION_EXTENT}
float FF_FB_PYR_CONNECTION_Y_EXTENT     = {FP_FF_FB_PYR_CONNECTION_EXTENT}
float FF_FB_PYR_CONNECTION_Z_EXTENT     = {FP_FF_FB_PYR_CONNECTION_EXTENT}

float FF_FB_FF_FB_CONNECTION_X_EXTENT   = {FP_FF_FB_FF_FB_CONNECTION_EXTENT}
float FF_FB_FF_FB_CONNECTION_Y_EXTENT   = {FP_FF_FB_FF_FB_CONNECTION_EXTENT}
float FF_FB_FF_FB_CONNECTION_Z_EXTENT   = {FP_FF_FB_FF_FB_CONNECTION_EXTENT}

float FB_FB_CONNECTION_X_EXTENT         = {FP_FB_FB_CONNECTION_EXTENT}
float FB_FB_CONNECTION_Y_EXTENT         = {FP_FB_FB_CONNECTION_EXTENT}
float FB_FB_CONNECTION_Z_EXTENT         = {FP_FB_FB_CONNECTION_EXTENT}

float PYR_PYR_LOCAL_CONNECTION_X_EXTENT = \
      {FP_PYR_PYR_LOCAL_CONNECTION_EXTENT}
float PYR_PYR_LOCAL_CONNECTION_Y_EXTENT = \
      {FP_PYR_PYR_LOCAL_CONNECTION_EXTENT}
float PYR_PYR_LOCAL_CONNECTION_Z_EXTENT = \
      {FP_PYR_PYR_LOCAL_CONNECTION_EXTENT}

float PYR_PYR_VAPC_CONNECTION_X_HOLE    = {FP_PYR_PYR_LR_VAPC_CONNECTION_HOLE}
float PYR_PYR_VAPC_CONNECTION_Y_HOLE    = {FP_PYR_PYR_LR_VAPC_CONNECTION_HOLE}
float PYR_PYR_VAPC_CONNECTION_HOLE      = {FP_PYR_PYR_LR_VAPC_CONNECTION_HOLE}

float PYR_PYR_DAPC_CONNECTION_X_HOLE    = {FP_PYR_PYR_LR_DAPC_CONNECTION_HOLE}
float PYR_PYR_DAPC_CONNECTION_Y_HOLE    = {FP_PYR_PYR_LR_DAPC_CONNECTION_HOLE}
float PYR_PYR_DAPC_CONNECTION_HOLE      = {FP_PYR_PYR_LR_DAPC_CONNECTION_HOLE}

float PYR_PYR_PPC_CONNECTION_X_HOLE     = {FP_PYR_PYR_LR_PPC_CONNECTION_HOLE}
float PYR_PYR_PPC_CONNECTION_Y_HOLE     = {FP_PYR_PYR_LR_PPC_CONNECTION_HOLE}
float PYR_PYR_PPC_CONNECTION_HOLE       = {FP_PYR_PYR_LR_PPC_CONNECTION_HOLE}

// DELTA is a small nominal value used to prevent cells from
// projecting to themselves.  It should be at most half as large
// as the smallest DX or DY parameter.

float DELTA = 1.0e-5


// ========================================================================
//                 Connection probabilities.
// ========================================================================

// These numbers are scale-dependent.  It's important to note that *real*
// connection probabilities are modeled using the exponential weight
// falloff.  The probability of making a connection *in the simulation*
// is what's set here.  This has to decrease substantially with simulation
// size or else the number of connections will be so large it will use
// up all available memory (and then some).

float BULB_PYR_CONNECTION_PROB
float BULB_FF_CONNECTION_PROB
float BULB_FF_FB_CONNECTION_PROB
float PYR_PYR_LOCAL_CONNECTION_PROB
float PYR_PYR_VAPC_CONNECTION_PROB
float PYR_PYR_DAPC_CONNECTION_PROB
float PYR_PYR_PPC_CONNECTION_PROB
float PYR_FB_CONNECTION_PROB
float FB_PYR_CONNECTION_PROB
float FB_FB_CONNECTION_PROB
float PYR_FF_FB_CONNECTION_PROB
float FF_FB_PYR_CONNECTION_PROB
float FF_FB_FF_FB_CONNECTION_PROB
float FF_PYR_CONNECTION_PROB

BULB_PYR_CONNECTION_PROB      = {FP_BULB_CONNECTION_PROB}
BULB_FF_CONNECTION_PROB       = {FP_BULB_CONNECTION_PROB}
BULB_FF_FB_CONNECTION_PROB    = {FP_BULB_CONNECTION_PROB}
PYR_PYR_LOCAL_CONNECTION_PROB = {FP_PYR_PYR_LOCAL_CONNECTION_PROB}
PYR_PYR_VAPC_CONNECTION_PROB  = {FP_PYR_PYR_LR_CONNECTION_PROB}
PYR_PYR_DAPC_CONNECTION_PROB  = {FP_PYR_PYR_LR_CONNECTION_PROB}
PYR_PYR_PPC_CONNECTION_PROB   = {FP_PYR_PYR_LR_CONNECTION_PROB}
PYR_FB_CONNECTION_PROB        = {FP_INTERNEURON_CONNECTION_PROB}
FB_PYR_CONNECTION_PROB        = {FP_INTERNEURON_CONNECTION_PROB}
FB_FB_CONNECTION_PROB         = {FP_INTERNEURON_CONNECTION_PROB}
PYR_FF_FB_CONNECTION_PROB     = {FP_INTERNEURON_CONNECTION_PROB}
FF_FB_PYR_CONNECTION_PROB     = {FP_INTERNEURON_CONNECTION_PROB}
FF_FB_FF_FB_CONNECTION_PROB   = {FP_INTERNEURON_CONNECTION_PROB}
FF_PYR_CONNECTION_PROB        = {FP_INTERNEURON_CONNECTION_PROB}


// ========================================================================
//            Axonal propagation velocities and delay parameters
// ========================================================================

// ------------------------------------------------------------------------
// 1) Afferent fiber conduction velocities.
//
// LOT conduction velocity taken from opossum
// (Haberly, J.Neurophys. 36:4, 775-788 (1973))
// measured using evoked potential latencies.
//
// Collateral conduction velocity ranges taken from
// Ketchum and Haberly, J. Neurophys. 69:1, 261-281 (1993)
//
// Velocity of main LOT        = 7.0 m/s
// Velocity of LOT collaterals = lognormal distribution,
//                               mode = 0.6 m/sec, median = 0.75 m/sec
// ------------------------------------------------------------------------

float PIRIFORM_AFFERENT_LOT_VELOCITY               = 7.0   // m/sec
float PIRIFORM_AFFERENT_COLLATERAL_VELOCITY_MODE   = 0.8 // 0.6   // m/sec
float PIRIFORM_AFFERENT_COLLATERAL_VELOCITY_MEDIAN = 1.6 // 0.75  // m/sec


// ------------------------------------------------------------------------
// 2) Association fiber conduction velocities.
//    These are lognormally distributed with the indicated modes
//    and medians as parameters.
//
//    These velocities differ for fibers which originate in the ventral
//    anterior piriform cortex (VAPC), the dorsal anterior piriform
//    cortex (DAPC) and the posterior piriform cortex (PPC), at
//    least as far as pyramidal cells are concerned.
//    Reference: Ketchum and Haberly, J. Neurophys. 69:1, 261-281 (1993)
//
//    These are significantly different from the values used by Matt Wilson
//    in his model.  Matt separated the anteriorly-directed and the
//    posteriorly-directed fibers, and set the conduction velocities of the
//    anteriorly-directed fibers at about 0.8 m/sec and the posteriorly-
//    directed fibers at about 0.4 m/sec.  This applied to both local
//    and long-range fibers.
//
//    Postscript: I've tweaked these somewhat because it's very hard to
//    get oscillations at more than 40 Hz with the Haberly values.
// ------------------------------------------------------------------------

float PIRIFORM_ASSOCIATIONAL_VAPC_VELOCITY_MODE   = 0.8   // 0.57  // m/sec
float PIRIFORM_ASSOCIATIONAL_VAPC_VELOCITY_MEDIAN = 1.5   // 0.60
float PIRIFORM_ASSOCIATIONAL_DAPC_VELOCITY_MODE   = 0.8   // 0.31
float PIRIFORM_ASSOCIATIONAL_DAPC_VELOCITY_MEDIAN = 1.5   // 0.33
float PIRIFORM_ASSOCIATIONAL_PPC_VELOCITY_MODE    = 0.8   // 0.57
float PIRIFORM_ASSOCIATIONAL_PPC_VELOCITY_MEDIAN  = 1.5   // 0.63


// ------------------------------------------------------------------------
// 3) Conduction velocities for fibers to/from inhibitory fibers.
//    These are lognormally distributed with the indicated modes
//    and medians as parameters.
//
//    There really isn't any data for these parameters, so I'm assuming
//    that the velocity distribution is uniform and is the same as
//    that of the posterior piriform cortex.  Matt's values for these
//    are about 1.0 m/sec.
// ------------------------------------------------------------------------

float PIRIFORM_INHIB_VELOCITY_MODE   = 0.8  // 0.57  // m/sec
float PIRIFORM_INHIB_VELOCITY_MEDIAN = 1.5  // 0.63

float PIRIFORM_FF_PYR_VELOCITY_MODE         = {PIRIFORM_INHIB_VELOCITY_MODE}
float PIRIFORM_FF_PYR_VELOCITY_MEDIAN       = {PIRIFORM_INHIB_VELOCITY_MEDIAN}
float PIRIFORM_PYR_FB_VELOCITY_MODE         = {PIRIFORM_INHIB_VELOCITY_MODE}
float PIRIFORM_PYR_FB_VELOCITY_MEDIAN       = {PIRIFORM_INHIB_VELOCITY_MEDIAN}
float PIRIFORM_FB_PYR_VELOCITY_MODE         = {PIRIFORM_INHIB_VELOCITY_MODE}
float PIRIFORM_FB_PYR_VELOCITY_MEDIAN       = {PIRIFORM_INHIB_VELOCITY_MEDIAN}
float PIRIFORM_PYR_FF_FB_VELOCITY_MODE      = {PIRIFORM_INHIB_VELOCITY_MODE}
float PIRIFORM_PYR_FF_FB_VELOCITY_MEDIAN    = {PIRIFORM_INHIB_VELOCITY_MEDIAN}
float PIRIFORM_FF_FB_PYR_VELOCITY_MODE      = {PIRIFORM_INHIB_VELOCITY_MODE}
float PIRIFORM_FF_FB_PYR_VELOCITY_MEDIAN    = {PIRIFORM_INHIB_VELOCITY_MEDIAN}
float PIRIFORM_FF_FB_FF_FB_VELOCITY_MODE    = {PIRIFORM_INHIB_VELOCITY_MODE}
float PIRIFORM_FF_FB_FF_FB_VELOCITY_MEDIAN  = {PIRIFORM_INHIB_VELOCITY_MEDIAN}
float PIRIFORM_FB_FB_VELOCITY_MODE          = {PIRIFORM_INHIB_VELOCITY_MODE}
float PIRIFORM_FB_FB_VELOCITY_MEDIAN        = {PIRIFORM_INHIB_VELOCITY_MEDIAN}


// ------------------------------------------------------------------------
// 4) Dendritic delay parameters for feedforward inhibitory interneurons.
//    This is a bit of a hack to compensate for the fact that feedforward
//    inhibitory cells have only one compartment in this model, so all the
//    excitatory input goes right to the soma, causing them to spike earlier
//    than would normally occur (presumably).  To compensate for this we
//    add a fixed delay to the computed afferent delay for the feedforward
//    inhibitory cells.
// ------------------------------------------------------------------------

float PIRIFORM_EXTRA_FF_DELAY    = FP_PIRIFORM_EXTRA_FF_DELAY
float PIRIFORM_EXTRA_FF_FB_DELAY = FP_PIRIFORM_EXTRA_FF_FB_DELAY


// ========================================================================
//                       Weight parameters
// ========================================================================

//
// The `N_XXX_SYNAPSES' parameters are meant to model the total number of
// synaptic connections from a given path that impinge on a single cell.
// The `XXX_SCALE' parameters represent this number scaled to the number
// of synaptic inputs the cell actually gets, which makes it possible to
// set individual weight values so that the total weight will add up to
// the weight you would get from the correct number of synapses.
//

// ------------------------------------------------------------------------
// olfactory bulb mitral cell -> piriform cortex pyramidal cell connections
// ------------------------------------------------------------------------

//
// Number of afferent synapses from mitral cells to pyramidal cells,
// per target cell.
//

// Matt's number is 1200.0 for this parameter:

float PIRIFORM_NAFF_PYR_SYNAPSES = FP_PIRIFORM_NAFF_PYR_SYNAPSES

//
// Distribution factors; this distributes the source pyramidal
// neuron's synapses differentially onto the different compartments
// of the target pyramidal cells.
//
// These values are roughly taken from Ketchum and Haberly
// (J. Neurophys. 69:1, 261-281, fig. 2b).
// CHECKME: was it just an assumption for them?
//

float BULB_PYR_DIA_2    = 0.4
float BULB_PYR_DIA_1    = 0.4
float BULB_PYR_DSUPIB_3 = 0.2

//
// Weight decay rates.
//

float BULB_PYR_DECAY_RATE1  = FP_BULB_PYR_DECAY_RATE1
float BULB_PYR_DECAY_RATE2  = FP_BULB_PYR_DECAY_RATE2

//
// Maximum weight scale values.  These are modified by the distribution
// factors in bulb_pyr_connect.g.
//

float BULB_PYR_MAX_WT   = {PIRIFORM_NAFF_PYR_SYNAPSES}  \
                          / ({BULB_N} * {BULB_PYR_CONNECTION_PROB})
float BULB_PYR_MIN_WT   = {BULB_PYR_MAX_WT / 10.0}
float BULB_PYR_STDEV    = FP_WT_STDEV
float BULB_PYR_MAXDEV   = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// olfactory bulb mitral cell -> feedforward inhibitory cell connections
// ------------------------------------------------------------------------

//
// Number of afferent synapses from mitral cells to ff_inhib cells,
// per target cell.
//

// Matt's ff number / 2 gives 75.0 for this parameter:

float PIRIFORM_NAFF_FF_SYNAPSES = FP_PIRIFORM_NAFF_FF_SYNAPSES

//
// Weight decay rates.
//

float BULB_FF_DECAY_RATE1   = FP_BULB_FF_DECAY_RATE1
float BULB_FF_DECAY_RATE2   = FP_BULB_FF_DECAY_RATE2

//
// Maximum weight scale values.
//

float BULB_FF_MAX_WT        = {PIRIFORM_NAFF_FF_SYNAPSES}  \
                              / ({BULB_N} * {BULB_FF_CONNECTION_PROB})
float BULB_FF_MIN_WT        = {BULB_FF_MAX_WT / 10.0}
float BULB_FF_STDEV         = FP_WT_STDEV
float BULB_FF_MAXDEV        = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// olfactory bulb mitral cell -> feedforward/feedback inhibitory cell
// connections
// ------------------------------------------------------------------------

//
// Number of afferent synapses from mitral cells to ff_fb_inhib cells,
// per target cell.
//

// Matt's ff number / 2 gives 75.0 for this parameter:

float PIRIFORM_NAFF_FF_FB_SYNAPSES = FP_PIRIFORM_NAFF_FF_FB_SYNAPSES

//
// Weight decay rates.
//

float BULB_FF_FB_DECAY_RATE1    = FP_BULB_FF_FB_DECAY_RATE1
float BULB_FF_FB_DECAY_RATE2    = FP_BULB_FF_FB_DECAY_RATE2

//
// Maximum weight scale values.
//

float BULB_FF_FB_MAX_WT         = {PIRIFORM_NAFF_FF_FB_SYNAPSES}  \
                                  / ({BULB_N} * {BULB_FF_FB_CONNECTION_PROB})
float BULB_FF_FB_MIN_WT         = {BULB_FF_FB_MAX_WT / 10.0}
float BULB_FF_FB_STDEV          = FP_WT_STDEV
float BULB_FF_FB_MAXDEV         = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// local pyramidal cell -> pyramidal cell connections
// ------------------------------------------------------------------------

//
// Number of local excitatory synapses from pyramidal cells to other
// pyramidal cells, per target cell.
//
// The density of local excitatory synaptic contacts between pyramidal
// cells varies as a function of the location of the pyramidal cells.
// Cells in the posterior piriform cortex (PPC) have dense local
// excitatory connections, cells in the dorsal anterior piriform
// cortex (dAPC) have weaker local excitatory connections, and cells
// in the ventral anterior piriform cortex (vAPC) have very weak or
// absent local excitatory connections.
//
// References:  L. Haberly, Synaptic Organization of the Brain, ch. 10
//                          (4th ed. 1998)
//              Luskin and Price (1983) J. Comp. Neurol. 216:264-291
//

float PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES = \
      FP_PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES
float PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES = \
      FP_PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES
float PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES  = \
      FP_PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES

//
// Weight decay rate; Matt's number is 5.0 mm.  This applies to the
//     other weight decay rates as well.
//
// From Matt's model:
// deep collaterals in rat
// - Haberly and Presto (1986), J. Comp. Neur., 248, 464-474
// local axon collaterals remain in layer III for 1-2 mm
//

float PYR_PYR_LOCAL_DECAY_RATE = FP_PYR_PYR_LOCAL_DECAY_RATE

//
// Maximum weight scale values.
//
// For accuracy, we calculate the scale value for each basal
// dendritic compartment separately, which is quite tedious.
//

//
// Distribution factors; this distributes the source pyramidal
// neuron's synapses differentially onto the different compartments
// of the target pyramidal cells.
//
// We assume, in the absence of any data, that local connections are
// distributed evenly along the pyramidal cell basal dendrite for
// all three source regions.
//

float PYR_PYR_LOCAL_DBASAL_1 = 0.166666
float PYR_PYR_LOCAL_DBASAL_2 = 0.166666
float PYR_PYR_LOCAL_DBASAL_3 = 0.166666
float PYR_PYR_LOCAL_DBASAL_4 = 0.166666
float PYR_PYR_LOCAL_DBASAL_5 = 0.166666
float PYR_PYR_LOCAL_DBASAL_6 = 0.166666


//
// Anterior/posterior scaling factors: these are weight multipliers
// which depend on which direction the connections are going (anterior
// to posterior or vice-versa).
//

float PYR_PYR_LOCAL_AP_SCALE = FP_PYR_PYR_LOCAL_AP_SCALE
float PYR_PYR_LOCAL_PA_SCALE = FP_PYR_PYR_LOCAL_PA_SCALE


function calc_pyr_pyr_local_max_wt(compt_z, nsynapses, dist_factor)
    float compt_z, nsynapses
    float scale
    float dist_factor

    scale = {piriform_calc_exp_max_weight                               \
          -target_location                                              \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} {compt_z}             \
          -source_elements                                              \
          /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen           \
          -source_relative                                              \
          -sourcemask ellipsoid 0.0 0.0 0.0                             \
              {PYR_PYR_LOCAL_CONNECTION_X_EXTENT}                       \
              {PYR_PYR_LOCAL_CONNECTION_Y_EXTENT}                       \
              {PYR_PYR_LOCAL_CONNECTION_Z_EXTENT}                       \
          -nsynapses    {nsynapses * dist_factor}                       \
          -probability  {PYR_PYR_LOCAL_CONNECTION_PROB}                 \
          -decay_rate   {PYR_PYR_LOCAL_DECAY_RATE}                      \
          -min_wt       0.0                                             \
          -debug {DEFAULT_DEBUG}}

    return scale
end

// Maximum weight scale values for the ventral anterior piriform cortex.

float PYR_PYR_LOCAL_BASAL_1_VAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_1_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_1}}

float PYR_PYR_LOCAL_BASAL_2_VAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_2_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_2}}

float PYR_PYR_LOCAL_BASAL_3_VAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_3_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_3}}

float PYR_PYR_LOCAL_BASAL_4_VAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_4_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_4}}

float PYR_PYR_LOCAL_BASAL_5_VAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_5_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_5}}

float PYR_PYR_LOCAL_BASAL_6_VAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_6_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_VAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_6}}

// Maximum weight scale values for the dorsal anterior piriform cortex.

float PYR_PYR_LOCAL_BASAL_1_DAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_1_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_1}}

float PYR_PYR_LOCAL_BASAL_2_DAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_2_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_2}}

float PYR_PYR_LOCAL_BASAL_3_DAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_3_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_3}}

float PYR_PYR_LOCAL_BASAL_4_DAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_4_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_4}}

float PYR_PYR_LOCAL_BASAL_5_DAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_5_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_5}}

float PYR_PYR_LOCAL_BASAL_6_DAPC_MAX_WT =                   \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_6_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_DAPC_SYNAPSES}            \
         {PYR_PYR_LOCAL_DBASAL_6}}

// Maximum weight scale values for the posterior piriform cortex.

float PYR_PYR_LOCAL_BASAL_1_PPC_MAX_WT =                    \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_1_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES}             \
         {PYR_PYR_LOCAL_DBASAL_1}}

float PYR_PYR_LOCAL_BASAL_2_PPC_MAX_WT =                    \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_2_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES}             \
         {PYR_PYR_LOCAL_DBASAL_2}}

float PYR_PYR_LOCAL_BASAL_3_PPC_MAX_WT =                    \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_3_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES}             \
         {PYR_PYR_LOCAL_DBASAL_3}}

float PYR_PYR_LOCAL_BASAL_4_PPC_MAX_WT =                    \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_4_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES}             \
         {PYR_PYR_LOCAL_DBASAL_4}}

float PYR_PYR_LOCAL_BASAL_5_PPC_MAX_WT =                    \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_5_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES}             \
         {PYR_PYR_LOCAL_DBASAL_5}}

float PYR_PYR_LOCAL_BASAL_6_PPC_MAX_WT =                    \
     {calc_pyr_pyr_local_max_wt {PYRAMIDAL_BASAL_6_Z}       \
         {PIRIFORM_NPYR_PYR_LOCAL_PPC_SYNAPSES}             \
         {PYR_PYR_LOCAL_DBASAL_6}}

// N.B. Matt sets the minimum weight at (max wt * 0.2), but there's no need
// for that; the exponential decay doesn't go beyond two space constants,
// which is about 0.13 of the maximum weight anyway.

float PYR_PYR_LOCAL_MIN_WT = 0.0
float PYR_PYR_LOCAL_STDEV  = FP_WT_STDEV
float PYR_PYR_LOCAL_MAXDEV = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// long-range pyramidal cell -> pyramidal cell connections
// originating in the ventral anterior piriform cortex (vAPC).
// ------------------------------------------------------------------------

//
// Number of excitatory synapses from vAPC pyramidal cells to other
// pyramidal cells per target cell.  I have no data on synapse counts
// but Haberly (SOB 4th ed.) implies that the projection from the vAPC
// covers the entire piriform cortex.
//

float PIRIFORM_NPYR_PYR_VAPC_SYNAPSES = FP_PIRIFORM_NPYR_PYR_VAPC_SYNAPSES

//
// Distribution factors; this distributes the source pyramidal
// neuron's synapses differentially onto the different compartments
// of the target pyramidal cells.
//
// These values are roughly taken from Ketchum and Haberly
// (J. Neurophys. 69:1, 261-281, fig. 2b).
//

float PYR_PYR_VAPC_DSUPIB_3  = 0.35
float PYR_PYR_VAPC_DSUPIB_2  = 0.40
float PYR_PYR_VAPC_DSUPIB_1  = 0.15
float PYR_PYR_VAPC_DDEEPIB_3 = 0.10


//
// Anterior/posterior scaling factors: these are weight multipliers
// which depend on which direction the connections are going (anterior
// to posterior or vice-versa).
//

float PYR_PYR_VAPC_AP_SCALE = FP_PYR_PYR_VAPC_AP_SCALE
float PYR_PYR_VAPC_PA_SCALE = FP_PYR_PYR_VAPC_PA_SCALE


//
// Weight decay rate.
// Matt used 1/(5mm) but his network was larger than mine.
//

float PYR_PYR_VAPC_DECAY_RATE = FP_PYR_PYR_VAPC_DECAY_RATE

//
// Maximum weight scale values.
//

function calc_pyr_pyr_vapc_max_wt(compt_z, nsynapses, dist_factor)
    float compt_z, nsynapses
    float scale
    float dist_factor

    //
    // NOTE: the -sourcehole arguments here represent the part of the
    //       ventral anterior piriform cortex that can't project to the
    //       particular location in question because of the -desthole
    //       argument to piriform_volume_connect when the connections
    //       were set up.
    //

    scale = {piriform_calc_exp_max_weight                               \
          -target_location                                              \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} {compt_z}             \
          -source_elements                                              \
          /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen           \
          -sourcemask xy_ellipse 0.0 0.0 any                            \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} any                   \
          -sourcehole xy_ellipse                                        \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} any                   \
          {PYR_PYR_VAPC_CONNECTION_X_HOLE}                              \
          {PYR_PYR_VAPC_CONNECTION_Y_HOLE}                              \
          any                                                           \
          -nsynapses    {nsynapses * dist_factor}                       \
          -probability  {PYR_PYR_VAPC_CONNECTION_PROB}                  \
          -decay_rate   {PYR_PYR_VAPC_DECAY_RATE}                       \
          -min_wt       0.0                                             \
          -debug {DEFAULT_DEBUG}}

    return scale
end

// Maximum weight scale values for the ventral anterior piriform cortex.

float PYR_PYR_VAPC_SUPIB_3_MAX_WT   =  \
     {calc_pyr_pyr_vapc_max_wt {PYRAMIDAL_SUPIB_3_Z}    \
         {PIRIFORM_NPYR_PYR_VAPC_SYNAPSES} {PYR_PYR_VAPC_DSUPIB_3}}

float PYR_PYR_VAPC_SUPIB_2_MAX_WT   =  \
     {calc_pyr_pyr_vapc_max_wt {PYRAMIDAL_SUPIB_2_Z}    \
         {PIRIFORM_NPYR_PYR_VAPC_SYNAPSES} {PYR_PYR_VAPC_DSUPIB_2}}

float PYR_PYR_VAPC_SUPIB_1_MAX_WT   =  \
     {calc_pyr_pyr_vapc_max_wt {PYRAMIDAL_SUPIB_1_Z}    \
         {PIRIFORM_NPYR_PYR_VAPC_SYNAPSES} {PYR_PYR_VAPC_DSUPIB_1}}

float PYR_PYR_VAPC_DEEPIB_3_MAX_WT  =  \
     {calc_pyr_pyr_vapc_max_wt {PYRAMIDAL_DEEPIB_3_Z}   \
         {PIRIFORM_NPYR_PYR_VAPC_SYNAPSES} {PYR_PYR_VAPC_DDEEPIB_3}}

float PYR_PYR_VAPC_MIN_WT   = 0.0
float PYR_PYR_VAPC_STDEV    = FP_WT_STDEV
float PYR_PYR_VAPC_MAXDEV   = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// long-range pyramidal cell -> pyramidal cell connections
// originating in the dorsal anterior piriform cortex (dAPC).
// ------------------------------------------------------------------------

//
// Number of excitatory synapses from dAPC pyramidal cells to other
// pyramidal cells per target cell.  I have no data on synapse counts
// but Haberly (SOB 4th ed.) implies that the projection from the dAPC
// covers the entire piriform cortex.
//

float PIRIFORM_NPYR_PYR_DAPC_SYNAPSES = FP_PIRIFORM_NPYR_PYR_DAPC_SYNAPSES

//
// Distribution factors; this distributes the source pyramidal
// neuron's synapses differentially onto the different compartments
// of the target pyramidal cells.
//
// These values are roughly taken from Ketchum and Haberly
// (J. Neurophys. 69:1, 261-281, fig. 2b).
//

float PYR_PYR_DAPC_DSUPIB_1  = 0.10
float PYR_PYR_DAPC_DDEEPIB_3 = 0.30
float PYR_PYR_DAPC_DDEEPIB_2 = 0.30
float PYR_PYR_DAPC_DDEEPIB_1 = 0.30


//
// Anterior/posterior scaling factors: these are weight multipliers
// which depend on which direction the connections are going (anterior
// to posterior or vice-versa).
//

float PYR_PYR_DAPC_AP_SCALE = FP_PYR_PYR_DAPC_AP_SCALE
float PYR_PYR_DAPC_PA_SCALE = FP_PYR_PYR_DAPC_PA_SCALE


//
// Weight decay rate.
// Matt used 1/(5mm) but his network was larger than mine.
//

float PYR_PYR_DAPC_DECAY_RATE = FP_PYR_PYR_DAPC_DECAY_RATE

//
// Maximum weight scale values.
//

function calc_pyr_pyr_dapc_max_wt(compt_z, nsynapses, dist_factor)
    float compt_z, nsynapses
    float scale
    float dist_factor

    //
    // NOTE: we use TWO -sourcehole arguments here:
    // 1) one represents the ventral anterior piriform cortex,
    //    which does not project to the same synapses as the dorsal
    //    anterior piriform cortex;
    // 2) one represents the part of the dorsal anterior piriform cortex
    //    that can't project to the particular location in question
    //    because of the -desthole argument to piriform_volume_connect
    //    when the connections were set up.
    //

    scale = {piriform_calc_exp_max_weight                               \
          -target_location                                              \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} {compt_z}             \
          -source_elements                                              \
          /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen           \
          -sourcemask xy_box                                            \
          0.0 0.0 any                                                   \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_EXTENT} any                   \
          -sourcehole xy_ellipse 0.0 0.0 any                            \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} any                   \
          -sourcehole xy_ellipse                                        \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} any                   \
          {PYR_PYR_DAPC_CONNECTION_X_HOLE}                              \
          {PYR_PYR_DAPC_CONNECTION_Y_HOLE}                              \
          any                                                           \
          -nsynapses    {nsynapses * dist_factor}                       \
          -probability  {PYR_PYR_DAPC_CONNECTION_PROB}                  \
          -decay_rate   {PYR_PYR_DAPC_DECAY_RATE}                       \
          -min_wt       0.0                                             \
          -debug {DEFAULT_DEBUG}}

    return scale
end

// Maximum weight scale values for the dorsal anterior piriform cortex.

float PYR_PYR_DAPC_SUPIB_1_MAX_WT   =  \
     {calc_pyr_pyr_dapc_max_wt {PYRAMIDAL_SUPIB_1_Z}    \
         {PIRIFORM_NPYR_PYR_DAPC_SYNAPSES} {PYR_PYR_DAPC_DSUPIB_1}}

float PYR_PYR_DAPC_DEEPIB_3_MAX_WT  =  \
     {calc_pyr_pyr_dapc_max_wt {PYRAMIDAL_DEEPIB_3_Z}   \
         {PIRIFORM_NPYR_PYR_DAPC_SYNAPSES} {PYR_PYR_DAPC_DDEEPIB_3}}

float PYR_PYR_DAPC_DEEPIB_2_MAX_WT  =  \
     {calc_pyr_pyr_dapc_max_wt {PYRAMIDAL_DEEPIB_2_Z}   \
         {PIRIFORM_NPYR_PYR_DAPC_SYNAPSES} {PYR_PYR_DAPC_DDEEPIB_2}}

float PYR_PYR_DAPC_DEEPIB_1_MAX_WT  =  \
     {calc_pyr_pyr_dapc_max_wt {PYRAMIDAL_DEEPIB_1_Z}   \
         {PIRIFORM_NPYR_PYR_DAPC_SYNAPSES} {PYR_PYR_DAPC_DDEEPIB_1}}

float PYR_PYR_DAPC_MIN_WT   = 0.0
float PYR_PYR_DAPC_STDEV    = FP_WT_STDEV
float PYR_PYR_DAPC_MAXDEV   = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// long-range pyramidal cell -> pyramidal cell connections
// originating in the posterior piriform cortex (PPC).
// ------------------------------------------------------------------------

//
// Number of excitatory synapses from PPC pyramidal cells to other
// pyramidal cells per target cell.  I have no data on synapse counts
// but Haberly (SOB 4th ed.) implies that the projection from the PPC
// covers the entire piriform cortex, although the projection is weaker
// than that from the dAPC.
//

float PIRIFORM_NPYR_PYR_PPC_SYNAPSES = FP_PIRIFORM_NPYR_PYR_PPC_SYNAPSES

//
// Distribution factors; this distributes the source pyramidal
// neuron's synapses differentially onto the different compartments
// of the target pyramidal cells.
//
// These values are roughly taken from Ketchum and Haberly
// (J. Neurophys. 69:1, 261-281, fig. 2b).
//

float PYR_PYR_PPC_DSUPIB_1  = 0.10
float PYR_PYR_PPC_DDEEPIB_3 = 0.30
float PYR_PYR_PPC_DDEEPIB_2 = 0.30
float PYR_PYR_PPC_DDEEPIB_1 = 0.30


//
// Anterior/posterior scaling factors: these are weight multipliers
// which depend on which direction the connections are going (anterior
// to posterior or vice-versa).
//

float PYR_PYR_PPC_AP_SCALE = FP_PYR_PYR_PPC_AP_SCALE
float PYR_PYR_PPC_PA_SCALE = FP_PYR_PYR_PPC_PA_SCALE


//
// Weight decay rate.
// Matt used 1/(5mm) but his network area was larger than mine.
//

float PYR_PYR_PPC_DECAY_RATE = FP_PYR_PYR_PPC_DECAY_RATE

//
// Maximum weight scale values.
//

function calc_pyr_pyr_ppc_max_wt(compt_z, nsynapses, dist_factor)
    float compt_z, nsynapses
    float scale
    float dist_factor

    //
    // NOTE: the -sourcehole argument here represents the part of the
    //       posterior piriform cortex that can't project to the particular
    //       location in question because of the -desthole argument to
    //       piriform_volume_connect when the connections were set up.
    //

    scale = {piriform_calc_exp_max_weight                               \
          -target_location                                              \
          {PIRIFORM_PYRAMIDAL_X_MIDDLE}                                 \
          {PIRIFORM_PYRAMIDAL_Y_MIDDLE}                                 \
          {compt_z}                                                     \
          -source_elements                                              \
          /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen           \
          -sourcemask xy_box                                            \
          {PIRIFORM_X_CENTER} 0.0 any                                   \
          {PIRIFORM_X_EXTENT} {PIRIFORM_Y_EXTENT} any                   \
          -sourcehole xy_ellipse                                        \
          {PIRIFORM_X_CENTER} {PIRIFORM_Y_CENTER} any                   \
          {PYR_PYR_PPC_CONNECTION_X_HOLE}                               \
          {PYR_PYR_PPC_CONNECTION_Y_HOLE}                               \
          any                                                           \
          -nsynapses    {nsynapses * dist_factor}                       \
          -probability  {PYR_PYR_PPC_CONNECTION_PROB}                   \
          -decay_rate   {PYR_PYR_PPC_DECAY_RATE}                        \
          -min_wt       0.0                                             \
          -debug {DEFAULT_DEBUG}}

    return scale
end

// Maximum weight scale values for the posterior piriform cortex.

float PYR_PYR_PPC_SUPIB_1_MAX_WT   =  \
     {calc_pyr_pyr_ppc_max_wt {PYRAMIDAL_SUPIB_1_Z}    \
         {PIRIFORM_NPYR_PYR_PPC_SYNAPSES} {PYR_PYR_PPC_DSUPIB_1}}

float PYR_PYR_PPC_DEEPIB_3_MAX_WT  =  \
     {calc_pyr_pyr_ppc_max_wt {PYRAMIDAL_DEEPIB_3_Z}   \
         {PIRIFORM_NPYR_PYR_PPC_SYNAPSES} {PYR_PYR_PPC_DDEEPIB_3}}

float PYR_PYR_PPC_DEEPIB_2_MAX_WT  =  \
     {calc_pyr_pyr_ppc_max_wt {PYRAMIDAL_DEEPIB_2_Z}   \
         {PIRIFORM_NPYR_PYR_PPC_SYNAPSES} {PYR_PYR_PPC_DDEEPIB_2}}

float PYR_PYR_PPC_DEEPIB_1_MAX_WT  =  \
     {calc_pyr_pyr_ppc_max_wt {PYRAMIDAL_DEEPIB_1_Z}   \
         {PIRIFORM_NPYR_PYR_PPC_SYNAPSES} {PYR_PYR_PPC_DDEEPIB_1}}

float PYR_PYR_PPC_MIN_WT   = 0.0
float PYR_PYR_PPC_STDEV    = FP_WT_STDEV
float PYR_PYR_PPC_MAXDEV   = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// pyramidal cell -> feedback inhibitory cell connections
// ------------------------------------------------------------------------

//
// Number of synapses from pyramidal cells per fb interneuron.
//
// NOTE: we use floats for numbers of synapses so we can divide them
//       up using distribution factors (see below).
//
// Matt uses 800 synapses/cell and it seems to jibe with Golgi images in
// Haberly J. Comp. Neurol. 213:163-187 if we assume that the number
// of synapses onto a smooth multipolar cell is roughly the same
// as the number of spines on a spiny multipolar cell.
// However, with one-compartment feedback inhibitory cells, this
// saturates the inputs on a shock stimulus, which I believe is
// unphysiological (of course, shock stimuli aren't physiological)
// Thus, I use a lower value which gives bursts but no saturation
// with strong shock inputs.
//
// CHECKME: play with this value with weak shocks and background inputs.
//

float PIRIFORM_NPYR_FB_SYNAPSES = FP_PIRIFORM_NPYR_FB_SYNAPSES

//
// Weight decay rate; see above comments.
//

float PYR_FB_DECAY_RATE = FP_PYR_FB_DECAY_RATE

//
// Maximum weight scale value.
//

float PYR_FB_MAX_WT =  \
      {piriform_calc_exp_max_weight                                 \
          -target_location                                          \
          {PIRIFORM_FB_INHIB_X_MIDDLE}                              \
          {PIRIFORM_FB_INHIB_Y_MIDDLE}                              \
          {FB_Z}                                                    \
          -source_elements                                          \
          /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen       \
          -source_relative                                          \
          -sourcemask ellipsoid 0.0 0.0 0.0                         \
              {PYR_FB_CONNECTION_X_EXTENT}                          \
              {PYR_FB_CONNECTION_Y_EXTENT}                          \
              {PYR_FB_CONNECTION_Z_EXTENT}                          \
          -nsynapses    {PIRIFORM_NPYR_FB_SYNAPSES}                 \
          -probability  {PYR_FB_CONNECTION_PROB}                    \
          -decay_rate   {PYR_FB_DECAY_RATE}                         \
          -min_wt 0.0 -debug {DEFAULT_DEBUG}}

float PYR_FB_MIN_WT = 0.0
float PYR_FB_STDEV  = FP_WT_STDEV
float PYR_FB_MAXDEV = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// feedback inhibitory cell -> pyramidal cell connections
// ------------------------------------------------------------------------

//
// Number of synapses from fb interneurons per pyramidal cell.
//

// Matt's number is 100.0 for this parameter:

float PIRIFORM_NFB_PYR_SYNAPSES = FP_PIRIFORM_NFB_PYR_SYNAPSES

//
// Distribution factors; this distributes the feedback inhibitory
// neuron's synapses differentially onto the different compartments
// of the pyramidal cells.
//
// These values are roughly taken from Ketchum and Haberly
// (J. Neurophys. 69:1, 261-281, fig. 2c).
//

float FB_PYR_DSOMA    = 0.5 // 0.7
float FB_PYR_DBASAL_1 = 0.2 // 0.15
float FB_PYR_DBASAL_2 = 0.2 // 0.1
float FB_PYR_DBASAL_3 = 0.1 // 0.05

//
// Weight decay rate; see above comments.
//

float FB_PYR_DECAY_RATE = FP_FB_PYR_DECAY_RATE

//
// Maximum weight scale values.
//

function calc_fb_pyr_max_wt(compt_z, dist_factor)
    float compt_z, dist_factor

    return {piriform_calc_exp_max_weight                                \
          -target_location                                              \
          {PIRIFORM_PYRAMIDAL_X_MIDDLE}                                 \
          {PIRIFORM_PYRAMIDAL_Y_MIDDLE}                                 \
          {compt_z}                                                     \
          -source_elements                                              \
          /piriform_cortex/fb_inhib_cell[]/soma/fb_spikegen             \
          -source_relative                                              \
          -sourcemask ellipsoid 0.0 0.0 0.0                             \
              {FB_PYR_CONNECTION_X_EXTENT}                              \
              {FB_PYR_CONNECTION_Y_EXTENT}                              \
              {FB_PYR_CONNECTION_Z_EXTENT}                              \
          -nsynapses    {PIRIFORM_NFB_PYR_SYNAPSES * dist_factor}       \
          -probability  {FB_PYR_CONNECTION_PROB}                        \
          -decay_rate   {FB_PYR_DECAY_RATE}                             \
          -min_wt 0.0 -debug {DEFAULT_DEBUG}}
end

float FB_PYR_MAX_WT_SOMA    =  \
    {calc_fb_pyr_max_wt {PYRAMIDAL_SOMA_Z} {FB_PYR_DSOMA}}

float FB_PYR_MAX_WT_BASAL_1 =  \
    {calc_fb_pyr_max_wt {PYRAMIDAL_BASAL_1_Z} {FB_PYR_DBASAL_1}}

float FB_PYR_MAX_WT_BASAL_2 =  \
    {calc_fb_pyr_max_wt {PYRAMIDAL_BASAL_2_Z} {FB_PYR_DBASAL_2}}

float FB_PYR_MAX_WT_BASAL_3 =  \
    {calc_fb_pyr_max_wt {PYRAMIDAL_BASAL_3_Z} {FB_PYR_DBASAL_3}}

float FB_PYR_MIN_WT = 0.0
float FB_PYR_STDEV  = FP_WT_STDEV
float FB_PYR_MAXDEV = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// feedback inhibitory cell -> feedback inhibitory cell connections
// ------------------------------------------------------------------------

// NOTE: Matt didn't have this connection type in his model.

//
// Number of synapses from fb interneurons per fb inhibitory interneuron.
//

float PIRIFORM_NFB_FB_SYNAPSES = FP_PIRIFORM_NFB_FB_SYNAPSES

//
// Weight decay rate; see above comments.
//

float FB_FB_DECAY_RATE = FP_FB_FB_DECAY_RATE

//
// Maximum weight scale values.
//

float FB_FB_MAX_WT  =  \
      {piriform_calc_exp_max_weight                             \
          -target_location                                      \
          {PIRIFORM_FB_INHIB_X_MIDDLE}                          \
          {PIRIFORM_FB_INHIB_Y_MIDDLE}                          \
          {FB_Z}                                                \
          -source_elements                                      \
          /piriform_cortex/fb_inhib_cell[]/soma/fb_spikegen     \
          -source_relative                                      \
          -sourcemask ellipsoid 0.0 0.0 0.0                     \
              {FB_FB_CONNECTION_X_EXTENT}                       \
              {FB_FB_CONNECTION_Y_EXTENT}                       \
              {FB_FB_CONNECTION_Z_EXTENT}                       \
          -sourcehole ellipsoid 0.0 0.0 0.0                     \
              {DELTA} {DELTA} {DELTA}                           \
          -nsynapses    {PIRIFORM_NFB_FB_SYNAPSES}              \
          -probability  {FB_FB_CONNECTION_PROB}                 \
          -decay_rate   {FB_FB_DECAY_RATE}                      \
          -min_wt 0.0 -debug {DEFAULT_DEBUG}}

float FB_FB_MIN_WT  = 0.0
float FB_FB_STDEV   = FP_WT_STDEV
float FB_FB_MAXDEV  = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// pyramidal cell -> feedforward/feedback inhibitory cell connections
// ------------------------------------------------------------------------

//
// Number of synapses from pyramidal cells per ff/fb interneuron.
//

//
// NOTE: In Matt's model, *all* ff cells received feedback projections from
//       pyramidal cells.  I've split them into two groups: the "ff" cells
//       don't get feedback projections while the "ff/fb" cells do.  The
//       parameters below are adapted from Matt's ff parameters.
//

// Matt's number is effectively 200.0 for this parameter;
// he actually connected pyramidal cells with FF interneurons
// since he didn't have FF_FB interneurons.

float PIRIFORM_NPYR_FF_FB_SYNAPSES = FP_PIRIFORM_NPYR_FF_FB_SYNAPSES

//
// Weight decay rate; see above comments.
//

float PYR_FF_FB_DECAY_RATE = FP_PYR_FF_FB_DECAY_RATE

//
// Maximum weight scale value.
//

float PYR_FF_FB_MAX_WT =  \
      {piriform_calc_exp_max_weight                             \
          -target_location                                      \
          {PIRIFORM_FF_FB_INHIB_X_MIDDLE}                       \
          {PIRIFORM_FF_FB_INHIB_Y_MIDDLE}                       \
          {FF_FB_Z}                                             \
          -source_elements                                      \
          /piriform_cortex/pyramidal_cell[]/soma/pyr_spikegen   \
          -source_relative                                      \
          -sourcemask ellipsoid 0.0 0.0 0.0                     \
              {PYR_FF_FB_CONNECTION_X_EXTENT}                   \
              {PYR_FF_FB_CONNECTION_Y_EXTENT}                   \
              {PYR_FF_FB_CONNECTION_Z_EXTENT}                   \
          -nsynapses    {PIRIFORM_NPYR_FF_FB_SYNAPSES}          \
          -probability  {PYR_FF_FB_CONNECTION_PROB}             \
          -decay_rate   {PYR_FF_FB_DECAY_RATE}                  \
          -min_wt 0.0 -debug {DEFAULT_DEBUG}}

float PYR_FF_FB_MIN_WT = 0.0
float PYR_FF_FB_STDEV  = FP_WT_STDEV
float PYR_FF_FB_MAXDEV = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// feedforward/feedback inhibitory cell -> pyramidal cell connections
// ------------------------------------------------------------------------

//
// Number of synapses from ff/fb interneurons per pyramidal cell.
//

// The Kapur/Lytton/Haberly model gives a value of 75.0
// for this parameter:

float PIRIFORM_NFF_FB_PYR_SYNAPSES = FP_PIRIFORM_NFF_FB_PYR_SYNAPSES

//
// Distribution factors; this distributes the feedforward/feedback
// inhibitory neuron's synapses differentially onto the different
// compartments of the pyramidal cells.
//
// These values are roughly taken from Ketchum and Haberly
// (J. Neurophys. 69:1, 261-281, fig. 2c).
//

if (FP_FF_FB_DEND_INHIB_FLAG)
    float FF_FB_PYR_DIA_2     = 0.150  // 0.0
    float FF_FB_PYR_DIA_1     = 0.150  // 0.0
    float FF_FB_PYR_DSUPIB_3  = 0.150  // 0.0
    float FF_FB_PYR_DSUPIB_2  = 0.150  // 0.333333
    float FF_FB_PYR_DSUPIB_1  = 0.150  // 0.333333
    float FF_FB_PYR_DDEEPIB_3 = 0.150  // 0.333333
    float FF_FB_PYR_DDEEPIB_2 = 0.100  // 0.0
    float FF_FB_PYR_DDEEPIB_1 = 0.000  // 0.0
else
    float FF_FB_PYR_DSUPIB_2  = 0.333333
    float FF_FB_PYR_DSUPIB_1  = 0.333333
    float FF_FB_PYR_DDEEPIB_3 = 0.333333
end


//
// Weight decay rate; see above comments.
//

float FF_FB_PYR_DECAY_RATE = FP_FF_FB_PYR_DECAY_RATE

//
// Maximum weight scale values.
//

function calc_ff_fb_pyr_max_wt(compt_z, dist_factor)
    float compt_z, dist_factor

    return {piriform_calc_exp_max_weight                                \
          -target_location                                              \
          {PIRIFORM_PYRAMIDAL_X_MIDDLE}                                 \
          {PIRIFORM_PYRAMIDAL_Y_MIDDLE}                                 \
          {compt_z}                                                     \
          -source_elements                                              \
          /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_fb_spikegen       \
          -source_relative                                              \
          -sourcemask ellipsoid 0.0 0.0 0.0                             \
              {FF_FB_PYR_CONNECTION_X_EXTENT}                           \
              {FF_FB_PYR_CONNECTION_Y_EXTENT}                           \
              {FF_FB_PYR_CONNECTION_Z_EXTENT}                           \
          -nsynapses    {PIRIFORM_NFF_FB_PYR_SYNAPSES * dist_factor}    \
          -probability  {FF_FB_PYR_CONNECTION_PROB}                     \
          -decay_rate   {FF_FB_PYR_DECAY_RATE}                          \
          -min_wt 0.0 -debug {DEFAULT_DEBUG}}
end


if (FP_FF_FB_DEND_INHIB_FLAG)
    float FF_FB_PYR_MAX_WT_IA_2  =  \
        {calc_ff_fb_pyr_max_wt {PYRAMIDAL_IA_2_Z} {FF_FB_PYR_DIA_2}}

    float FF_FB_PYR_MAX_WT_IA_1  =  \
        {calc_ff_fb_pyr_max_wt {PYRAMIDAL_IA_1_Z} {FF_FB_PYR_DIA_1}}

    float FF_FB_PYR_MAX_WT_SUPIB_3  =  \
        {calc_ff_fb_pyr_max_wt {PYRAMIDAL_SUPIB_3_Z} {FF_FB_PYR_DSUPIB_3}}
end


float FF_FB_PYR_MAX_WT_SUPIB_2  =  \
    {calc_ff_fb_pyr_max_wt {PYRAMIDAL_SUPIB_2_Z} {FF_FB_PYR_DSUPIB_2}}

float FF_FB_PYR_MAX_WT_SUPIB_1  =  \
    {calc_ff_fb_pyr_max_wt {PYRAMIDAL_SUPIB_1_Z} {FF_FB_PYR_DSUPIB_1}}

float FF_FB_PYR_MAX_WT_DEEPIB_3 =  \
    {calc_ff_fb_pyr_max_wt {PYRAMIDAL_DEEPIB_3_Z} {FF_FB_PYR_DDEEPIB_3}}

if (FP_FF_FB_DEND_INHIB_FLAG)
    float FF_FB_PYR_MAX_WT_DEEPIB_2 =  \
        {calc_ff_fb_pyr_max_wt {PYRAMIDAL_DEEPIB_2_Z} {FF_FB_PYR_DDEEPIB_2}}

    float FF_FB_PYR_MAX_WT_DEEPIB_1 =  \
        {calc_ff_fb_pyr_max_wt {PYRAMIDAL_DEEPIB_1_Z} {FF_FB_PYR_DDEEPIB_1}}
end


float FF_FB_PYR_MIN_WT = 0.0
float FF_FB_PYR_STDEV  = FP_WT_STDEV
float FF_FB_PYR_MAXDEV = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// feedforward/feedback inhibitory cell ->
//     feedforward/feedback inhibitory cell connections
// ------------------------------------------------------------------------

// NOTE: Matt didn't have this connection type in his model.

//
// Number of synapses from ff/fb interneurons per
//     ff/fb inhibitory interneuron.
//

float PIRIFORM_NFF_FB_FF_FB_SYNAPSES = FP_PIRIFORM_NFF_FB_FF_FB_SYNAPSES

//
// Weight decay rate; see above comments.
//

float FF_FB_FF_FB_DECAY_RATE = FP_FF_FB_FF_FB_DECAY_RATE

//
// Maximum weight scale values.
//

float FF_FB_FF_FB_MAX_WT  =  \
      {piriform_calc_exp_max_weight                                 \
          -target_location                                          \
          {PIRIFORM_FF_FB_INHIB_X_MIDDLE}                           \
          {PIRIFORM_FF_FB_INHIB_Y_MIDDLE}                           \
          {FF_FB_Z}                                                 \
          -source_elements                                          \
          /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_fb_spikegen   \
          -source_relative                                          \
          -sourcemask ellipsoid 0.0 0.0 0.0                         \
              {FF_FB_FF_FB_CONNECTION_X_EXTENT}                     \
              {FF_FB_FF_FB_CONNECTION_Y_EXTENT}                     \
              {FF_FB_FF_FB_CONNECTION_Z_EXTENT}                     \
          -sourcehole ellipsoid 0.0 0.0 0.0                         \
              {DELTA} {DELTA} {DELTA}                               \
          -nsynapses    {PIRIFORM_NFF_FB_FF_FB_SYNAPSES}            \
          -probability  {FF_FB_FF_FB_CONNECTION_PROB}               \
          -decay_rate   {FF_FB_FF_FB_DECAY_RATE}                    \
          -min_wt 0.0 -debug {DEFAULT_DEBUG}}

float FF_FB_FF_FB_MIN_WT  = 0.0
float FF_FB_FF_FB_STDEV   = FP_WT_STDEV
float FF_FB_FF_FB_MAXDEV  = FP_WT_MAXDEV


// ------------------------------------------------------------------------
// feedforward inhibitory cell -> pyramidal cell connections
// ------------------------------------------------------------------------

//
// Number of synapses from ff interneurons per pyramidal cell.
//

// The Kapur/Lytton/Haberly model gives a value of 75.0
// for this parameter:

float PIRIFORM_NFF_PYR_SYNAPSES = FP_PIRIFORM_NFF_PYR_SYNAPSES

//
// Distribution factors; this distributes the feedback inhibitory
// neuron's synapses differentially onto the different compartments
// of the pyramidal cells.
//
// These values are roughly taken from Ketchum and Haberly
// (J. Neurophys. 69:1, 261-281, fig. 2c), with some guesswork.
// Note that Ia_2 is the most distal Ia compartment.
//

if (FP_FF_DEND_INHIB_FLAG)
    float FF_PYR_DIA_2     = 0.150
    float FF_PYR_DIA_1     = 0.150
    float FF_PYR_DSUPIB_3  = 0.150
    float FF_PYR_DSUPIB_2  = 0.150
    float FF_PYR_DSUPIB_1  = 0.150
    float FF_PYR_DDEEPIB_3 = 0.150
    float FF_PYR_DDEEPIB_2 = 0.150
    float FF_PYR_DDEEPIB_1 = 0.150
else
    float FF_PYR_DIA_2     = 0.4
    float FF_PYR_DIA_1     = 0.4
    float FF_PYR_DSUPIB_3  = 0.2
end

//
// Weight decay rate; see above comments.
//

float FF_PYR_DECAY_RATE = FP_FF_PYR_DECAY_RATE

//
// Maximum weight scale values.
//

function calc_ff_pyr_max_wt(compt_z, dist_factor)
    float compt_z, dist_factor

    return {piriform_calc_exp_max_weight                                \
          -target_location                                              \
          {PIRIFORM_PYRAMIDAL_X_MIDDLE}                                 \
          {PIRIFORM_PYRAMIDAL_Y_MIDDLE}                                 \
          {compt_z}                                                     \
          -source_elements                                              \
          /piriform_cortex/ff_inhib_cell[]/soma/ff_spikegen             \
          -source_relative                                              \
          -sourcemask ellipsoid 0.0 0.0 0.0                             \
              {FF_PYR_CONNECTION_X_EXTENT}                              \
              {FF_PYR_CONNECTION_Y_EXTENT}                              \
              {FF_PYR_CONNECTION_Z_EXTENT}                              \
          -nsynapses    {PIRIFORM_NFF_PYR_SYNAPSES * dist_factor}       \
          -probability  {FF_PYR_CONNECTION_PROB}                        \
          -decay_rate   {FF_PYR_DECAY_RATE}                             \
          -min_wt 0.0 -debug {DEFAULT_DEBUG}}
end

float FF_PYR_MAX_WT_IA_2    =  \
    {calc_ff_pyr_max_wt {PYRAMIDAL_IA_2_Z} {FF_PYR_DIA_2}}

float FF_PYR_MAX_WT_IA_1    =  \
    {calc_ff_pyr_max_wt {PYRAMIDAL_IA_1_Z} {FF_PYR_DIA_1}}

float FF_PYR_MAX_WT_SUPIB_3 =  \
    {calc_ff_pyr_max_wt {PYRAMIDAL_SUPIB_3_Z} {FF_PYR_DSUPIB_3}}

if (FP_FF_DEND_INHIB_FLAG)
    float FF_PYR_MAX_WT_SUPIB_2 =  \
        {calc_ff_pyr_max_wt {PYRAMIDAL_SUPIB_2_Z} {FF_PYR_DSUPIB_2}}

    float FF_PYR_MAX_WT_SUPIB_1 =  \
        {calc_ff_pyr_max_wt {PYRAMIDAL_SUPIB_1_Z} {FF_PYR_DSUPIB_1}}

    float FF_PYR_MAX_WT_DEEPIB_3 =  \
        {calc_ff_pyr_max_wt {PYRAMIDAL_DEEPIB_3_Z} {FF_PYR_DDEEPIB_3}}

    float FF_PYR_MAX_WT_DEEPIB_2 =  \
        {calc_ff_pyr_max_wt {PYRAMIDAL_DEEPIB_2_Z} {FF_PYR_DDEEPIB_2}}

    float FF_PYR_MAX_WT_DEEPIB_1 =  \
        {calc_ff_pyr_max_wt {PYRAMIDAL_DEEPIB_1_Z} {FF_PYR_DDEEPIB_1}}
end

float FF_PYR_MIN_WT = 0.0
float FF_PYR_STDEV  = FP_WT_STDEV
float FF_PYR_MAXDEV = FP_WT_MAXDEV
