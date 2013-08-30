// genesis

//
// piriform_outputs.g: recording the outputs of the piriform cortex
//                     simulation.
//

if (!{exists /out})
    create neutral /out
end

int i

//
// Various flags for extra outputs.
//

int output_synaptic_conductances = 0
int output_synaptic_currents     = 0
int output_ionic_conductances    = 0
int output_ionic_currents        = 0
int output_total_currents        = 0

//
// Pyramidal cells.
//
// We don't save data for every compartment because it isn't worth
// the extra I/O overhead.  Instead we choose a representative compartment
// for each region.
//

str compt
foreach compt (Ia_1 supIb_2 deepIb_2 soma basal_3)
    //
    // Membrane potentials.
    //

    create xview_out /out/pyramidal_{compt}
    setfield ^  leave_open 1  flush 1 filename {outdir}/pyramidal_{compt}
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt} \
        /out/pyramidal_{compt} SAVE Vm

    //
    // Total transmembrane currents.
    //

    if (output_total_currents)
       create xview_out /out/pyramidal_{compt}_Im
       setfield ^  leave_open 1  flush 1 filename \
           {outdir}/pyramidal_{compt}_Im
       useclock ^ 1
       addmsg /piriform_cortex/pyramidal_cell[]/{compt} \
           /out/pyramidal_{compt}_Im SAVE Im
    end
end


//
// Excitatory conductances/currents onto apical dendrites.
//

if (output_synaptic_conductances)
    str compt

    foreach compt (Ia_1)
        create xview_out /out/pyramidal_{compt}_aff_exc_Gk
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_aff_exc_Gk
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_aff_exc_syn \
            /out/pyramidal_{compt}_aff_exc_Gk SAVE Gk
    end

    foreach compt (supIb_3 supIb_2 deepIb_2)
        create xview_out /out/pyramidal_{compt}_assoc_exc_Gk
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_assoc_exc_Gk
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_assoc_exc_syn \
            /out/pyramidal_{compt}_assoc_exc_Gk SAVE Gk
    end
end


if (output_synaptic_currents)
    str compt

    foreach compt (Ia_1)
        create xview_out /out/pyramidal_{compt}_aff_exc_Ik
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_aff_exc_Ik
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_aff_exc_syn \
            /out/pyramidal_{compt}_aff_exc_Ik SAVE Ik
    end

    foreach compt (supIb_3 supIb_2 deepIb_2)
        create xview_out /out/pyramidal_{compt}_assoc_exc_Ik
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_assoc_exc_Ik
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_assoc_exc_syn \
            /out/pyramidal_{compt}_assoc_exc_Ik SAVE Ik
    end
end


//
// Inhibitory conductances/currents onto apical dendrites.
//

if (output_synaptic_conductances)
    str compt
    foreach compt (supIb_1 deepIb_3)
        create xview_out /out/pyramidal_{compt}_inh_1_Gk_1
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_1_Gk_1
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
            /out/pyramidal_{compt}_inh_1_Gk_1 SAVE Gk

        create xview_out /out/pyramidal_{compt}_inh_1_Gk_2
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_1_Gk_2
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
            /out/pyramidal_{compt}_inh_1_Gk_2 SAVE ch2_Gk
        create xview_out /out/pyramidal_{compt}_inh_1_Gk_3
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_1_Gk_3
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
            /out/pyramidal_{compt}_inh_1_Gk_3 SAVE ch3_Gk
    end

    foreach compt (deepIb_2 deepIb_1)
        create xview_out /out/pyramidal_{compt}_inh_0_Gk_1
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_0_Gk_1
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_0 \
            /out/pyramidal_{compt}_inh_0_Gk_1 SAVE Gk

        create xview_out /out/pyramidal_{compt}_inh_0_Gk_2
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_0_Gk_2
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_0 \
            /out/pyramidal_{compt}_inh_0_Gk_2 SAVE ch2_Gk
        create xview_out /out/pyramidal_{compt}_inh_0_Gk_3
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_0_Gk_3
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_0 \
            /out/pyramidal_{compt}_inh_0_Gk_3 SAVE ch3_Gk
    end
end

