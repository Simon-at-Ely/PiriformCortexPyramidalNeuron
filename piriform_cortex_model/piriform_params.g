// genesis

//
// piriform_params.g: parameters for the piriform cortex simulation.
//     This also includes parameters for the olfactory_bulb object.
//     Unless otherwise specified, all units are SI.
//     All "offset" parameters are relative to the origin of the
//     coordinate system.
//

//
// Spatial extent of piriform cortex:
//    roughly 8mm (rostral->caudal) x 3mm (dorsal->ventral)
// Estimated from "The Rat Brain in Stereotaxic Coordinates" by
// Paxinos and Watson (1982).  Note that
//
// a) The dorsal->ventral extent of piriform cortex varies from
//    about 3 to 5 mm, but is most commonly about 3 mm;
// b) The figure of 10x6 mm, used in (Wilson and Bower 1992) is
//    probably derived from opossum.
//
// From Ketchum and Haberly (1993):
//
// Piriform cortex should be divided into three zones:
//
// a) The posterior or caudalmost half is termed "posterior piriform
//    cortex";
// b) The anterior piriform cortex is divided into two unequal parts:
//    i)  ventral anterior: going from 1/2 the dorsoventral extent of the
//        piriform cortex at the anterior end to zero at the anterior/
//        posterior boundary.
//    ii) dorsal anterior: everything else.
//
// So an aerial view :-) would look sort of like this:
//
// |---|---|---|---|---|---|---|---|
// | dorsal ant    |               |
// |________       |  posterior    |
// |        ---    |  piriform ctx |
// |ventral ant---\|               |
// |---|---|---|---|---|---|---|---|
//
// For a 1000-pyramidal cell network, this works out to:
//
// anterior->posterior: 50 cells spaced 160 um apart
// dorsal->ventral:     20 cells spaced 150 um apart
//
// For a smaller 100-pyramidal cell-ish network, the best match is:
//
// anterior->posterior: 16 cells spaced 500 um apart
// dorsal->ventral:      6 cells spaced 500 um apart
//
// In both cases, the number of inhibitory cells of all types is one less
// along each dimension.  The spacings are identical to those of the
// pyramidal cells.
//

//
// Direction conventions:
//     The X direction is along the anterior-posterior axis.
//     The Y direction is along the dorsal-ventral axis.
//     The Z direction is along the superficial-deep axis.
//

// ------------------------------------------------------------------------
//
// Naming conventions:
//
// PYR, PYRAMIDAL: relating to layer 2 pyramidal cells
// FF_INHIB:       relating to layer 1a feedforward inhibitory cells
// FF_FB_INHIB:    relating to layer 1b feedforward/feedback inhibitory cells
// FB_INHIB:       relating to layer 2/3 feedback inhibitory cells
// BULB:           relating to olfactory bulb mitral cells
// PIRIFORM:       relating to piriform cortex
// AFF:            relating to afferent connections
// ASSOC:          relating to associational connections
// WT:             relating to synaptic weights
//
// NX, NY, NZ:  number of cells in the X, Y, or Z directions
// DX, DY, DZ:  basic distance unit in the X, Y, or Z directions
// NxxxS:       number of xxx's
// xxx_PROB:    probability of xxx
// xxx_COMPTS:  some kind of compartments
//
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
//                  Cortical dimensions
// ------------------------------------------------------------------------

float PIRIFORM_X_EXTENT = 8.0e-3  // 8 mm
float PIRIFORM_Y_EXTENT = 3.0e-3  // 3 mm


// ------------------------------------------------------------------------
//                      Cell numbers.
// ------------------------------------------------------------------------

// Basic scales of network.

int XSCALE, YSCALE, XSCALE2, YSCALE2, XSCALE3, YSCALE3

// For pyramidal cells.

if (scale == "large")
    XSCALE  = 50
    YSCALE  = 20
elif (scale == "medium")
    XSCALE  = 32
    YSCALE  = 12
elif (scale == "medium-small")
    XSCALE  = 20
    YSCALE  = 10
else // small
    XSCALE  = 16
    YSCALE  =  6
end


// For all inhibitory cells.

XSCALE2 = XSCALE - 1
YSCALE2 = YSCALE - 1


// "Middle" indices and related values; these are used by some of the
// connection commands.

int NXMIDDLE    = {XSCALE / 2}
int NXQUARTER   = {XSCALE / 4}
int NYMIDDLE    = {YSCALE / 2}

int NXMIDDLE2   = {NXMIDDLE - 1}
int NXQUARTER2  = {NXQUARTER - 1}
int NYMIDDLE2   = {NYMIDDLE - 1}


