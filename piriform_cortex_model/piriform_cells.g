// genesis

//
// piriform_cells.g: creating and positioning the cell arrays.
//

include pyramidal.g
include fb_inhib.g
include ff_inhib.g

int i

if (!{exists /cell_library})
    create neutral /cell_library
    disable /cell_library
end

create neutral /piriform_cortex

// NOTE: The Z position of piriform cortex pyramidal cell somas is 0.0.


// ------------------------------------------------------------
// Pyramidal cells:
// ------------------------------------------------------------

echo Creating {PIRIFORM_N_PYRAMIDAL} pyramidal cells in a" " -n
echo {XSCALE} x {YSCALE} array.

// Ventral anterior piriform cortex:

create_element_grid /cell_library/pyramidal_cell_vAPC   \
        /piriform_cortex                                \
        {PIRIFORM_NX_PYRAMIDAL}                         \
        {PIRIFORM_NY_PYRAMIDAL}                         \
        -newname    "pyramidal_cell"                    \
        -delta      {PIRIFORM_DX_PYRAMIDAL}             \
                    {PIRIFORM_DY_PYRAMIDAL}             \
        -origin     {PIRIFORM_PYRAMIDAL_X_OFFSET}       \
                    {PIRIFORM_PYRAMIDAL_Y_OFFSET}       \
        -zposition  {PIRIFORM_PYRAMIDAL_Z_OFFSET}       \
        -mask       ellipse 0.0 0.0                     \
                    {PIRIFORM_X_CENTER}                 \
                    {PIRIFORM_Y_CENTER}                 \
        -debug      0

// The rest of piriform cortex:

create_element_grid /cell_library/pyramidal_cell    \
        /piriform_cortex                            \
        {PIRIFORM_NX_PYRAMIDAL}                     \
        {PIRIFORM_NY_PYRAMIDAL}                     \
        -delta      {PIRIFORM_DX_PYRAMIDAL}         \
                    {PIRIFORM_DY_PYRAMIDAL}         \
        -origin     {PIRIFORM_PYRAMIDAL_X_OFFSET}   \
                    {PIRIFORM_PYRAMIDAL_Y_OFFSET}   \
        -zposition  {PIRIFORM_PYRAMIDAL_Z_OFFSET}   \
        -all                                        \
        -hole       ellipse 0.0 0.0                 \
                    {PIRIFORM_X_CENTER}             \
                    {PIRIFORM_Y_CENTER}             \
        -replace                                    \
        -check                                      \
        -debug      0


// Create the hsolvers for all pyramidal cells.
// Use the Crank-Nicolson integration method (method 11).

for (i = 0; i < PIRIFORM_N_PYRAMIDAL; i = i + 1)
    new_hsolve /piriform_cortex/pyramidal_cell[{i}] 11
end


function show_pyramidal_cell_positions(fileflag, filename)
    int fileflag
    str filename

    float x, y, z
    int i

    if (fileflag)
        clearfile {filename}
    end

    for (i = 0; i < {PIRIFORM_N_PYRAMIDAL}; i = i + 1)
        x = {getfield /piriform_cortex/pyramidal_cell[{i}] x}
        y = {getfield /piriform_cortex/pyramidal_cell[{i}] y}
        z = {getfield /piriform_cortex/pyramidal_cell[{i}] z}

        if (fileflag)
            echo pyramidal {i}: {x} {y} {z} >> {filename}
        else
            echo Pyramidal cell {i}: x = {x} y = {y} z = {z}
        end
    end
end


// ------------------------------------------------------------
// Feedback inhibitory cells:
// ------------------------------------------------------------

echo Creating {PIRIFORM_N_FB_INHIB} feedback inhibitory cells" " -n
echo in a {XSCALE2} x {YSCALE2} array.

create_element_grid /cell_library/fb_inhib_cell     \
        /piriform_cortex                            \
        {PIRIFORM_NX_FB_INHIB}                      \
        {PIRIFORM_NY_FB_INHIB}                      \
        -delta      {PIRIFORM_DX_FB_INHIB}          \
                    {PIRIFORM_DY_FB_INHIB}          \
        -origin     {PIRIFORM_FB_INHIB_X_OFFSET}    \
                    {PIRIFORM_FB_INHIB_Y_OFFSET}    \
        -zposition  {PIRIFORM_FB_INHIB_Z_OFFSET}    \
        -debug      0


