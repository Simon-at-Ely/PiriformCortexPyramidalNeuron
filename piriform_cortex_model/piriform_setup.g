// genesis

//
// piriform_setup.g: set up basic simulation parameters.
//

setprompt "piriform cortex: !"


floatformat %g
set_ip_display_size 10  // Interpol display in mod_tabchannels


// Random-number generators.
// May want to use a fixed seed for testing or repeating.

randseed 12345  // Try to avoid stuff that relies on the default RNG.
srand2   12345


// Simulation timings:

float sim_dt         =  20.0e-6  // 20 usec; basic simulation time step
float long_sim_dt    =   0.001   // for calculating steady-state
                                 // of pyramidal cells
float output_dt      = 100.0e-6  // 100 usec; simulation output interval
float long_output_dt =   0.001   // not normally used
float timer_dt       =   0.010   // 10 msec; for timer object

setclock  0  {sim_dt}
setclock  1  {output_dt}
setclock  2  {timer_dt}


// Make sure axonal conduction delays are at least equal to a couple
// of time steps; we don't want "instantaneous" connections.

float sim_mindelay = 2.0 * sim_dt


// Timer object:

create timer /time
useclock /time 2