// For mitral cells.
// Mitral cells are arranged as a single line of cells.
// We keep the same scale for large and small networks.

XSCALE3 = 1
YSCALE3 = 960


// Pyramidal cells.

int PIRIFORM_NX_PYRAMIDAL = {XSCALE}
int PIRIFORM_NY_PYRAMIDAL = {YSCALE}
int PIRIFORM_N_PYRAMIDAL  = \
    PIRIFORM_NX_PYRAMIDAL * PIRIFORM_NY_PYRAMIDAL


// Feedback inhibitory cells.

int PIRIFORM_NX_FB_INHIB  = {XSCALE2}
int PIRIFORM_NY_FB_INHIB  = {YSCALE2}
int PIRIFORM_N_FB_INHIB   = \
    PIRIFORM_NX_FB_INHIB * PIRIFORM_NY_FB_INHIB


// Feedforward inhibitory cells.

int PIRIFORM_NX_FF_INHIB  = {XSCALE2}
int PIRIFORM_NY_FF_INHIB  = {YSCALE2}
int PIRIFORM_N_FF_INHIB   = \
    PIRIFORM_NX_FF_INHIB * PIRIFORM_NY_FF_INHIB


// Feedforward/feedback inhibitory cells.

int PIRIFORM_NX_FF_FB_INHIB  = {XSCALE2}
int PIRIFORM_NY_FF_FB_INHIB  = {YSCALE2}
int PIRIFORM_N_FF_FB_INHIB   = \
    PIRIFORM_NX_FF_FB_INHIB * PIRIFORM_NY_FF_FB_INHIB


// Olfactory bulb "mitral" cells.

int BULB_NX = {XSCALE3}
int BULB_NY = {YSCALE3}
int BULB_N  = BULB_NX * BULB_NY


// ------------------------------------------------------------------------
//                     Cell spacings.
// ------------------------------------------------------------------------

float PIRIFORM_DX_PYRAMIDAL    = {PIRIFORM_X_EXTENT / XSCALE}
float PIRIFORM_DY_PYRAMIDAL    = {PIRIFORM_Y_EXTENT / YSCALE}

float PIRIFORM_DX_FB_INHIB     = {PIRIFORM_DX_PYRAMIDAL}
float PIRIFORM_DY_FB_INHIB     = {PIRIFORM_DY_PYRAMIDAL}

// ff and ff_fb inhibitory cells have the same spacings as
// fb inhibitory cells.

float PIRIFORM_DX_FF_INHIB     = {PIRIFORM_DX_FB_INHIB}
float PIRIFORM_DY_FF_INHIB     = {PIRIFORM_DY_FB_INHIB}

float PIRIFORM_DX_FF_FB_INHIB  = {PIRIFORM_DX_FB_INHIB}
float PIRIFORM_DY_FF_FB_INHIB  = {PIRIFORM_DY_FB_INHIB}

// N.B. all "mitral cells" have the same x position,
// and the number of cells doesn't change, so these
// numbers are constants.

float BULB_DX           = 0.0
float BULB_DY           = 15.0e-6


// ------------------------------------------------------------------------
//               Relative cell positionings.
// ------------------------------------------------------------------------

// The Z location of pyramidal cell somata is 0.0 by definition.
// Positive Z direction is towards the surface.
// The "START/END" pairs are to give the connection functions an idea
// of where the cells are.  They enclose all the cells along a given
// dimension.  The first cell is actually located at OFFSET after START
// and the last one is located OFFSET before END.

// Pyramidal cells.

float PIRIFORM_PYRAMIDAL_X_START   =  0.0
float PIRIFORM_PYRAMIDAL_X_OFFSET  =  PIRIFORM_DX_PYRAMIDAL / 2.0
float PIRIFORM_PYRAMIDAL_X_QUARTER =  \
      PIRIFORM_PYRAMIDAL_X_OFFSET + NXQUARTER * PIRIFORM_DX_PYRAMIDAL
float PIRIFORM_PYRAMIDAL_X_MIDDLE  =  \
      PIRIFORM_PYRAMIDAL_X_OFFSET + NXMIDDLE * PIRIFORM_DX_PYRAMIDAL
float PIRIFORM_PYRAMIDAL_X_LAST    =  \
      PIRIFORM_PYRAMIDAL_X_OFFSET + \
      (PIRIFORM_NX_PYRAMIDAL - 1) * PIRIFORM_DX_PYRAMIDAL
