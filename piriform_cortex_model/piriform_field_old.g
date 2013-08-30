// genesis

//
// piriform_field.g: recording extracellular field potentials.
//     This file has been adapted from Matt Wilson's piriform cortex
//     simulation.
//

function field_electrode(path, target, x, y, z, r)
    str   path
    str   target
    float x, y, z, r

    float resistivity = 1.0e-5  // CHECKME: units?
    str   compt

    create piriform_field_electrode {path}
    setfield {path} scale {resistivity} x {x} y {y} z {z}

    foreach compt \
({el {target}/##[TYPE=mod_compartment][x>={x-r}][y>={y-r}][x<={x+r}][y<={y+r}]})
        addmsg {compt} {path} CURRENT Im 0.0
    end

    call {path} RECALC
end


function move_electrode(path, x, y, z)
    str path
    float x, y, z

    setfield {path} x {x} y {y} z {z}
    call {path} RECALC
end


//
// Set up an array of electrodes in the XY plane.
//

function electrode_array(fieldpath, path, nx, ny, xmin, ymin, \
         xspacing, yspacing, z, r)
    str   path
    int   nx, ny
    float xmin, ymin
    float xspacing, yspacing
    float x, y, z, r
    int   count = 0
    int   i, j

    xmin = xmin + xspacing / 2.0
    ymin = ymin + yspacing / 2.0

    for (i = 0; i < nx; i = i + 1)
        x = xmin + i * xspacing

        for (j = 0; j < ny; j = j + 1)
            y = ymin + j * yspacing

            //echo Setting up an electrode at x: {x} y: {y} z: {z}
            field_electrode {fieldpath}/electrode{z}[{count}] \
                {path} {x} {y} {z} {r}

            count = count + 1
        end
    end

    return count
end


//
// The electrode setup function AKA (French accent) "Ze electrode setup" :-)
//
// GLOBALS: PIRIFORM_X_EXTENT, PIRIFORM_Y_EXTENT, PIRIFORM_DX_PYRAMIDAL,
//          PIRIFORM_DY_PYRAMIDAL
//

function zelectrode_setup(nx, ny, z, r, name, xview_flag)
    int   nx, ny, xview_flag
    str   name
    float z, r

    int   count, i, j
    float xmin, ymin, xspacing, yspacing
    float x, y

    if (!{exists /field})
        create neutral /field
    end

    xmin     = 0.0
    ymin     = 0.0
    xspacing = {PIRIFORM_X_EXTENT / nx}
    yspacing = {PIRIFORM_Y_EXTENT / ny}

    echo "Setting up a "{nx}"x"{ny}"mm field electrode array "
    echo "  at depth "{z}" with x spacing "{xspacing}" and y spacing " -n
    echo {yspacing}
    echo "  radius = "{r}" dx = "{PIRIFORM_DX_PYRAMIDAL} -n
    echo " dy = "{PIRIFORM_DX_PYRAMIDAL}

    //
    // Note that only the pyramidal cells can generate net field potentials;
    // the currents into the inhibitory cells must sum to zero by
    // definition.
    //

    count = {electrode_array /field /piriform_cortex/pyramidal_cell[] \
            {nx} {ny} {xmin} {ymin} {xspacing} {yspacing} {z} {r}}

    echo {count} electrodes created.
    echo

    //
    // Record outputs to xview or xplot files, as the case may be.
    //

    if (!{exists /field/out})
        create neutral /field/out
    end

    if (xview_flag)
        create xview_out /field/out/field_{z}
        setfield ^  leave_open 1  flush 1 filename xview_field_{name}_{z}
        useclock ^ 1
        addmsg /field/electrode{z}[] /field/out/field_{z} SAVE field
    else
        for (i = 0; i < count; i = i + 1)
            x = {getfield /field/electrode{z}[{i}] x}
            y = {getfield /field/electrode{z}[{i}] y}

            create asc_file /field/out/field_{x}_{y}_{z}
            setfield ^ flush 1 leave_open 1 \
                filename xplot_field_{name}_{x}_{y}_{z}
            useclock ^ 1
            addmsg /field/electrode{z}[{i}] ^ SAVE field
        end
    end
end


//
// Set up electrodes for the entire piriform cortex at several
// different depths corresponding to different regions of cortex.
//

function electrode_setup(r, xview_flag)
    int   xview_flag
    float r

    int   nx, ny

    // Choose nx and ny to give about one electrode per square
    // millimeter.

    nx = PIRIFORM_X_EXTENT * 1.0e3
    ny = PIRIFORM_Y_EXTENT * 1.0e3

    zelectrode_setup {nx} {ny} -0.250e-3 {r} basal   {xview_flag}
    zelectrode_setup {nx} {ny}  0.0      {r} II      {xview_flag}
    zelectrode_setup {nx} {ny}  0.120e-3 {r} deepIb  {xview_flag}
    zelectrode_setup {nx} {ny}  0.290e-3 {r} supIb   {xview_flag}
    zelectrode_setup {nx} {ny}  0.400e-3 {r} Ia      {xview_flag}
end