if (output_synaptic_currents)
    str compt
    foreach compt (supIb_1 deepIb_3)
        create xview_out /out/pyramidal_{compt}_inh_1_Ik_1
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_1_Ik_1
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
            /out/pyramidal_{compt}_inh_1_Ik_1 SAVE Ik

        create xview_out /out/pyramidal_{compt}_inh_1_Ik_2
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_1_Ik_2
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
            /out/pyramidal_{compt}_inh_1_Ik_2 SAVE ch2_Ik
        create xview_out /out/pyramidal_{compt}_inh_1_Ik_3
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_1_Ik_3
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
            /out/pyramidal_{compt}_inh_1_Ik_3 SAVE ch3_Ik
    end

    foreach compt (deepIb_2 deepIb_1)
        create xview_out /out/pyramidal_{compt}_inh_0_Ik_1
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_0_Ik_1
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_0 \
            /out/pyramidal_{compt}_inh_0_Ik_1 SAVE Ik

        create xview_out /out/pyramidal_{compt}_inh_0_Ik_2
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_0_Ik_2
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_0 \
            /out/pyramidal_{compt}_inh_0_Ik_2 SAVE ch2_Ik
        create xview_out /out/pyramidal_{compt}_inh_0_Ik_3
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_{compt}_inh_0_Ik_3
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_0 \
            /out/pyramidal_{compt}_inh_0_Ik_3 SAVE ch3_Ik
    end
end

//
// Voltage-dependent ionic currents onto the soma.
//

if (output_ionic_currents)
    str chan
    foreach chan (pyr_Na pyr_Na_pers pyr_Kdr pyr_Ka pyr_KM pyr_Ca pyr_Kahp)
        create xview_out /out/pyramidal_soma_{chan}
        setfield ^  leave_open 1  flush 1 \
            filename {outdir}/pyramidal_soma_{chan}
        useclock ^ 1
        addmsg /piriform_cortex/pyramidal_cell[]/soma/{chan} \
            /out/pyramidal_soma_{chan} SAVE Ik
    end
end


//
// Calcium concentration.
//

create xview_out /out/pyramidal_soma_Ca_conc
setfield ^  leave_open 1  flush 1 \
    filename {outdir}/pyramidal_soma_Ca_conc
useclock ^ 1
addmsg /piriform_cortex/pyramidal_cell[]/soma/pyr_Ca_conc \
       /out/pyramidal_soma_Ca_conc SAVE Ca


//
// Kahp_theta.
//

/*
create xview_out /out/pyramidal_soma_Kahp_theta
setfield ^  leave_open 1  flush 1 \
    filename {outdir}/pyramidal_soma_Kahp_theta
useclock ^ 1
addmsg /piriform_cortex/pyramidal_cell[]/soma/pyr_Kahp_theta \
    /out/pyramidal_soma_Kahp_theta SAVE Ik
*/


//
// Inhibitory conductances/currents onto soma.
//

if (output_synaptic_conductances)
    compt = "soma"
    create xview_out /out/pyramidal_{compt}_inh_ch1_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch1_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer2_3_inh_syn \
        /out/pyramidal_{compt}_inh_ch1_Gk SAVE Gk
    create xview_out /out/pyramidal_{compt}_inh_ch2_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch2_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer2_3_inh_syn \
        /out/pyramidal_{compt}_inh_ch2_Gk SAVE ch2_Gk
end

if (output_synaptic_currents)
    compt = "soma"
    create xview_out /out/pyramidal_{compt}_inh_ch1_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch1_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer2_3_inh_syn \
        /out/pyramidal_{compt}_inh_ch1_Ik SAVE Ik
    create xview_out /out/pyramidal_{compt}_inh_ch2_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch2_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer2_3_inh_syn \
        /out/pyramidal_{compt}_inh_ch2_Ik SAVE ch2_Ik
end

//
// Inhibitory conductances/currents onto selected dendritic compartments.
//

