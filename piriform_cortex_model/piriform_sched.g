// genesis

// Simulation schedule for the piriform cortex simulation.

function setup_piriform_schedule
    deletetasks

    addtask Simulate /##[CLASS=buffer]  -action INIT
    addtask Simulate /##[CLASS=segment] -action INIT

    // Make sure odor_in objects are simulated early in the schedule.
    // Ditto for neuromodulation control objects.
    // NOTE: even though there is a special "odor" and "mod" class
    // I prefer to identify these objects individually.
    addtask Simulate /##[OBJECT=odor_in]        -action PROCESS
    addtask Simulate /##[OBJECT=neuromod_in]    -action PROCESS
    addtask Simulate /##[OBJECT=neuromod]       -action PROCESS

    // Olfactory_bulb objects, in class `bulb', have to be simulated
    // AFTER the `odor_in' objects but BEFORE objects in class `spiking'
    // (mainly the `spikebuffer' objects).

    addtask Simulate /##[CLASS=bulb]        -action PROCESS

    addtask Simulate /##[CLASS=buffer]      -action PROCESS
    addtask Simulate /##[CLASS=projection]  -action PROCESS
    addtask Simulate /##[CLASS=spiking]     -action PROCESS
    addtask Simulate /##[CLASS=gate]        -action PROCESS

    // objects: compartment (hsolver), tabchannel, Ca_concen
    // compartment classes: segment membrane
    // Ca_concen classes:   segment concentration
    // tabchannel classes:  segment channel

    addtask Simulate /##[CLASS=segment][CLASS!=membrane][CLASS!=gate][CLASS!=concentration][CLASS!=channel] -action PROCESS

    // The hsolver overrides the compartment (membrane) action.
    addtask Simulate /##[CLASS=hsolver]             -action PROCESS
    // ... but not all cells use the hsolver.
    addtask Simulate /##[CLASS=membrane]            -action PROCESS

    addtask Simulate /##[CLASS=concentration]       -action PROCESS
    addtask Simulate /##[CLASS=channel]             -action PROCESS

    // NOTE: even though there is a special "field" class for
    // several of the following objects I prefer to add them
    // individually to the schedule so I can simulate them in the
    // right order.
    addtask Simulate /##[OBJECT=field_potential]    -action PROCESS
    addtask Simulate /##[OBJECT=virtual_electrode]  -action PROCESS

    addtask Simulate /##[CLASS=device]              -action PROCESS

    addtask Simulate /##[OBJECT=matlab_zout]        -action PROCESS
    addtask Simulate /##[OBJECT=avg_out]            -action PROCESS
    addtask Simulate /##[CLASS=output]              -action PROCESS

    resched
end

setup_piriform_schedule

