// genesis

//
// pyr_cell.g: defines a layer 2 pyramidal cell in piriform cortex.
//

if (no_pyr_Kahp)
    str pyramidal_cell_parameter_file  = "pyramidal_no_Kahp.p"
    str pyramidal_cell_parameter_file2 = "pyramidal_no_Kahp.p"
else
    str pyramidal_cell_parameter_file  = "pyramidal.p"
    str pyramidal_cell_parameter_file2 = "pyramidal.p"
end

//str pyramidal_cell_parameter_file2 = "pyramidal_vAPC_2.p"


function do_hsolve(path, method, chanmode)
    str path
    int method, chanmode

    create hsolve {path}/solve
    setfield {path}/solve  \
        path {path}"/##[][TYPE=mod_compartment]"    \
        comptmode   1                               \
        chanmode    {chanmode}                      \
        outclock    0

    call {path}/solve SETUP
    setmethod {method}
end


// This function creates (or re-creates) the hsolver.

function new_hsolve(path, method)
    str path
    int method   // hsolver parameter

    // Delete old hsolver if any.

    if ({exists {path}/solve})
        delete {path}/solve
        reclaim
    end

    do_hsolve {path} {method} 0
end


// This function creates the cell without the hsolver.

function make_pyramidal_cell
    if (!{exists /cell_library})
        echo ERROR! must create /cell_library before creating cell models!
        return
    end

    // Define new channel library and load in the cell (and variations
    // thereof).

    make_pyramidal_channel_library
    readcell {pyramidal_cell_parameter_file} /cell_library/pyramidal_cell
    readcell {pyramidal_cell_parameter_file2} \
        /cell_library/pyramidal_cell_vAPC

    // This is an experiment: remove neuromodulation from all comparments and
    // voltage-dependent channels in the pyramidal_cell_vAPC cell.
/*
    str elm

    foreach elm \
    ({el /cell_library/pyramidal_cell_vAPC/##[OBJECT=mod_compartment]})
        setfield {elm} mod_index -1
    end

    foreach elm \
    ({el /cell_library/pyramidal_cell_vAPC/##[OBJECT=mod_tabchannel]})
        setfield {elm} mod_index 0
    end
*/
end