if (output_synaptic_conductances)
    compt = "Ia_1"
    create xview_out /out/pyramidal_{compt}_inh_ch1_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch1_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_3 \
        /out/pyramidal_{compt}_inh_ch1_Gk SAVE Gk

    create xview_out /out/pyramidal_{compt}_inh_ch2_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch2_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_3 \
        /out/pyramidal_{compt}_inh_ch2_Gk SAVE ch2_Gk

    create xview_out /out/pyramidal_{compt}_inh_ch3_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch3_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_3 \
        /out/pyramidal_{compt}_inh_ch3_Gk SAVE ch3_Gk


    compt = "supIb_2"
    create xview_out /out/pyramidal_{compt}_inh_ch1_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch1_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_2 \
        /out/pyramidal_{compt}_inh_ch1_Gk SAVE Gk

    create xview_out /out/pyramidal_{compt}_inh_ch2_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch2_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_2 \
        /out/pyramidal_{compt}_inh_ch2_Gk SAVE ch2_Gk

    create xview_out /out/pyramidal_{compt}_inh_ch3_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch3_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_2 \
        /out/pyramidal_{compt}_inh_ch3_Gk SAVE ch3_Gk


    compt = "deepIb_3"
    create xview_out /out/pyramidal_{compt}_inh_ch1_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch1_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
        /out/pyramidal_{compt}_inh_ch1_Gk SAVE Gk

    create xview_out /out/pyramidal_{compt}_inh_ch2_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch2_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
        /out/pyramidal_{compt}_inh_ch2_Gk SAVE ch2_Gk

    create xview_out /out/pyramidal_{compt}_inh_ch3_Gk
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch3_Gk
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
        /out/pyramidal_{compt}_inh_ch3_Gk SAVE ch3_Gk
end


if (output_synaptic_currents)
    compt = "Ia_1"
    create xview_out /out/pyramidal_{compt}_inh_ch1_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch1_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_3 \
        /out/pyramidal_{compt}_inh_ch1_Ik SAVE Ik

    create xview_out /out/pyramidal_{compt}_inh_ch2_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch2_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_3 \
        /out/pyramidal_{compt}_inh_ch2_Ik SAVE ch2_Ik

    create xview_out /out/pyramidal_{compt}_inh_ch3_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch3_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_3 \
        /out/pyramidal_{compt}_inh_ch3_Ik SAVE ch3_Ik


    compt = "supIb_2"
    create xview_out /out/pyramidal_{compt}_inh_ch1_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch1_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_2 \
        /out/pyramidal_{compt}_inh_ch1_Ik SAVE Ik

    create xview_out /out/pyramidal_{compt}_inh_ch2_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch2_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_2 \
        /out/pyramidal_{compt}_inh_ch2_Ik SAVE ch2_Ik

    create xview_out /out/pyramidal_{compt}_inh_ch3_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch3_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_2 \
        /out/pyramidal_{compt}_inh_ch3_Ik SAVE ch3_Ik


    compt = "deepIb_3"
    create xview_out /out/pyramidal_{compt}_inh_ch1_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch1_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
        /out/pyramidal_{compt}_inh_ch1_Ik SAVE Ik

    create xview_out /out/pyramidal_{compt}_inh_ch2_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch2_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
        /out/pyramidal_{compt}_inh_ch2_Ik SAVE ch2_Ik

    create xview_out /out/pyramidal_{compt}_inh_ch3_Ik
    setfield ^  leave_open 1  flush 1 filename \
        {outdir}/pyramidal_{compt}_inh_ch3_Ik
    useclock ^ 1
    addmsg /piriform_cortex/pyramidal_cell[]/{compt}/pyr_layer1_inh_syn_1 \
        /out/pyramidal_{compt}_inh_ch3_Ik SAVE ch3_Ik
end


//
// Spike times for all pyramidal cells.
// NOTE: this won't work on parallel genesis because a SPIKE message
//       can't have associated data.
//

create spike_recorder /out/pyramidal_spikes
setfield ^ filename {outdir}/pyramidal_spikes \
    flush 1 long_format 0 verbose 0

for (i = 0; i < PIRIFORM_N_PYRAMIDAL; i = i + 1)
    addmsg /piriform_cortex/pyramidal_cell[{i}]/soma/pyr_spikegen \
           /out/pyramidal_spikes SPIKE {i}
