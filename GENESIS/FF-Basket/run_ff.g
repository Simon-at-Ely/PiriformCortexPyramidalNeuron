// Create a library of prototype elements to be used by the cell reader


include ff_chans.g




            
float tmax = 1.0      	  // max simulation run time (sec)
float dt = 20e-6	  // simulation time step
float out_dt = 0.0001 // output every 0.1 msec
setclock  0  {dt}               // set the simulation clock

str Cellfile = "ff_inhib.p"  // name of the excitatory cell parameter file

str Cell_name = "feedforward_cell"   // name of the excitatory cell
// include the graphics functions
include ../utils/graphics

            
str Mem_pot = "membrane_potential" // filename prefix for membrane potential data
str Na_curr = "Na_current" // filename prefix for membrane potential data           
str Kdr_curr = "Kdr_current" // filename prefix for membrane potential data
str Ka_curr = "Ka_current" // filename prefix for membrane potential data
        

// include the output functions
include output
            
//===============================
//         Main Script
//===============================

make_ff_inhib_channel_library
readcell {Cellfile} /{Cell_name}


            
// make the control panel
make_control

            
// make the graph to display soma Vm and pass messages to the graph
make_Vmgraph
addmsg /{Cell_name}/soma /data/voltage PLOT Vm *volts *blue

make_Nagraph
addmsg /{Cell_name}/soma/ff_Na /dataNa/current PLOT Ik *ampere *black

make_Kdrgraph
addmsg /{Cell_name}/soma/ff_Kdr /dataKdr/current PLOT Ik *ampere *black

make_Kagraph
addmsg /{Cell_name}/soma/ff_Ka /dataKa/current PLOT Ik *ampere *black

// Injection currents to  cells
setfield /{Cell_name}/soma inject 0.7e-9

do_out
            
check
reset
step_tmax
