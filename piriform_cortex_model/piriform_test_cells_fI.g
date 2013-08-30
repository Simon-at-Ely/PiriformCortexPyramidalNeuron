// genesis

//
// piriform_test_cells_fI.g
//     This file contains functions to run f/I sequences on the test
//     cells to make sure they're behaving correctly.
//

// GLOBALS LISTED

// Functions to set up current table.

//
// Globals:
//

float CURRTABLE_DELIMITER    = -9999.9  // Signifies the end of the table.
float CURRTABLE_DELIMITER_GT = -1000.0  // Greater than the delimiter.
// currents in table are in units of 1 nA
float FISCALE                = 1e-9


function init_fItable(ncurrs, currpath)
    int ncurrs
    str currpath

    create table {currpath}

    // We need an extra table entry to store the delimiter.
    call {currpath} TABCREATE {ncurrs + 1} 0 0
end


function add_to_fItable(curr, currpath, index)
    float curr
    str currpath
    int index     // into fI table

    setfield {currpath} table->table[{index}] {curr}
end


function end_fItable(currpath, index)
    // globals used: CURRTABLE_DELIMITER
    str currpath
    int index

    // Add the delimiter, which is not a current.
    setfield {currpath} table->table[{index}] {CURRTABLE_DELIMITER}
end


function show_fItable(currpath)
    // globals used: CURRTABLE_DELIMITER_GT
    str currpath
    int i = 0
    float curr

    while ({getfield {currpath} table->table[{i}]} >  \
          {CURRTABLE_DELIMITER_GT})
        curr = {getfield {currpath} table->table[{i}]}
        echo Current {i}: {curr}
        i = i + 1
    end
end


function make_fItable_pyramidal(currpath, full, NEflag)
    str currpath
    int full
    int NEflag

    // `full' is a flag which, if nonzero, means to add extra
    // currents for hyperpolarizing and zero currents.
    // `NEflag' is a flag which, if nonzero, means to use the
    // currents that were used in our NE experiments.

    int i, ncurrs
    i = 0

    if (NEflag)
        if (full)
            ncurrs = 11 // 12 if using zero current
        else
            ncurrs = 10
        end

        init_fItable {ncurrs} {currpath}

        if (full)
            add_to_fItable -0.122890 {currpath} {i} ; i = i + 1
            //add_to_fItable  0.0      {currpath} {i} ; i = i + 1
        end

        add_to_fItable  0.081596 {currpath} {i} ; i = i + 1
        add_to_fItable  0.100754 {currpath} {i} ; i = i + 1
        add_to_fItable  0.120626 {currpath} {i} ; i = i + 1
        add_to_fItable  0.140016 {currpath} {i} ; i = i + 1
        add_to_fItable  0.159804 {currpath} {i} ; i = i + 1
        add_to_fItable  0.188950 {currpath} {i} ; i = i + 1
        add_to_fItable  0.208756 {currpath} {i} ; i = i + 1
        add_to_fItable  0.228177 {currpath} {i} ; i = i + 1
        add_to_fItable  0.248051 {currpath} {i} ; i = i + 1
        add_to_fItable  0.267447 {currpath} {i} ; i = i + 1

    else
        if (full)
            ncurrs = 8 // 9 if using zero current
        else
            ncurrs = 7
        end

        init_fItable {ncurrs} {currpath}

        if (full)
            add_to_fItable -0.122918 {currpath} {i} ; i = i + 1
            //add_to_fItable  0.0      {currpath} {i} ; i = i + 1
        end

        add_to_fItable  0.140000 {currpath} {i} ; i = i + 1
        add_to_fItable  0.159832 {currpath} {i} ; i = i + 1
        add_to_fItable  0.188959 {currpath} {i} ; i = i + 1
        add_to_fItable  0.208836 {currpath} {i} ; i = i + 1
        add_to_fItable  0.228242 {currpath} {i} ; i = i + 1
        add_to_fItable  0.248009 {currpath} {i} ; i = i + 1
        add_to_fItable  0.267446 {currpath} {i} ; i = i + 1
    end

    end_fItable {currpath} {i}
end