function show_fb_inhib_cell_positions(fileflag, filename)
    int fileflag
    str filename

    float x, y, z
    int i

    if (fileflag)
        clearfile {filename}
    end

    for (i = 0; i < {PIRIFORM_N_FB_INHIB}; i = i + 1)
        x = {getfield /piriform_cortex/fb_inhib_cell[{i}] x}
        y = {getfield /piriform_cortex/fb_inhib_cell[{i}] y}
        z = {getfield /piriform_cortex/fb_inhib_cell[{i}] z}

        if (fileflag)
            echo fb_inhib {i}: {x} {y} {z} >> {filename}
        else
            echo Feedback inhibitory cell {i}: x = {x} y = {y} z = {z}
        end
    end
end


// ------------------------------------------------------------
// Feedforward inhibitory cells:
// ------------------------------------------------------------

echo Creating {PIRIFORM_N_FF_INHIB} feedforward inhibitory cells" " -n
echo in a {XSCALE2} x {YSCALE2} array.

create_element_grid /cell_library/ff_inhib_cell     \
        /piriform_cortex                            \
        {PIRIFORM_NX_FF_INHIB}                      \
        {PIRIFORM_NY_FF_INHIB}                      \
        -delta      {PIRIFORM_DX_FF_INHIB}          \
                    {PIRIFORM_DY_FF_INHIB}          \
        -origin     {PIRIFORM_FF_INHIB_X_OFFSET}    \
                    {PIRIFORM_FF_INHIB_Y_OFFSET}    \
        -zposition  {PIRIFORM_FF_INHIB_Z_OFFSET}    \
        -debug      0


function show_ff_inhib_cell_positions(fileflag, filename)
    int fileflag
    str filename

    float x, y, z
    int i

    if (fileflag)
        clearfile {filename}
    end

    for (i = 0; i < {PIRIFORM_N_FF_INHIB}; i = i + 1)
        x = {getfield /piriform_cortex/ff_inhib_cell[{i}] x}
        y = {getfield /piriform_cortex/ff_inhib_cell[{i}] y}
        z = {getfield /piriform_cortex/ff_inhib_cell[{i}] z}

        if (fileflag)
            echo ff_inhib {i}: {x} {y} {z} >> {filename}
        else
            echo Feedforward inhibitory cell {i}: x = {x} y = {y} z = {z}
        end
    end
end



// ------------------------------------------------------------
// Feedforward/feedback inhibitory cells:
// ------------------------------------------------------------

echo Creating {PIRIFORM_N_FF_INHIB}" " -n
echo feedforward/feedback inhibitory cells in a {XSCALE2} x {YSCALE2} array.

create_element_grid /cell_library/ff_fb_inhib_cell      \
        /piriform_cortex                                \
        {PIRIFORM_NX_FF_FB_INHIB}                       \
        {PIRIFORM_NY_FF_FB_INHIB}                       \
        -delta      {PIRIFORM_DX_FF_FB_INHIB}           \
                    {PIRIFORM_DY_FF_FB_INHIB}           \
        -origin     {PIRIFORM_FF_FB_INHIB_X_OFFSET}     \
                    {PIRIFORM_FF_FB_INHIB_Y_OFFSET}     \
        -zposition  {PIRIFORM_FF_FB_INHIB_Z_OFFSET}     \
        -debug      0


function show_ff_fb_inhib_cell_positions(fileflag, filename)
    int fileflag
    str filename

    float x, y, z
    int i

    if (fileflag)
        clearfile {filename}
    end

    for (i = 0; i < {PIRIFORM_N_FF_FB_INHIB}; i = i + 1)
        x = {getfield /piriform_cortex/ff_fb_inhib_cell[{i}] x}
        y = {getfield /piriform_cortex/ff_fb_inhib_cell[{i}] y}
        z = {getfield /piriform_cortex/ff_fb_inhib_cell[{i}] z}

        if (fileflag)
            echo ff_fb_inhib {i}: {x} {y} {z} >> {filename}
        else
            echo Feedforward inhibitory cell {i}: x = {x} y = {y} z = {z}
        end
    end
end



// ------------------------------------------------------------
// Utilities:
// ------------------------------------------------------------

// Display all cell positions to stdout.

function show_positions
    show_mitral_cell_positions       0 ""
    show_pyramidal_cell_positions    0 ""
    show_fb_inhib_cell_positions     0 ""
    show_ff_inhib_cell_positions     0 ""
    show_ff_fb_inhib_cell_positions  0 ""
end


// Record the positions of all cells into a file.

function record_positions
    show_mitral_cell_positions       1 {outdir_pos}/mitral_positions
    show_pyramidal_cell_positions    1 {outdir_pos}/pyramidal_positions
    show_fb_inhib_cell_positions     1 {outdir_pos}/fb_inhib_positions
    show_ff_inhib_cell_positions     1 {outdir_pos}/ff_inhib_positions
    show_ff_fb_inhib_cell_positions  1 {outdir_pos}/ff_fb_inhib_positions
end

record_positions


