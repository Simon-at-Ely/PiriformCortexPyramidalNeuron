// genesis

//
// piriform.g: the piriform cortex simulation.
//

// Initialize the cellreader.
initcellreader

//
// NOTE: do not switch the order of these files, notably the parameter
//       files, because in many cases later files depend on earlier ones.
//

// Directories to dump output files into:
str outdir     = "results/1"
str outdir_syn = "results/1/nsyn"
str outdir_pos = "results/1/positions"
str outdir_gen = "results/1/genesis"

str cmd

// Get rid of previous output directories if any.
cmd = "/bin/rm -rf"
sh {cmd} {outdir}

// Make sure the output directories all exist.
cmd = "mkdir -p"
sh {cmd} {outdir}
sh {cmd} {outdir_syn}
sh {cmd} {outdir_pos}
sh {cmd} {outdir_gen}

include piriform_control.g      // Top-level simulation control stuff.
include piriform_free_params.g  // "Free" parameters for the model.
include piriform_setup.g        // Set up simulation parameters.
include piriform_sched.g        // Simulation schedule.
include piriform_params.g       // Network parameters.
include piriform_utils.g        // Various utility functions.
include piriform_reset.g        // Reset functions.
include piriform_check.g        // Check functions.
include piriform_inputs.g       // Set up the inputs to the piriform cortex.
include piriform_cells.g        // Create the cells.
include piriform_neuromod.g     // Set up neuromodulation.
include piriform_params_conn.g  // Network parameters relating to connections.
include neuron_groups.g         // Define neuronal groups.
include piriform_connect.g      // Wire up the network.
include piriform_weight_dump.g  // Dump xview files of the synaptic weights.
include piriform_outputs.g      // Record outputs.
//include piriform_test_cells.g   // Calculate steady states of cells.
include piriform_field.g        // Set up field potential measuring system.

// Save the simulation files.
sh cp *.g *.p odor_events_multi_shock {outdir_gen}

//
// Main body of simulation.
//

set_NE 0.0

// run_bg 0
// run_weak_shock 1
// run_strong_shock 1
// run_eeg 0


set_NE 100.0

// run_bg 0
run_weak_shock 1
// run_strong_shock 1
// run_eeg 0

quit