function make_fItable_fb_inhib(currpath)
    str currpath

    int i
    int ncurrs = 7

    // NOTE: we don't need a "full" flag here; we
    // always use the hyperpolarizing and zero currents.

    init_fItable {ncurrs} {currpath}
    add_to_fItable -0.1   {currpath} {i} ; i = i + 1
    add_to_fItable  0.0   {currpath} {i} ; i = i + 1
    add_to_fItable  0.1   {currpath} {i} ; i = i + 1
    add_to_fItable  0.25  {currpath} {i} ; i = i + 1
    add_to_fItable  0.4   {currpath} {i} ; i = i + 1
    add_to_fItable  0.6   {currpath} {i} ; i = i + 1
    add_to_fItable  1.0   {currpath} {i} ; i = i + 1
    end_fItable {currpath} {i}
end


// Function to stimulate a cell with currents from table.

function runfI(currpath, savefile, stimelem, targetpath, \
               delay, duration, offset, \
               outfile, outelem)
    // globals used: CURRTABLE_DELIMITER_GT, FISCALE
    float delay, duration, offset
    str currpath, savefile, stimelem, targetelem, outfile, outelem

    // `savefile' is the name of the file containing the saved
    //  steady-state variables of the cell.
    // `stimelem' is the name of the current injection element.
    // `targetpath' is the path of the cell to be stimulated.
    // `outfile' is the name of the output file, while `outelem' is the
    // name of the asc_file element that dumps output to the file.

    float total_duration = delay + duration + 0.1
    float current, plotted_current
    int i = 0

    setfield {outelem} filename {outfile}
    call {outelem} OUT_OPEN

    setfield {stimelem} delay1 {delay} width1 {duration}

    // Delete previous INJECT message if any and add a new one.

    if ({getmsg {stimelem} -outgoing -count} > 0)
        deletemsg {stimelem} 0 -outgoing
    end

    addmsg {stimelem} {targetpath}/soma INJECT output

    echo Running f/I stimulation sequence on cell: {targetpath}
    echo NE concentration: {get_NE} uM
    silent 2

    //
    // NOTE: we have to create a new hsolver because the previous
    //       one used integration method 10 (Backwards Euler).
    //       Actually, we could probably get by with just changing
    //       the method, but this also works.
    //

    if (({savefile} == "pyr.save.noNE") || \
        ({savefile} == "pyr.save.NE"))
        new_hsolve {targetpath} 11     // Crank-Nicolson
    end

    while ({getfield {currpath} table->table[{i}]} >  \
          {CURRTABLE_DELIMITER_GT})
        plotted_current = {getfield {currpath} table->table[{i}]}
        current = plotted_current * FISCALE
        //echo CURRENT: {plotted_current}
        echo . -n

        call {outelem} OUT_WRITE "/newplot"
        call {outelem} OUT_WRITE "/plotname "{plotted_current}
        call {outelem} OUT_WRITE "/yaxisoffset "{offset}

        setfield {stimelem} level1 {current}

        reset
        reset

        restore {savefile} -root_path {targetpath}

        step {total_duration} -t

        i = i + 1
    end

    call {outelem} SAVE
    silent 0
    echo
end


//
// This function sets up the fI tables and the current injection object.
//

function setup_fI(full)
    int full     // flag for whether to use the full current tables

    // f/I table for no-NE currents:
    make_fItable_pyramidal  /test_cells/fI_pyr_noNE   {full} 0

    // f/I table for NE currents:
    make_fItable_pyramidal  /test_cells/fI_pyr_NE   {full} 1

    // f/I table for fb_inhib currents:
    make_fItable_fb_inhib /test_cells/fI_inhib

    create pulsegen /test_cells/Iin
    setfield ^ delay2 9999.9  // So absurdly long, it never comes on.
end


//
// This is the main function to calculate all f/I curves.
//