float PIRIFORM_PYRAMIDAL_X_END     =  \
      PIRIFORM_PYRAMIDAL_X_LAST + PIRIFORM_PYRAMIDAL_X_OFFSET
float PIRIFORM_PYRAMIDAL_X_LENGTH  = \
      PIRIFORM_PYRAMIDAL_X_END - PIRIFORM_PYRAMIDAL_X_START

float PIRIFORM_PYRAMIDAL_Y_START   =  0.0
float PIRIFORM_PYRAMIDAL_Y_OFFSET  =  PIRIFORM_DY_PYRAMIDAL / 2.0
float PIRIFORM_PYRAMIDAL_Y_MIDDLE  =  \
      PIRIFORM_PYRAMIDAL_Y_OFFSET + NYMIDDLE * PIRIFORM_DY_PYRAMIDAL
float PIRIFORM_PYRAMIDAL_Y_LAST    =  \
      PIRIFORM_PYRAMIDAL_Y_OFFSET + \
      (PIRIFORM_NY_PYRAMIDAL - 1) * PIRIFORM_DY_PYRAMIDAL
float PIRIFORM_PYRAMIDAL_Y_END     =  \
      PIRIFORM_PYRAMIDAL_Y_LAST + PIRIFORM_PYRAMIDAL_X_OFFSET
float PIRIFORM_PYRAMIDAL_Y_LENGTH  = \
      PIRIFORM_PYRAMIDAL_Y_END - PIRIFORM_PYRAMIDAL_Y_START

float PIRIFORM_PYRAMIDAL_Z_START   =  -5.0e-6   // Nominal value.
float PIRIFORM_PYRAMIDAL_Z_OFFSET  =   0.0      // By definition.
float PIRIFORM_PYRAMIDAL_Z_LAST    =   0.0
float PIRIFORM_PYRAMIDAL_Z_END     =   5.0e-6   // Nominal value.
float PIRIFORM_PYRAMIDAL_Z_LENGTH  = \
      PIRIFORM_PYRAMIDAL_Z_END - PIRIFORM_PYRAMIDAL_Z_START



// Feedback inhibitory cells.

float PIRIFORM_FB_INHIB_X_START    =  0.0
float PIRIFORM_FB_INHIB_X_OFFSET   =  PIRIFORM_DX_FB_INHIB
float PIRIFORM_FB_INHIB_X_MIDDLE  =  \
      PIRIFORM_FB_INHIB_X_OFFSET + NXMIDDLE2 * PIRIFORM_DX_FB_INHIB
float PIRIFORM_FB_INHIB_X_LAST     =  \
      PIRIFORM_FB_INHIB_X_OFFSET + \
      (PIRIFORM_NX_FB_INHIB - 1) * PIRIFORM_DX_FB_INHIB
float PIRIFORM_FB_INHIB_X_END      =  \
      PIRIFORM_FB_INHIB_X_LAST + PIRIFORM_FB_INHIB_X_OFFSET
float PIRIFORM_FB_INHIB_X_LENGTH  = \
      PIRIFORM_FB_INHIB_X_END - PIRIFORM_FB_INHIB_X_START

float PIRIFORM_FB_INHIB_Y_START    =  0.0
float PIRIFORM_FB_INHIB_Y_OFFSET   =  PIRIFORM_DY_FB_INHIB
float PIRIFORM_FB_INHIB_Y_MIDDLE  =  \
      PIRIFORM_FB_INHIB_Y_OFFSET + NYMIDDLE2 * PIRIFORM_DY_FB_INHIB
float PIRIFORM_FB_INHIB_Y_LAST     =  \
      PIRIFORM_FB_INHIB_Y_OFFSET + \
      (PIRIFORM_NY_FB_INHIB - 1) * PIRIFORM_DY_FB_INHIB
float PIRIFORM_FB_INHIB_Y_END      =  \
      PIRIFORM_FB_INHIB_Y_LAST + PIRIFORM_FB_INHIB_Y_OFFSET
float PIRIFORM_FB_INHIB_Y_LENGTH  = \
      PIRIFORM_FB_INHIB_Y_END - PIRIFORM_FB_INHIB_Y_START

float PIRIFORM_FB_INHIB_Z_START    =  -25.0e-6  // Nominal value.
float PIRIFORM_FB_INHIB_Z_OFFSET   =  -20.0e-6
float PIRIFORM_FB_INHIB_Z_LAST     =  -20.0e-6
float PIRIFORM_FB_INHIB_Z_END      =  -15.0e-6  // Nominal value.
float PIRIFORM_FB_INHIB_Z_LENGTH  = \
      PIRIFORM_FB_INHIB_Z_END - PIRIFORM_FB_INHIB_Z_START


