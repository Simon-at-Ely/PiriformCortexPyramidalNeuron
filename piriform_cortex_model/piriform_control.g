// genesis

//
// piriform_control.g
//     This file contains code to control the running of a simulation,
//     plus some stuff that has to appear before other files are included.
//


// NE concentration; this must appear here first
// because it's used in subsequently loaded files.

float NEconc = 0.0


//
// TODO:
//   -- put in information which will determine the kind of OB input
//      e.g. weak, strong shocks, etc.
//


function run_sim(tmax)
    float tmax
    step {tmax} -t
end



