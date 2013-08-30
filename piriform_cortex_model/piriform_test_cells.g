// genesis

//
// piriform_test_cells.g
//
//     This file defines functions to set up dummy pyramidal cells and
//     interneurons.  The purposes of this are:
//
//     1) To calculate the steady-state state of the pyramidal cell
//        model and save it so it can be restored later.
//
//     2) To  calculate the steady-state state of the inhibitory cell
//        models and save them so they can be restored later.
//
//     3) To run an f/I sequence on a deafferented pyramidal cell to
//        make sure it behaves correctly.
//
//     4) To run an f/I sequence on a deafferented fb_inhib cell to
//        make sure it behaves correctly.
//

// GLOBALS LISTED
// No functions here use global variables directly.

include piriform_cells_steady_state.g
include piriform_test_cells_fI.g

//
// Make the test cell directory and copy a pyramidal cell, a feedback
// inhibitory cell and a feedforward inhibitory cell into this directory.
// Don't bother copying a feedforward/feedback inhibitory cell into this
// directory because it's essentially identical to the feedforward inhibitory
// cell (except for the synchans, which we don't worry about here).
//

function create_test_pyramidal_cell
    copy /cell_library/pyramidal_cell /test_cells/test_pyramidal_cell

    // Save the membrane potential.
    create    asc_file /test_cells/out/test_pyramidal_cell_Vm
    setfield  ^ leave_open 1 append 1 flush 1 filename "test_pyramidal_Vm"
    addmsg    /test_cells/test_pyramidal_cell/soma ^ SAVE Vm
    useclock  ^ 1
end


function create_test_pyramidal_cell_vAPC
    copy /cell_library/pyramidal_cell_vAPC \
         /test_cells/test_pyramidal_cell_vAPC

    // Save the membrane potential.
    create    asc_file /test_cells/out/test_pyramidal_cell_vAPC_Vm
    setfield  ^ leave_open 1 append 1 flush 1 filename "test_pyramidal_vAPC_Vm"
    addmsg    /test_cells/test_pyramidal_cell_vAPC/soma ^ SAVE Vm
    useclock  ^ 1
end


function create_test_fb_inhib_cell
    copy /cell_library/fb_inhib_cell /test_cells/test_fb_inhib_cell

    // The synchans and spikegens are dormant while calculating
    // the steady state so delete them.
    delete /test_cells/test_fb_inhib_cell/soma/fb_assoc_exc_syn
    delete /test_cells/test_fb_inhib_cell/soma/fb_fb_inh_syn
    delete /test_cells/test_fb_inhib_cell/soma/fb_spikegen

    // Save the membrane potential.
    create    asc_file /test_cells/out/test_fb_inhib_cell_Vm
    setfield  ^ leave_open 1 append 1 flush 1 filename "test_fb_inhib_Vm"
    addmsg    /test_cells/test_fb_inhib_cell/soma ^ SAVE Vm
    useclock  ^ 1
end


function create_test_ff_inhib_cell
    copy /cell_library/ff_inhib_cell /test_cells/test_ff_inhib_cell

    // The synchans and spikegens are dormant while calculating
    // the steady state so delete them.
    delete /test_cells/test_ff_inhib_cell/soma/ff_aff_exc_syn
    delete /test_cells/test_ff_inhib_cell/soma/ff_spikegen

    // Save the membrane potential.
    create    asc_file /test_cells/out/test_ff_inhib_cell_Vm
    setfield  ^ leave_open 1 append 1 flush 1 filename "test_ff_inhib_Vm"
    addmsg    /test_cells/test_ff_inhib_cell/soma ^ SAVE Vm
    useclock  ^ 1
end


function create_test_ff_fb_inhib_cell
    copy /cell_library/ff_fb_inhib_cell /test_cells/test_ff_fb_inhib_cell

    // The synchans and spikegens are dormant while calculating
    // the steady state so delete them.
    delete /test_cells/test_ff_fb_inhib_cell/soma/ff_aff_exc_syn
    delete /test_cells/test_ff_fb_inhib_cell/soma/ff_assoc_exc_syn
    delete /test_cells/test_ff_fb_inhib_cell/soma/ff_ff_inh_syn
    delete /test_cells/test_ff_fb_inhib_cell/soma/ff_fb_spikegen

    // Save the membrane potential.
    create    asc_file /test_cells/out/test_ff_fb_inhib_cell_Vm
    setfield  ^ leave_open 1 append 1 flush 1 filename "test_ff_fb_inhib_Vm"
    addmsg    /test_cells/test_ff_fb_inhib_cell/soma ^ SAVE Vm
    useclock  ^ 1
end


function create_test_cells
    create neutral /test_cells
    create neutral /test_cells/out
    create_test_pyramidal_cell
    create_test_pyramidal_cell_vAPC
    create_test_fb_inhib_cell
    create_test_ff_inhib_cell
    create_test_ff_fb_inhib_cell
end


//
// Main body of code starts here.
//

create_test_cells

set_NE 0.0

calculate_test_pyramidal_cell_steady_state  0.0 test_pyramidal_cell \
                                            test_pyramidal pyr.save

calculate_test_pyramidal_cell_steady_state  0.0 test_pyramidal_cell_vAPC \
                                            test_pyramidal_vAPC pyr_vAPC.save
calculate_test_fb_inhib_cell_steady_state       0.0
calculate_test_ff_inhib_cell_steady_state       0.0
calculate_test_ff_fb_inhib_cell_steady_state    0.0

set_NE 100.0

calculate_test_pyramidal_cell_steady_state  100.0 test_pyramidal_cell \
                                            test_pyramidal pyr.save
calculate_test_pyramidal_cell_steady_state  100.0 test_pyramidal_cell_vAPC \
                                            test_pyramidal_vAPC pyr_vAPC.save
calculate_test_fb_inhib_cell_steady_state       100.0
calculate_test_ff_inhib_cell_steady_state       100.0
calculate_test_ff_fb_inhib_cell_steady_state    100.0

set_NE 0.0

// Uncomment the following line to test how well the cells match the
// experimental data with respect to their spiking behavior under
// current clamp.

do_fI

// Disable all the test cells.
disable /test_cells

