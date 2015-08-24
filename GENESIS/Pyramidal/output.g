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
    addmsg /{Cell_name}/soma/Na {Na_curr} SAVE Ik
    useclock /output/{Na_curr} 2
    // Nap
    make_output {Nap_curr} 
    addmsg /{Cell_name}/soma/Na_pers {Nap_curr} SAVE Ik
    useclock /output/{Nap_curr} 2
    // Kdr
    make_output {Kdr_curr} 
    addmsg /{Cell_name}/soma/Kdr {Kdr_curr} SAVE Ik
    useclock /output/{Kdr_curr} 2
    // Ka
    make_output {Ka_curr} 
    addmsg /{Cell_name}/soma/Ka {Ka_curr} SAVE Ik
    useclock /output/{Ka_curr} 2
    // Km
    make_output {Km_curr} 
    addmsg /{Cell_name}/soma/KM {Km_curr} SAVE Ik
    useclock /output/{Km_curr} 2
    // Kahp
    make_output {Kahp_curr} 
    addmsg /{Cell_name}/soma/Kahp2 {Kahp_curr} SAVE Ik
    useclock /output/{Kahp_curr} 2
    // Ca
    make_output {Ca_curr} 
    addmsg /{Cell_name}/soma/Ca {Ca_curr} SAVE Ik
    useclock /output/{Ca_curr} 2
    // Ca Concentration
    make_output {Ca_conc} 
    addmsg /{Cell_name}/soma/Ca_conc {Ca_conc} SAVE Ca
    useclock /output/{Ca_conc} 2

end