end


//
// Interneurons.  Here there is only one compartment per cell.
//

create xview_out /out/ff
setfield ^  leave_open 1  flush 1 filename {outdir}/ff
useclock ^ 1
addmsg /piriform_cortex/ff_inhib_cell[]/soma /out/ff SAVE Vm

create xview_out /out/ff_fb
setfield ^  leave_open 1  flush 1 filename {outdir}/ff_fb
useclock ^ 1
addmsg /piriform_cortex/ff_fb_inhib_cell[]/soma /out/ff_fb SAVE Vm


// Conductances and currents onto ff cells.

create xview_out /out/ff_Gk_aff
setfield ^  leave_open 1  flush 1 filename {outdir}/ff_Gk_aff
useclock ^ 1
addmsg /piriform_cortex/ff_inhib_cell[]/soma/ff_aff_exc_syn \
    /out/ff_Gk_aff SAVE Gk

create xview_out /out/ff_Ik_aff
setfield ^  leave_open 1  flush 1 filename {outdir}/ff_Ik_aff
useclock ^ 1
addmsg /piriform_cortex/ff_inhib_cell[]/soma/ff_aff_exc_syn \
    /out/ff_Ik_aff SAVE Ik


// Conductances and currents onto ff_fb cells.

create xview_out /out/ff_fb_Gk_aff
setfield ^  leave_open 1  flush 1 filename {outdir}/ff_fb_Gk_aff
useclock ^ 1
addmsg /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_aff_exc_syn \
    /out/ff_fb_Gk_aff SAVE Gk

create xview_out /out/ff_fb_Ik_aff
setfield ^  leave_open 1  flush 1 filename {outdir}/ff_fb_Ik_aff
useclock ^ 1
addmsg /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_aff_exc_syn \
    /out/ff_fb_Ik_aff SAVE Ik

create xview_out /out/ff_fb_Gk_assoc
setfield ^  leave_open 1  flush 1 filename {outdir}/ff_fb_Gk_assoc
useclock ^ 1
addmsg /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_assoc_exc_syn \
    /out/ff_fb_Gk_assoc SAVE Gk

create xview_out /out/ff_fb_Ik_assoc
setfield ^  leave_open 1  flush 1 filename {outdir}/ff_fb_Ik_assoc
useclock ^ 1
addmsg /piriform_cortex/ff_fb_inhib_cell[]/soma/ff_assoc_exc_syn \
    /out/ff_fb_Ik_assoc SAVE Ik


// Feedback interneurons.

create xview_out /out/fb
setfield ^  leave_open 1  flush 1 filename {outdir}/fb
useclock ^ 1
addmsg /piriform_cortex/fb_inhib_cell[]/soma /out/fb SAVE Vm

// Save the spike times for all interneurons
// NOTE: this won't work on parallel genesis because a SPIKE message
//       can't have associated data.

create spike_recorder /out/fb_inhib_spikes
setfield ^ filename {outdir}/fb_inhib_spikes \
    flush 1 long_format 0 verbose 0

for (i = 0; i < PIRIFORM_N_FB_INHIB; i = i + 1)
    addmsg /piriform_cortex/fb_inhib_cell[{i}]/soma/fb_spikegen \
           /out/fb_inhib_spikes SPIKE {i}
end

create spike_recorder /out/ff_inhib_spikes
setfield ^ filename {outdir}/ff_inhib_spikes \
    flush 1 long_format 0 verbose 0

for (i = 0; i < PIRIFORM_N_FF_INHIB; i = i + 1)
    addmsg /piriform_cortex/ff_inhib_cell[{i}]/soma/ff_spikegen \
           /out/ff_inhib_spikes SPIKE {i}
end

create spike_recorder /out/ff_fb_inhib_spikes
setfield ^ filename {outdir}/ff_fb_inhib_spikes \
    flush 1 long_format 0 verbose 0

for (i = 0; i < PIRIFORM_N_FF_FB_INHIB; i = i + 1)
    addmsg /piriform_cortex/ff_fb_inhib_cell[{i}]/soma/ff_fb_spikegen \
           /out/ff_fb_inhib_spikes SPIKE {i}
end


