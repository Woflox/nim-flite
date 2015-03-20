import flite

{.push callconv: cdecl, dynlib: flite.LibName.}

proc registerCmuUsKal*(voxdir: cstring): Voice {.
  importc: "register_cmu_us_kal" .}

{.pop.}
