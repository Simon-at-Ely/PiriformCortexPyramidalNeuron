/**** functions to output results ****/

function make_output(rootname) //
    str rootname, filename
    if ({exists {rootname}})
        call {rootname} RESET // this closes and reopens the file
        delete {rootname}
    end
    filename = {rootname} @ ".txt"
    create asc_file {rootname}
    setfield ^    flush 1    leave_open 1 filename {filename}
    setclock 1 {out_dt}
    useclock {rootname} 1
end







function do_out
    setclock 2 {out_dt}
    // Membrane Potential
    make_output {Mem_pot} 
    addmsg /{Cell_name}/soma {Mem_pot} SAVE Vm
    useclock /output/{Mem_pot} 2
    // Na 
    make_output {Na_curr} 
    addmsg /{Cell_name}/soma/ff_fb_Na {Na_curr} SAVE Ik
    useclock /output/{Na_curr} 2
    // Kdr
    make_output {Kdr_curr} 
    addmsg /{Cell_name}/soma/ff_fb_Kdr {Kdr_curr} SAVE Ik
    useclock /output/{Kdr_curr} 2
    // Ka
    make_output {Ka_curr} 
    addmsg /{Cell_name}/soma/ff_fb_Ka {Ka_curr} SAVE Ik
    useclock /output/{Ka_curr} 2
end
