// genesis

//
// ff_inhib_cell.g: defines layer 1 feedforward inhibitory cells in piriform
//                  cortex.
//

function make_ff_inhib_cells
    if (!{exists /cell_library})
        echo ERROR! must create /cell_library before creating cell models!
        return
    end

    //
    // Define the new channel library (if necessary) and load in the cells.
    //

    make_ff_inhib_channel_library
    readcell ff_inhib.p    /cell_library/ff_inhib_cell
    readcell ff_fb_inhib.p /cell_library/ff_fb_inhib_cell
end






