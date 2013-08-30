// genesis

//
// piriform_connect.g: synaptic connections for the piriform cortex
// simulation.
//

echo Setting up synaptic connections...

include bulb_pyr_connect.g
include bulb_ff_connect.g
include bulb_ff_fb_connect.g
include piriform_pyr_fb_connect.g
include piriform_fb_pyr_connect.g
include piriform_fb_fb_connect.g
include piriform_pyr_ff_fb_connect.g
include piriform_ff_fb_pyr_connect.g
include piriform_ff_fb_ff_fb_connect.g
include piriform_ff_pyr_connect.g
// NOTE: there is NO piriform_pyr_ff_connect.g file.
include piriform_pyr_pyr_connect.g

