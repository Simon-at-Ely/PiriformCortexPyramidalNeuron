// genesis

//
// piriform_cells_steady_state.g: functions to calculate the
//     steady-state values for the state variables of the cell
//     types in the piriform cortex model, and to load (restore)
//     these values into other cells of the same type.
//

// GLOBALS LISTED
// No functions here use global variables directly.

// ======================================================================
//
// Utility functions to disable/enable all but the cell of interest.
//
// ======================================================================

function maybe_enable(path)
    str path

    if ({exists {path}})
        enable {path}
    end
end


function disable_test_cells
    str elm

    foreach elm ({el /test_cells/##})
        disable {elm}
    end

    disable /test_cells
end


function enable_test_cells
    str elm

    foreach elm ({el /test_cells/##})
        enable {elm}
    end

    enable /test_cells
end


function disable_all
    str elm

    disable /odors
    disable /bulb
    disable /piriform_cortex
    disable /out
    disable /time
    disable_test_cells
end


function enable_all
    str elm

    enable /odors
    enable /bulb
    enable /piriform_cortex
    enable /out
    enable /time
    enable_test_cells
end


function enable_fI(path)
    str path

    maybe_enable {path}/Iin
    maybe_enable {path}/fI_pyr_noNE
    maybe_enable {path}/fI_pyr_NE
    maybe_enable {path}/fI_inhib
end


function disable_all_but_test_cell(path)
    str elm, path

    disable_all

    if (!{exists /test_cells/{path}})
        error
        echo "Cell: /test_cells/"{path}" not found!"
        return
    end

    foreach elm ({el /test_cells/{path}/##})
        enable {elm}
    end

    enable /test_cells/{path}
    enable_fI /test_cells

    // Enable the output object too.
    enable /test_cells/out/{path}_Vm
    enable /test_cells/out
    enable /test_cells
end



// ======================================================================
//
// Functions to calculate the steady-states.
//
// ======================================================================

// ----------------------------------------------------------------------
//
// Pyramidal cells.
//
// ----------------------------------------------------------------------

function run_test_pyramidal_cell_to_steady_state(path, outfileroot, \
        duration, NE)
    str   path, outfileroot
    float duration
    float NE        // NE level

    disable_all_but_test_cell {path}

    setclock 0 {long_sim_dt}
    setclock 1 {long_output_dt}

    new_hsolve /test_cells/{path} 10  // Backwards Euler
    reset
    reset
    step {duration} -t
    call /test_cells/out/{path}_Vm SAVE

    setclock 0 {sim_dt}
    setclock 1 {output_dt}

    enable_all

    // NOTE: `cp' followed by `rm' may seem dumb, but genesis can get
    // confused when you move files it's dumping to; this is a
    // safer way to go than by using `mv'.

    if (NE > 0.0)
        sh cp {outfileroot}_Vm {outfileroot}_Vm.ss.NE
    else
        sh cp {outfileroot}_Vm {outfileroot}_Vm.ss.noNE
    end

    sh rm {outfileroot}_Vm
end


function calculate_test_pyramidal_cell_steady_state(NE, inpath, \
        outfileroot, savefileroot)
    str inpath, outfileroot, savefileroot

    float NE  // NE level

    // NOTE: this function shows that the pyramidal cell model
    //       takes less that 10 seconds to reach steady-state.

    str path = "/test_cells/" @ {inpath}

    // Calculate steady-state after 60 seconds with no input.
    // We use method 10 (backwards Euler) with a large step size.

    echo "Calculating steady-state values " -n
    echo "of "{outfileroot}" state variables -- NE conc: "{NE}

    clearfile {outfileroot} @ "_Vm"
    silent 2

    // This next function creates a new hsolver:
    run_test_pyramidal_cell_to_steady_state {inpath} {outfileroot} 60.0 {NE}
    delete {path}/solve

    if (NE > 0.0)
        save {path}/## {savefileroot}.NE -root_path {path}
    else
        save {path}/## {savefileroot}.noNE -root_path {path}
    end

    silent 0
end


// ----------------------------------------------------------------------
//
// FB interneurons.
//
// ----------------------------------------------------------------------


function calculate_test_fb_inhib_cell_steady_state(NE)
    float NE  // NE level

    // NOTE: this function shows that these interneurons
    //       take about 60 msec to reach their steady-state
    //       value.

    str path = "/test_cells/test_fb_inhib_cell"

    // Calculate steady-state after 1 second with no input.

    echo "Calculating steady-state values " -n
    echo "of test_fb_inhib cell state variables -- NE conc: "{NE}
    clearfile "test_fb_inhib_Vm"

    disable_all_but_test_cell test_fb_inhib_cell

    silent 2
    setclock 0 {sim_dt}
    setclock 1 {output_dt}
    reset
    reset
    step 1.0 -t
    call /test_cells/out/test_fb_inhib_cell_Vm SAVE

    if (NE > 0.0)
        save {path}/## fb_inhib.save.NE -root_path {path}
    else
        save {path}/## fb_inhib.save.noNE -root_path {path}
    end

    silent 0

    enable_all

    if (NE > 0.0)
        sh cp test_fb_inhib_Vm test_fb_inhib_Vm.ss.NE
    else
        sh cp test_fb_inhib_Vm test_fb_inhib_Vm.ss.noNE
    end

    sh rm test_fb_inhib_Vm
end


// ----------------------------------------------------------------------
//
// FF interneurons.
//
// ----------------------------------------------------------------------

function calculate_test_ff_inhib_cell_steady_state(NE)
    float NE  // NE level

    // NOTE: this function shows that these interneurons
    //       take about 60 msec to reach their steady-state
    //       value.

    str path = "/test_cells/test_ff_inhib_cell"

    // Calculate steady-state after 1 second with no input.

    echo "Calculating steady-state values " -n
    echo "of test_ff_inhib cell state variables -- NE conc: "{NE}
    clearfile "test_ff_inhib_Vm"

    disable_all_but_test_cell test_ff_inhib_cell

    silent 2
    setclock 0 {sim_dt}
    setclock 1 {output_dt}
    reset
    reset
    step 1.0 -t
    call /test_cells/out/test_ff_inhib_cell_Vm SAVE

    if (NE > 0.0)
        save {path}/## ff_inhib.save.NE -root_path {path}
    else
        save {path}/## ff_inhib.save.noNE -root_path {path}
    end

    silent 0

    enable_all

    if (NE > 0.0)
        sh cp test_ff_inhib_Vm test_ff_inhib_Vm.ss.NE
    else
        sh cp test_ff_inhib_Vm test_ff_inhib_Vm.ss.noNE
    end

    sh rm test_ff_inhib_Vm
end


// ----------------------------------------------------------------------
//
// FF_FB interneurons.
//
// ----------------------------------------------------------------------

function calculate_test_ff_fb_inhib_cell_steady_state(NE)
    float NE  // NE level

    // NOTE: this function shows that these interneurons
    //       take about 60 msec to reach their steady-state
    //       value.

    str path = "/test_cells/test_ff_fb_inhib_cell"

    // Calculate steady-state after 1 second with no input.

    echo "Calculating steady-state values " -n
    echo "of test_ff_fb_inhib cell state variables -- NE conc: "{NE}
    clearfile "test_ff_fb_inhib_Vm"

    disable_all_but_test_cell test_ff_fb_inhib_cell

    silent 2
    setclock 0 {sim_dt}
    setclock 1 {output_dt}
    reset
    reset
    step 1.0 -t
    call /test_cells/out/test_ff_fb_inhib_cell_Vm SAVE

    if (NE > 0.0)
        save {path}/## ff_fb_inhib.save.NE -root_path {path}
    else
        save {path}/## ff_fb_inhib.save.noNE -root_path {path}
    end

    silent 0

    enable_all

    if (NE > 0.0)
        sh cp test_ff_fb_inhib_Vm test_ff_fb_inhib_Vm.ss.NE
    else
        sh cp test_ff_fb_inhib_Vm test_ff_fb_inhib_Vm.ss.noNE
    end

    sh rm test_ff_fb_inhib_Vm
end


// ======================================================================
//
// Other utility functions.
//
// ======================================================================

// Function to restore the state.

function restore_cell(path, savefile)
    str path, savefile

    restore {savefile} -root_path {path}
end


