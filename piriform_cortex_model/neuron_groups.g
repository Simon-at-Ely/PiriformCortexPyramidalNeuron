// genesis

//
// neuron_groups.g
//     Define non-overlapping groups of neurons in the olfactory bulb
//     and cortex.  This is needed to set up non-random connection
//     patterns.
//

create neutral /groups

// Each mitral cell, each pyramidal neuron and each feedback
// inhibitory neuron is a member of one of several groups of neurons.

int i, j, count
int ngroups = 4
int pyramidal_neurons_per_line, interneurons_per_line
int group, line

if (scale == "small")
    pyramidal_neurons_per_line = 16
    interneurons_per_line      = 15
elif (scale == "medium-small")
    pyramidal_neurons_per_line = 20
    interneurons_per_line      = 19
elif (scale == "medium")
    pyramidal_neurons_per_line = 32
    interneurons_per_line      = 31
elif (scale == "large")
    pyramidal_neurons_per_line = 50
    interneurons_per_line      = 49
end


// Set up mitral cell groups.

int ninputs_per_group = BULB_N / ngroups
create intarray /groups/bulb
call ^ INITIALIZE {BULB_N}

count = 0

for (i = 0; i < ngroups; i = i + 1)
    for (j = 0; j < ninputs_per_group; j = j + 1)
        setfield /groups/bulb val[{count}] {i}
        count = count + 1
    end
end


// Set up pyramidal neuron groups.

// We don't use strictly consecutive group numbers but rather stagger
// groups at the beginning of odd-numbered lines.  This makes the overall
// pattern of group identities in 2D space more even.

create intarray /groups/pyramidal
call ^ INITIALIZE {PIRIFORM_N_PYRAMIDAL}

count =  0
group =  0
line  = -1  // Bogus starting value.

for (i = 0; i < PIRIFORM_N_PYRAMIDAL; i = i + 1)
    // Calculate which line we're on.
    if (i % pyramidal_neurons_per_line == 0)
        // There's a new line.
        line = line + 1

        // Start at group 2 for odd-numbered lines only.
        if (line % 2 != 0)
            group = 2
        else
            group = 0
        end
    else  // Same line as before.
        // Select next group.
        group = group + 1

        if (group % ngroups == 0)
            group = 0
        end
    end

    //echo Pyramidal neuron {i} is in group {group}
    setfield /groups/pyramidal val[{i}] {group}
end



// Set up feedback inhibitory neuron groups.

create intarray /groups/fb
call ^ INITIALIZE {PIRIFORM_N_FB_INHIB}

count =  0
group =  0
line  = -1  // Bogus starting value.

for (i = 0; i < PIRIFORM_N_FB_INHIB; i = i + 1)
    // Calculate which line we're on.
    if (i % interneurons_per_line == 0)
        // There's a new line.
        line = line + 1

        // Start at group 2 for odd-numbered lines only.
        if (line % 2 != 0)
            group = 2
        else
            group = 0
        end
    else  // Same line as before.
        // Select next group.
        group = group + 1

        if (group % ngroups == 0)
            group = 0
        end
    end

    //echo Feedback interneuron {i} is in group {group}
    setfield /groups/fb val[{i}] {group}
end

