// genesis

//
// piriform_field.g: recording extracellular field potentials.
//

//
// IMPORTANT NOTE: *Only* the currents from the pyramidal cells are
// used to calculate field potentials and current-source density (CSD)
// results.  The rationale for this is that the sources and sinks only
// line up in a predictable fashion for pyramidal cells (and not, for
// instance, for interneurons).
//

//
// Function to turn a set of numbers into a (string) list of
// x or y locations to place electrodes into.
//

function get_locs(numbers, start, delta)
    str   numbers  // convert this to a string
    float start, delta

    int   n
    str   outstr = ""
    float loc

    foreach n ({arglist {numbers}})
        loc = start + n * delta
        outstr = outstr @ {loc} @ " "
    end

    // Return the result as a string too.
    return outstr
end


//
// This function records over a large series of depths in a few locations
// in the cortex.  This is useful for doing CSD analysis off-line.
//

function set_up_depth_field_electrodes
    int nx, ny

    if (!{exists /field})
        create neutral /field
    end

    create neutral /field/depth

    int   i, j, k, count
    float x, y, z
    int   nz       = 60   // number of z electrodes

    // Place the electrodes so that they're in the same x-y position as
    // the feedback inhibitory cells i.e. equidistant from nearby
    // pyramidal cells.  This avoids a lot of problems which occur when
    // the electrodes are too close to certain groups of cells.
    // Note that the electrodes do not have to be placed evenly in the
    // x-y dimensions.

    nx = 2
    ny = 4

    str xlocs, ylocs  // string list of locations

    if (scale == "small")
        xlocs = {get_locs "2 5 8 11" \
            {PIRIFORM_FB_INHIB_X_OFFSET} {PIRIFORM_DX_FB_INHIB}}
        ylocs = {get_locs "1 4" \
            {PIRIFORM_FB_INHIB_Y_OFFSET} {PIRIFORM_DY_FB_INHIB}}
    elif (scale == "medium-small")
        xlocs = {get_locs "3 8 12 17" \
            {PIRIFORM_FB_INHIB_X_OFFSET} {PIRIFORM_DX_FB_INHIB}}
        ylocs = {get_locs "2 7" \
            {PIRIFORM_FB_INHIB_Y_OFFSET} {PIRIFORM_DY_FB_INHIB}}
    elif (scale == "medium")
        xlocs = {get_locs "4 10 16 22" \
            {PIRIFORM_FB_INHIB_X_OFFSET} {PIRIFORM_DX_FB_INHIB}}
        ylocs = {get_locs "3 9" \
            {PIRIFORM_FB_INHIB_Y_OFFSET} {PIRIFORM_DY_FB_INHIB}}
    end

    float zspacing =  20.0e-6
    float zmin     = -600.0e-6

    create field_potential /field/depth/fp
    setfield ^ max_electrodes_init {nx * ny * nz}
    setfield ^ radius -1.0     // Infinite radius.
    setfield ^ scale_factor 1.0e-5
    setfield ^ max_field 1.0
    useclock ^ 1

    call /field/depth/fp INITIALIZE
    create neutral /field/depth/xview  // for output
    create neutral /field/depth/matlab // for output

    // Position the field electrodes.
    count = 0
    int last_electrode
    i = 0

    foreach x ({arglist {xlocs}})
        j = 0

        foreach y ({arglist {ylocs}})
            echo Location of depth electrode {i} {j}: {x} {y}
            // Create virtual_electrode array for output.
            create neutral /field/depth/electrodes_{x}_{y}

            for (k = 0; k < nz; k = k + 1)
                z = zmin + k * zspacing
                last_electrode = {getfield /field/depth/fp nelectrodes}
                call /field/depth/fp ELECTRODE {x} {y} {z}

                // Q: will xview_out work correctly with z axis?
                create virtual_electrode \
                    /field/depth/electrodes_{x}_{y}/electrode[{k}]
                setfield ^ x {x} y {y} z {z}
                addmsg /field/depth/fp \
                   /field/depth/electrodes_{x}_{y}/electrode[{k}] FIELD \
                   electrode[{last_electrode}].field

                count = count + 1
            end

            // Create xview_out elements for output.

            create xview_out /field/depth/xview/out_{x}_{y}
            setfield ^  leave_open 1 flush 1  \
                filename {outdir}/xview_depth_field_{x}_{y}
            useclock ^ 1
            addmsg /field/depth/electrodes_{x}_{y}/electrode[] \
                /field/depth/xview/out_{x}_{y} SAVE field

            // Create matlab_zout elements for output

            create matlab_zout /field/depth/matlab/out_{x}_{y}
            // NOTE: we use `i', `j' rather than x, y for the filename
            // because matlab can't handle decimal points or minus
            // signs in names.  Therefore, you must keep track of
            // this yourself.  `i' and `j' are only used to label
            // the different csd outputs, and not to compute locations.
            setfield ^ flush 1 filename {outdir}/matlab_depth_field_{i}_{j}
            useclock ^ 1
            addmsg /field/depth/electrodes_{x}_{y}/electrode[]   \
                   /field/depth/matlab/out_{x}_{y} SAVE field

            j = j + 1
        end

        i = i + 1
    end

    echo {count} field potential depth electrodes set up.

    //
    // Add the messages from the current sources.
    //

    if (FP_CSD_SYNAPTIC_ONLY)
        // This records only the synaptic currents.  This is to more closely
        // match Haberly's data, which suggests that the relative amplitudes
        // of the voltage-dependent currents is considerably smaller that
        // that of the synaptic currents.  However, it's bullshit in that
        // we can't get the return currents through the membrane from this.

        str chan
        int count = 0

        // Layer 1a excitatory synapses.
        foreach chan \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=mod_facsynchan_wNMDA]})
            addmsg {chan} /field/depth/fp CURRENT Ik
            addmsg {chan} /field/depth/fp CURRENT NMDA_Ik
            count = count + 1
        end


        // Layer 1b excitatory synapses and layer 3 excitatory synapses.
        foreach chan \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=mod_facsynchan2_wNMDA]})
            addmsg {chan} /field/depth/fp CURRENT Ik
            addmsg {chan} /field/depth/fp CURRENT NMDA_Ik
            count = count + 1
        end

        // External input.
        foreach chan \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=mod_synchan_wNMDA]})
            addmsg {chan} /field/depth/fp CURRENT Ik
            addmsg {chan} /field/depth/fp CURRENT NMDA_Ik
            count = count + 1
        end

        // Inhibitory synapses.
        foreach chan \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=triple_depsynchan]})
            addmsg {chan} /field/depth/fp CURRENT Ik
            addmsg {chan} /field/depth/fp CURRENT ch2_Ik
            addmsg {chan} /field/depth/fp CURRENT ch3_Ik
            count = count + 1
        end

        foreach chan \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=triple_synchan]})
            addmsg {chan} /field/depth/fp CURRENT Ik
            addmsg {chan} /field/depth/fp CURRENT ch2_Ik
            addmsg {chan} /field/depth/fp CURRENT ch3_Ik
            count = count + 1
        end

        foreach chan \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=double_depsynchan]})
            addmsg {chan} /field/depth/fp CURRENT Ik
            addmsg {chan} /field/depth/fp CURRENT ch2_Ik
            count = count + 1
        end

        foreach chan \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=double_synchan]})
            addmsg {chan} /field/depth/fp CURRENT Ik
            addmsg {chan} /field/depth/fp CURRENT ch2_Ik
            count = count + 1
        end

        echo Recording currents from {count} synaptic channels.
    else
        str compt

        // This records the currents from ALL compartments.
        foreach compt \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=mod_compartment]})
            addmsg {compt} /field/depth/fp CURRENT Im
        end

