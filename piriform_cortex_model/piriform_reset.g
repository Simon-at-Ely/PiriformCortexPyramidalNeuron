// genesis

// Function to reset the piriform cortex simulation.

//
// This function gets around the random reset property of genesis
// by first resetting objects whose states affect the resetting of
// other objects.  So far this only includes the neuromod object,
// which has to be reset before the mod_compartment object.
//

extern get_NE

// This used to be an extern, but weird things started happening,
// and I don't trust genesis.  In other words, extern is fucked!!!

function restore_cell_for_sim(path, savefile)
    str path, savefile

    restore {savefile} -root_path {path}
end


function piriform_reset
    int i

    call /##[OBJECT=neuromod] RESET
    reset
    reset

    //
    // Load the steady-state state values into all cells.
    //

    float NE = {get_NE}

    str pyr_save_file
    str pyr_vAPC_save_file
    str fb_inhib_save_file
    str ff_inhib_save_file
    str ff_fb_inhib_save_file

    if (NE > 0.0)
        pyr_save_file         = "pyr.save.NE"
        pyr_vAPC_save_file    = "pyr_vAPC.save.NE"
        fb_inhib_save_file    = "fb_inhib.save.NE"
        ff_inhib_save_file    = "ff_inhib.save.NE"
        ff_fb_inhib_save_file = "ff_fb_inhib.save.NE"
    else
        pyr_save_file         = "pyr.save.noNE"
        pyr_vAPC_save_file    = "pyr_vAPC.save.noNE"
        fb_inhib_save_file    = "fb_inhib.save.noNE"
        ff_inhib_save_file    = "ff_inhib.save.noNE"
        ff_fb_inhib_save_file = "ff_fb_inhib.save.noNE"
    end


    // Pyramidal cells.
    for (i = 0; i < PIRIFORM_N_PYRAMIDAL; i = i + 1)
        float x, y
        str region

        x = {getfield /piriform_cortex/pyramidal_cell[{i}] x}
        y = {getfield /piriform_cortex/pyramidal_cell[{i}] y}
        region = {get_region {x} {y}}

        if (region == "VAPC")
            restore_cell_for_sim /piriform_cortex/pyramidal_cell[{i}] \
                {pyr_vAPC_save_file}
        else
            restore_cell_for_sim /piriform_cortex/pyramidal_cell[{i}] \
                {pyr_save_file}
        end
    end


    // Feedback inhibitory cells.
    for (i = 0; i < PIRIFORM_N_FB_INHIB; i = i + 1)
        restore_cell_for_sim /piriform_cortex/fb_inhib_cell[{i}] \
            {fb_inhib_save_file}
    end

    // Feedforward inhibitory cells.
    for (i = 0; i < PIRIFORM_N_FF_INHIB; i = i + 1)
        restore_cell_for_sim /piriform_cortex/ff_inhib_cell[{i}] \
            {ff_inhib_save_file}
    end

    // Feedforward/feedback inhibitory cells.
    for (i = 0; i < PIRIFORM_N_FF_FB_INHIB; i = i + 1)
        restore_cell_for_sim /piriform_cortex/ff_fb_inhib_cell[{i}] \
            {ff_fb_inhib_save_file}
    end
end
