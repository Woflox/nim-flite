import flite

{.push callconv: cdecl, dynlib: flite.LibName.}

proc registerCmuUsKal16*(voxdir: cstring): Voice {.
  importc: "register_cmu_us_kal16" .}

{.pop.}