/*
        // This records the currents from all compartments but the soma.
        // That's to reduce the visual impact of the huge somatic currents.
        foreach compt \
            ({el /piriform_cortex/pyramidal_cell[]/##[TYPE=mod_compartment]})
            if ({strstr soma {compt}} != 1)
                addmsg {compt} /field/depth/fp CURRENT Im
            end
        end
*/
    end

    // Recalculate the positions to the electrodes.
    call /field/depth/fp RECALC
end


// >>> FIXME: Fix up the surface field stuff to work like the
// depth field stuff!

//
// This function records over a large series of (x,y) positions at
// a single z level in the cortex.  It also generates an average
// "EEG" trace.
//

function set_up_surface_field_electrodes(z, nx, ny)
    float z, nx, ny

    // NOTE: a `z' value of 0.5e-3 is just above the distalmost
    // point on the pyramidal cells.

    if (!{exists /field})
        create neutral /field
    end

    create neutral /field/surface

    create field_potential /field/surface/fp
    setfield ^ max_electrodes_init {nx * ny}
    setfield ^ radius -1.0     // Infinite radius.
    setfield ^ scale_factor 1.0e-5
    setfield ^ max_field 1.0
    useclock ^ 1

    call /field/surface/fp INITIALIZE

    // Position the field electrodes.

    int i, j, count
    float x, y

    float xspacing =  {PIRIFORM_X_EXTENT / nx}
    float yspacing =  {PIRIFORM_Y_EXTENT / ny}
    float xmin     =  xspacing / 2.0
    float ymin     =  yspacing / 2.0

    count = 0
    int last_electrode

    // Create virtual_electrode array for output.
    create neutral /field/surface/electrodes

    for (i = 0; i < nx; i = i + 1)
        x = xmin + i * xspacing

        for (j = 0; j < ny; j = j + 1)
            y = ymin + j * yspacing

            last_electrode = {getfield /field/surface/fp nelectrodes}
            call /field/surface/fp ELECTRODE {x} {y} {z}

            create virtual_electrode \
                    /field/surface/electrodes/electrode[{count}]
            setfield ^ x {x} y {y} z {z}
            addmsg /field/surface/fp \
                   /field/surface/electrodes/electrode[{count}] FIELD \
                   electrode[{last_electrode}].field

            count = count + 1
        end
    end

    // Create xview_out element for output.

    create xview_out /field/surface/xview
    setfield ^  leave_open 1 flush 1 filename {outdir}/xview_surface_field
    useclock ^ 1
    addmsg /field/surface/electrodes/electrode[]  \
           /field/surface/xview SAVE field

    echo {count} field potential surface electrodes set up.

    // Add the messages from the current sources.
    str compt

    foreach compt \
({el /piriform_cortex/pyramidal_cell[]/##[TYPE=mod_compartment]})
        addmsg {compt} /field/surface/fp CURRENT Im
    end

    // Calculate the average of the surface field potentials.

    create avg_out /field/surface/avg
    setfield ^ flush 1 filename {outdir}/avg_field
    useclock ^ 1
    addmsg /field/surface/electrodes/electrode[]  \
           /field/surface/avg SAVE field

    // Recalculate the positions to the electrodes.
    call /field/surface/fp RECALC
end