// Feedforward inhibitory cells.

float PIRIFORM_FF_INHIB_X_START    =  0.0
float PIRIFORM_FF_INHIB_X_OFFSET   =  PIRIFORM_DX_FF_INHIB
float PIRIFORM_FF_INHIB_X_MIDDLE  =  \
      PIRIFORM_FF_INHIB_X_OFFSET + NXMIDDLE2 * PIRIFORM_DX_FF_INHIB
float PIRIFORM_FF_INHIB_X_LAST     =  \
      PIRIFORM_FF_INHIB_X_OFFSET + \
      (PIRIFORM_NX_FF_INHIB - 1) * PIRIFORM_DX_FF_INHIB
float PIRIFORM_FF_INHIB_X_END      =  \
      PIRIFORM_FF_INHIB_X_LAST + PIRIFORM_FF_INHIB_X_OFFSET
float PIRIFORM_FF_INHIB_X_LENGTH  = \
      PIRIFORM_FF_INHIB_X_END - PIRIFORM_FF_INHIB_X_START

float PIRIFORM_FF_INHIB_Y_START    =  0.0
float PIRIFORM_FF_INHIB_Y_OFFSET   =  PIRIFORM_DY_FF_INHIB
float PIRIFORM_FF_INHIB_Y_MIDDLE  =  \
      PIRIFORM_FF_INHIB_Y_OFFSET + NYMIDDLE2 * PIRIFORM_DY_FF_INHIB
float PIRIFORM_FF_INHIB_Y_LAST     =  \
      PIRIFORM_FF_INHIB_Y_OFFSET + \
      (PIRIFORM_NY_FF_INHIB - 1) * PIRIFORM_DY_FF_INHIB
float PIRIFORM_FF_INHIB_Y_END      =  \
      PIRIFORM_FF_INHIB_Y_LAST + PIRIFORM_FF_INHIB_Y_OFFSET
float PIRIFORM_FF_INHIB_Y_LENGTH  = \
      PIRIFORM_FF_INHIB_Y_END - PIRIFORM_FF_INHIB_Y_START

float PIRIFORM_FF_INHIB_Z_START    =  395.0e-6  // Nominal value.
float PIRIFORM_FF_INHIB_Z_OFFSET   =  400.0e-6
float PIRIFORM_FF_INHIB_Z_LAST     =  400.0e-6
float PIRIFORM_FF_INHIB_Z_END      =  405.0e-6  // Nominal value.
float PIRIFORM_FF_INHIB_Z_LENGTH  = \
      PIRIFORM_FF_INHIB_Z_END - PIRIFORM_FF_INHIB_Z_START


// Feedforward/feedback inhibitory cells.

float PIRIFORM_FF_FB_INHIB_X_START    =  0.0
float PIRIFORM_FF_FB_INHIB_X_OFFSET   =  PIRIFORM_DX_FF_FB_INHIB
float PIRIFORM_FF_FB_INHIB_X_MIDDLE  =  \
      PIRIFORM_FF_FB_INHIB_X_OFFSET + NXMIDDLE2 * PIRIFORM_DX_FF_FB_INHIB
float PIRIFORM_FF_FB_INHIB_X_LAST     =  \
      PIRIFORM_FF_FB_INHIB_X_OFFSET + \
      (PIRIFORM_NX_FF_FB_INHIB - 1) * PIRIFORM_DX_FF_FB_INHIB
float PIRIFORM_FF_FB_INHIB_X_END      =  \
      PIRIFORM_FF_FB_INHIB_X_LAST + PIRIFORM_FF_FB_INHIB_X_OFFSET
float PIRIFORM_FF_FB_INHIB_X_LENGTH  = \
      PIRIFORM_FF_FB_INHIB_X_END - PIRIFORM_FF_FB_INHIB_X_START

float PIRIFORM_FF_FB_INHIB_Y_START    =  0.0
float PIRIFORM_FF_FB_INHIB_Y_OFFSET   =  PIRIFORM_DY_FF_FB_INHIB
float PIRIFORM_FF_FB_INHIB_Y_MIDDLE  =  \
      PIRIFORM_FF_FB_INHIB_Y_OFFSET + NYMIDDLE2 * PIRIFORM_DY_FF_FB_INHIB
float PIRIFORM_FF_FB_INHIB_Y_LAST     =  \
      PIRIFORM_FF_FB_INHIB_Y_OFFSET + \
      (PIRIFORM_NY_FF_FB_INHIB - 1) * PIRIFORM_DY_FF_FB_INHIB
