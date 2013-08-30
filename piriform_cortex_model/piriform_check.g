// genesis

//
// piriform_check.g: checking the piriform cortex simulation.
//

//
// NOTE: Ideally, we could just type "check" and everything would work
//       correctly.  However, we can't do this for the pyramidal cell
//       mod_compartments because they've been taken over by the hsolver.
//       This is also a pain in the ass because the normal `check' function
//       will ignore all elements that don't have CHECK actions; this
//       function will not.
//

function piriform_check
    call \
/##[OBJECT!=mod_compartment][OBJECT!=neutral][OBJECT!=hsolve][OBJECT!=xview_out][OBJECT!=asc_file] CHECK

    call /piriform_cortex/ff_inhib_cell/#[OBJECT=mod_compartment] CHECK
    call /piriform_cortex/ff_fb_inhib_cell/#[OBJECT=mod_compartment] CHECK
    call /piriform_cortex/fb_inhib_cell/#[OBJECT=mod_compartment] CHECK
end

