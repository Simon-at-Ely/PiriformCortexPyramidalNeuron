// genesis

//
// fb_inhib_cell.g: define a layer 2/3 feedback inhibitory cell in piriform
//                  cortex.
//

function make_fb_inhib_cell
    if (!{exists /cell_library})
        echo ERROR! must create /cell_library before creating cell models!
        return
    end

    //
    // Define the new channel library (if necessary) and load in the cell.
    //

    make_fb_inhib_channel_library
    readcell fb_inhib.p /cell_library/fb_inhib_cell
end