float PIRIFORM_FF_FB_INHIB_Y_END      =  \
      PIRIFORM_FF_FB_INHIB_Y_LAST + PIRIFORM_FF_FB_INHIB_Y_OFFSET
float PIRIFORM_FF_FB_INHIB_Y_LENGTH  = \
      PIRIFORM_FF_FB_INHIB_Y_END - PIRIFORM_FF_FB_INHIB_Y_START

float PIRIFORM_FF_FB_INHIB_Z_START    =  215.0e-6  // Nominal value.
float PIRIFORM_FF_FB_INHIB_Z_OFFSET   =  220.0e-6
float PIRIFORM_FF_FB_INHIB_Z_LAST     =  220.0e-6
float PIRIFORM_FF_FB_INHIB_Z_END      =  225.0e-6  // Nominal value.
float PIRIFORM_FF_FB_INHIB_Z_LENGTH  = \
      PIRIFORM_FF_FB_INHIB_Z_END - PIRIFORM_FF_FB_INHIB_Z_START


// Olfactory bulb "mitral cells".
// We position them in a line 10 mm away from piriform cortex.
// The distance is arbitrary and unimportant because the LOT
// afferents have such a high conduction velocity.  This should
// give only about a 1.5 msec delay at 7 m/sec conduction velocities.

float BULB_X_START   = -11.0e-3  // Nominal; for use by connection commands.
float BULB_X_OFFSET  = -10.0e-3
float BULB_X_END     = -9.0e-3   // Nominal; for use by connection commands.
float BULB_Y_START   =  0.0
float BULB_Y_OFFSET  =  BULB_DY / 2.0
float BULB_Y_LAST    =  BULB_Y_OFFSET + (BULB_NY - 1) * BULB_DY
float BULB_Y_END     =  BULB_Y_LAST + BULB_Y_OFFSET
float BULB_Y_LENGTH  =  BULB_Y_END - BULB_Y_START

// The Z-position of the OB mitral cells is at roughly the same level
// as the top of the piriform cortex.  This is just for convenience.
// In fact, the Z-position of the OB cell *defines* the top of the
// piriform cortex operationally in this model.

float BULB_Z_START   =  495.0e-6  // Nominal value.
float BULB_Z_OFFSET  =  500.0e-6
float BULB_Z_LAST    =  500.0e-6
float BULB_Z_END     =  505.0e-6  // Nominal value.
float BULB_Z_LENGTH  =  BULB_Z_END - BULB_Z_START


// ------------------------------------------------------------------------
//                   Other useful values.
// ------------------------------------------------------------------------

float PIRIFORM_X_CENTER     = PIRIFORM_X_EXTENT * 0.5
float PIRIFORM_Y_CENTER     = PIRIFORM_Y_EXTENT * 0.5

float PYRAMIDAL_SOMA_Z      =   0.0
float PYRAMIDAL_BASAL_1_Z   = -79.6812e-6
float PYRAMIDAL_BASAL_2_Z   = -79.6812e-6 * 2.0
float PYRAMIDAL_BASAL_3_Z   = -79.6812e-6 * 3.0
float PYRAMIDAL_BASAL_4_Z   = -79.6812e-6 * 4.0
float PYRAMIDAL_BASAL_5_Z   = -79.6812e-6 * 5.0
float PYRAMIDAL_BASAL_6_Z   = -79.6812e-6 * 6.0

float PYRAMIDAL_DEEPIB_1_Z  =  57.8940e-6
float PYRAMIDAL_DEEPIB_2_Z  =  57.8940e-6 * 2.0
float PYRAMIDAL_DEEPIB_3_Z  =  57.8940e-6 * 3.0
float PYRAMIDAL_SUPIB_1_Z   =  57.8940e-6 * 4.0
float PYRAMIDAL_SUPIB_2_Z   =  57.8940e-6 * 5.0
float PYRAMIDAL_SUPIB_3_Z   =  57.8940e-6 * 6.0
float PYRAMIDAL_IA_1_Z      =  57.8940e-6 * 7.0
float PYRAMIDAL_IA_2_Z      =  57.8940e-6 * 8.0

float FB_Z     = {PIRIFORM_FB_INHIB_Z_OFFSET}
float FF_Z     = {PIRIFORM_FF_INHIB_Z_OFFSET}
float FF_FB_Z  = {PIRIFORM_FF_FB_INHIB_Z_OFFSET}
