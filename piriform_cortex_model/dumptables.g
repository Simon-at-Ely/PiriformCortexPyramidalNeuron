// genesis

// definition of a function "dump_tabchan_tables" which dumps the contents
// of tabchannel tables into xplot files; it also changes A and B
// values into minf and tau values, which are more useful

function dump_tabchan_tables(path, gate, filename)
  str path, gate, filename
  str xunits, xunitstr

  if({{strcmp {gate} "X"} != 0} && \
     {{strcmp {gate} "Y"} != 0} && \
     {{strcmp {gate} "Z"} != 0})
        echo ERROR: gate type {gate} does not exist!
    return
  end

  str minffile = {filename} @ "." @ {gate} @ ".minf"
  str taufile  = {filename} @ "." @ {gate} @ ".tau"

  // The following assumes that X and Y gates are used for
  // voltage-dependent gates and Z gates are used for
  // concentration-dependent gates.

  if ({{strcmp {gate} "X"} == 0} || {{strcmp {gate} "Y"} == 0})
     xunits = "V"
  else
     xunits = "M"
  end

  // the following assumes that A and B gates have the same
  // values for xdivs, xmin, and xmax; if not, this won't work
  int   xdivs = {getfield {path} {gate}_A->xdivs}
  float xmin  = {getfield {path} {gate}_A->xmin}
  float xmax  = {getfield {path} {gate}_A->xmax}
  float xinc  = {(xmax - xmin)/xdivs}
  float x, Avalue, Bvalue, minfvalue, tauvalue
  int i
  float taumax = 0.0
  float taumin

  openfile  {minffile} w
  writefile {minffile} "/xintcpt " {xmin}
  writefile {minffile} "/yrange -0.2 1.2"
  xunitstr = "/xtitle" @  " " @ {xunits}
  writefile {minffile} {xunitstr}

  openfile  {taufile}  w
  writefile {taufile} "/xintcpt " {xmin}
  xunitstr = "/xtitle" @  " " @ {xunits}
  writefile {taufile} {xunitstr}
  writefile {taufile} "/ytitle sec"

  for(i = 0; i < xdivs; i = i + 1)
    x = xmin + i * xinc
    Avalue = {getfield {path} {gate}_A->table[{i}]}
    Bvalue = {getfield {path} {gate}_B->table[{i}]}
    minfvalue = Avalue / Bvalue
    tauvalue  = 1.0 / Bvalue
    if(tauvalue > taumax)
      taumax = tauvalue
    end
    writefile {minffile} {x} " " {minfvalue}
    writefile {taufile}  {x} " " {tauvalue}
  end
  taumin = -0.2 * taumax
  taumax =  1.2 * taumax
  writefile {taufile} "/yrange " {taumin} " " {taumax}
  closefile {minffile}
  closefile {taufile}
end



function dump_tabgate_tables(path, gate, filename)
  str path, gate, filename
  str xunits, xunitstr

  if({{strcmp {gate} "X"} != 0} && \
     {{strcmp {gate} "Y"} != 0} && \
     {{strcmp {gate} "Z"} != 0})
        echo ERROR: gate type {gate} does not exist!
    return
  end

  str minffile = {filename} @ "." @ {gate} @ ".minf"
  str taufile  = {filename} @ "." @ {gate} @ ".tau"

  // The following assumes that X and Y gates are used for
  // voltage-dependent gates and Z gates are used for
  // concentration-dependent gates.

  if({{strcmp {gate} "X"} == 0} || \
     {{strcmp {gate} "Y"} == 0})
     xunits = "V"
  else
     xunits = "M"
  end

  // the following assumes that alpha and beta gates have the same
  // values for xdivs, xmin, and xmax; if not, this won't work
  int   xdivs = {getfield {path} alpha->xdivs}
  float xmin  = {getfield {path} alpha->xmin}
  float xmax  = {getfield {path} alpha->xmax}
  float xinc  = {(xmax - xmin)/xdivs}
  float x, alpha_value, beta_value, minfvalue, tauvalue
  int i
  float taumax = 0.0
  float taumin

  openfile  {minffile} w
  writefile {minffile} "/xintcpt " {xmin}
  writefile {minffile} "/yrange -0.2 1.2"
  xunitstr = "/xtitle" @  " " @ {xunits}
  writefile {minffile} {xunitstr}

  openfile  {taufile}  w
  writefile {taufile} "/xintcpt " {xmin}
  xunitstr = "/xtitle" @  " " @ {xunits}
  writefile {taufile} {xunitstr}
  writefile {taufile} "/ytitle sec"

  for(i = 0; i < xdivs; i = i + 1)
    x = xmin + i * xinc
    alpha_value = {getfield {path} alpha->table[{i}]}
    beta_value = {getfield {path} beta->table[{i}]}
    minfvalue = alpha_value / (alpha_value + beta_value)
    tauvalue  = 1.0 / (alpha_value + beta_value)
    if(tauvalue > taumax)
      taumax = tauvalue
    end
    writefile {minffile} {x} " " {minfvalue}
    writefile {taufile}  {x} " " {tauvalue}
  end
  taumin = -0.2 * taumax
  taumax =  1.2 * taumax
  writefile {taufile} "/yrange " {taumin} " " {taumax}
  closefile {minffile}
  closefile {taufile}
end



function dump_single_table(path, gate, filename)
  str path, gate, filename
  str xunits, xunitstr

  if({{strcmp {gate} "X"} != 0} && \
     {{strcmp {gate} "Y"} != 0} && \
     {{strcmp {gate} "Z"} != 0})
        echo ERROR: gate type {gate} does not exist!
    return
  end

  str outfile = {filename} @ "." @ {gate}

  // The following assumes that X and Y gates are used for
  // voltage-dependent gates and Z gates are used for
  // concentration-dependent gates.

  if({{strcmp {gate} "X"} == 0} || \
     {{strcmp {gate} "Y"} == 0})
     xunits = "V"
  else
     xunits = "M"
  end

  int   xdivs = {getfield {path} table->xdivs}
  float xmin  = {getfield {path} table->xmin}
  float xmax  = {getfield {path} table->xmax}
  float xinc  = {(xmax - xmin)/xdivs}
  float x, outvalue
  int i
  float taumax = 0.0
  float taumin

  openfile  {outfile} w
  writefile {outfile} "/xintcpt " {xmin}
  writefile {outfile} "/yrange -0.2 1.2"
  xunitstr = "/xtitle" @  " " @ {xunits}
  writefile {outfile} {xunitstr}

  for(i = 0; i < xdivs; i = i + 1)
    x = xmin + i * xinc
    outvalue = {getfield {path} table->table[{i}]}
    writefile {outfile} {x} " " {outvalue}
  end

  closefile {outfile}
end


