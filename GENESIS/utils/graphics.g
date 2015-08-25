/*===================================================================
  A GENESIS GUI with a simple control panel and graph, with axis scaling
  ====================================================================*/

               
include ../utils/xtools.g    // functions to make "scale" buttons, etc.

               
//===============================
//      Function Definitions
//===============================

               
function step_tmax
    step {tmax} -time
end

               
function overlaytoggle(widget)
    str widget
    setfield /##[TYPE=xgraph] overlay {getfield {widget} state}
end

               
//===============================
//    Graphics Functions
//===============================

               
function make_control
  create xform /control [10,50,250,180]
  create xlabel /control/label -hgeom 25 -bg cyan -label "CONTROL PANEL"
  create xbutton /control/RESET -wgeom 33%       -script reset
  create xbutton /control/RUN  -xgeom 0:RESET -ygeom 0:label -wgeom 33% \
         -script step_tmax
  create xbutton /control/QUIT -xgeom 0:RUN -ygeom 0:label -wgeom 34% \
        -script quit
  create xdialog /control/Injection -label "Injection (amperes)" \
                -value 0.5e-9 -script "set_inject <widget>"
  create xtoggle /control/overlay   -script "overlaytoggle <widget>"
  setfield /control/overlay offlabel "Overlay OFF" onlabel "Overlay ON" state 0

               
  xshow /control
end

               
function make_Vmgraph
    float vmin = -0.100
    float vmax = 0.05
    create xform /data [265,50,700,350]
    create xlabel /data/label -hgeom 10% -label "Pyramidal Cell Soma"
    create xgraph /data/voltage -hgeom 90% -title "Membrane Potential" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /data/voltage
    xshow /data
end



function make_Nagraph
    float vmin = 0.0
    float vmax = 3e-8
    create xform /dataNa [265,50,700,350]
    create xlabel /dataNa/label -hgeom 10% -label "Excitatory Cell"
    create xgraph /dataNa/current -hgeom 90% -title "Na current" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /dataNa/current
    xshow /dataNa
end

function make_Napgraph
    float vmin = 0.0
    float vmax = 1e-8
    create xform /dataNap [265,50,700,350]
    create xlabel /dataNap/label -hgeom 10% -label "Excitatory Cell"
    create xgraph /dataNap/current -hgeom 90% -title "Nap current" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /dataNap/current
    xshow /dataNap
end

function make_Kdrgraph
    float vmin = -1e-8
    float vmax = 0.0
    create xform /dataKdr [265,50,700,350]
    create xlabel /dataKdr/label -hgeom 10% -label "Excitatory Cell"
    create xgraph /dataKdr/current -hgeom 90% -title "Kdr current" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /dataKdr/current
    xshow /dataKdr
end

function make_Kagraph
    float vmin = -5e-9
    float vmax = 0.0
    create xform /dataKa [265,50,700,350]
    create xlabel /dataKa/label -hgeom 10% -label "Excitatory Cell"
    create xgraph /dataKa/current -hgeom 90% -title "Ka current" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /dataKa/current
    xshow /dataKa
end

function make_Kmgraph
    float vmin = -1e-8
    float vmax = 0.0
    create xform /dataKm [265,50,700,350]
    create xlabel /dataKm/label -hgeom 10% -label "Excitatory Cell"
    create xgraph /dataKm/current -hgeom 90% -title "Km current" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /dataKm/current
    xshow /dataKm
end

function make_Kahpgraph
    float vmin = -2e-10
    float vmax = 0.0
    create xform /dataKahp [265,50,700,350]
    create xlabel /dataKahp/label -hgeom 10% -label "Excitatory Cell"
    create xgraph /dataKahp/current -hgeom 90% -title "Kahp current" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /dataKahp/current
    xshow /dataKahp
end

function make_Cagraph
    float vmin = 0.0
    float vmax = 3e-10
    create xform /dataCa [265,50,700,350]
    create xlabel /dataCa/label -hgeom 10% -label "Excitatory Cell"
    create xgraph /dataCa/current -hgeom 90% -title "Ca current" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /dataCa/current
    xshow /dataCa
end

function make_Caconcgraph
    float vmin = 1e20
    float vmax = 1e23
    create xform /dataCaconc [265,50,700,350]
    create xlabel /dataCaconc/label -hgeom 10% -label "Excitatory Cell"
    create xgraph /dataCaconc/current -hgeom 90% -title "Ca concentration" -bg white
    setfield ^ XUnits sec YUnits Volts
    setfield ^ xmax {tmax} ymin {vmin} ymax {vmax}
    makegraphscale /dataCaconc/current
    xshow /dataCaconc
end

               
function set_inject(dialog,celltype)
    str dialog
    str celltype
    setfield /{getfield {celltype} value}/soma inject {getfield {dialog} value}
end
