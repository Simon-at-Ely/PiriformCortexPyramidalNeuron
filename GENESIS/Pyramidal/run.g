// Create a library of prototype elements to be used by the cell reader


include pyr_chans.g




            
float tmax = 1.0      	  // max simulation run time (sec)
float dt = 20e-6	  // simulation time step
float out_dt = 0.0001 // output every 0.1 msec
setclock  0  {dt}               // set the simulation clock

str Cell_file = "pyramidal-only-ion-channels.p"  // name of the excitatory cell parameter file

str Cell_name = "pyramidal_cell"   // name of the excitatory cell

str Mem_pot = "membrane_potential" // filename prefix for membrane potential data
str Na_curr = "Na_current" // filename prefix for membrane potential data
str Nap_curr = "Nap_current" // filename prefix for membrane potential data
str Kdr_curr = "Kdr_current" // filename prefix for membrane potential data
str Ka_curr = "Ka_current" // filename prefix for membrane potential data
str Km_curr = "Km_current" // filename prefix for membrane potential data
str Kahp_curr = "Kahp_current" // filename prefix for membrane potential data
str Ca_curr = "Ca_current" // filename prefix for membrane potential data
str Ca_conc = "Ca_concentration" // filename prefix for membrane potential data
// include the graphics functions
include graphics

// include the output functions
include output
            

            
//===============================
//         Main Script
//===============================

make_pyramidal_channel_library      
readcell {Cell_file} /{Cell_name}


            
// make the control panel
make_control

            
// make the graph to display soma Vm and pass messages to the graph

make_Vmgraph
addmsg /{Cell_name}/soma /data/voltage PLOT Vm *volts *black

make_Nagraph
addmsg /{Cell_name}/soma/Na /dataNa/current PLOT Ik *ampere *black

make_Napgraph
addmsg /{Cell_name}/soma/Na_pers /dataNap/current PLOT Ik *ampere *black

make_Kdrgraph
addmsg /{Cell_name}/soma/Kdr /dataKdr/current PLOT Ik *ampere *black

make_Kagraph
addmsg /{Cell_name}/soma/Ka /dataKa/current PLOT Ik *ampere *black

make_Kmgraph
addmsg /{Cell_name}/soma/KM /dataKm/current PLOT Ik *ampere *black

make_Kahpgraph
addmsg /{Cell_name}/soma/Kahp2 /dataKahp/current PLOT Ik *ampere *black

make_Cagraph
addmsg /{Cell_name}/soma/Ca /dataCa/current PLOT Ik *ampere *black

make_Caconcgraph
addmsg /{Cell_name}/soma/Ca_conc /dataCaconc/current PLOT Ca *ampere *black


// Injection currents to  cells
setfield /{Cell_name}/soma inject 0.0e-9


// Write membrane potential and channel currents to files

//do_out
            
check
reset
step_tmax