function do_fI
    setup_fI 1

    // Do for [NE] = 0 uM:

    set_NE 0.0

    disable_all_but_test_cell test_pyramidal_cell
    runfI \
        /test_cells/fI_pyr_noNE                     \
        pyr.save.noNE                               \
        /test_cells/Iin                             \
        /test_cells/test_pyramidal_cell             \
        0.1 1.0 -0.05                               \
        "test_pyramidal_Vm_noNE"                    \
        /test_cells/out/test_pyramidal_cell_Vm
    enable_all

    gen2spk test_pyramidal_Vm_noNE 0.1 1.0 1.2 -stepsize 0.0001

    disable_all_but_test_cell test_fb_inhib_cell
    runfI \
        /test_cells/fI_inhib                        \
        fb_inhib.save.noNE                          \
        /test_cells/Iin                             \
        /test_cells/test_fb_inhib_cell              \
        0.1 1.0 -0.1                                \
        "test_fb_inhib_Vm_noNE"                     \
        /test_cells/out/test_fb_inhib_cell_Vm
    enable_all

    gen2spk test_fb_inhib_Vm_noNE 0.1 1.0 1.2 -stepsize 0.0001

    disable_all_but_test_cell test_ff_inhib_cell
    runfI \
        /test_cells/fI_inhib                        \
        ff_inhib.save.noNE                          \
        /test_cells/Iin                             \
        /test_cells/test_ff_inhib_cell              \
        0.1 1.0 -0.1                                \
        "test_ff_inhib_Vm_noNE"                     \
        /test_cells/out/test_ff_inhib_cell_Vm
    enable_all

    gen2spk test_ff_inhib_Vm_noNE 0.1 1.0 1.2 -stepsize 0.0001

    disable_all_but_test_cell test_ff_fb_inhib_cell
    runfI \
        /test_cells/fI_inhib                        \
        ff_fb_inhib.save.noNE                       \
        /test_cells/Iin                             \
        /test_cells/test_ff_fb_inhib_cell           \
        0.1 1.0 -0.1                                \
        "test_ff_fb_inhib_Vm_noNE"                  \
        /test_cells/out/test_ff_fb_inhib_cell_Vm
    enable_all

    gen2spk test_ff_fb_inhib_Vm_noNE 0.1 1.0 1.2 -stepsize 0.0001

    // Now do for NE = 100 uM:

    set_NE 100.0

    disable_all_but_test_cell test_pyramidal_cell
    runfI \
        /test_cells/fI_pyr_NE                       \
        pyr.save.NE                                 \
        /test_cells/Iin                             \
        /test_cells/test_pyramidal_cell             \
        0.1 1.0 -0.05                               \
        "test_pyramidal_Vm_NE"                      \
        /test_cells/out/test_pyramidal_cell_Vm
    enable_all

    gen2spk test_pyramidal_Vm_NE 0.1 1.0 1.2 -stepsize 0.0001

    disable_all_but_test_cell test_fb_inhib_cell
    runfI \
        /test_cells/fI_inhib                        \
        fb_inhib.save.NE                            \
        /test_cells/Iin                             \
        /test_cells/test_fb_inhib_cell              \
        0.1 1.0 -0.1                                \
        "test_fb_inhib_Vm_NE"                       \
        /test_cells/out/test_fb_inhib_cell_Vm
    enable_all

    gen2spk test_fb_inhib_Vm_NE 0.1 1.0 1.2 -stepsize 0.0001

    disable_all_but_test_cell test_ff_inhib_cell
    runfI \
        /test_cells/fI_inhib                        \
        ff_inhib.save.NE                            \
        /test_cells/Iin                             \
        /test_cells/test_ff_inhib_cell              \
        0.1 1.0 -0.1                                \
        "test_ff_inhib_Vm_NE"                       \
        /test_cells/out/test_ff_inhib_cell_Vm
    enable_all

    gen2spk test_ff_inhib_Vm_NE 0.1 1.0 1.2 -stepsize 0.0001

    disable_all_but_test_cell test_ff_fb_inhib_cell
    runfI \
        /test_cells/fI_inhib                        \
        ff_fb_inhib.save.NE                         \
        /test_cells/Iin                             \
        /test_cells/test_ff_fb_inhib_cell           \
        0.1 1.0 -0.1                                \
        "test_ff_fb_inhib_Vm_NE"                    \
        /test_cells/out/test_ff_fb_inhib_cell_Vm
    enable_all

    gen2spk test_ff_fb_inhib_Vm_NE 0.1 1.0 1.2 -stepsize 0.0001

    echo
    echo Calculating f/I curve and input resistance/tau results
    echo for pyramidal, fb_inhib, ff_inhib and ff_fb_inhib cells...
    echo

    sh test_get_pyramidal_data
    sh test_get_fb_inhib_data
    sh test_get_ff_inhib_data
    sh test_get_ff_fb_inhib_data
end

