// genesis

//
// piriform_weight_dump.g: this file contains functions to dump xview
//     files which represent the different synaptic weight distributions
//     set in piriform_params_conn.g.
//

function dump_weights
    echo Dumping synaptic weights...

    dump_bulb_to_pyr_weights
    dump_bulb_to_ff_weights
    dump_bulb_to_ff_fb_weights
    dump_pyr_to_pyr_local_weights
    dump_pyr_vapc_to_pyr_lr_weights
    dump_pyr_dapc_to_pyr_lr_weights
    dump_pyr_ppc_to_pyr_lr_weights
    dump_pyr_fb_weights
    dump_fb_pyr_weights
    dump_fb_fb_weights
    dump_pyr_ff_fb_weights
    dump_ff_fb_pyr_weights
    dump_ff_fb_ff_fb_weights
    dump_ff_pyr_weights
end


