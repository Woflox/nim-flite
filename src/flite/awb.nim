import flite

{.push callconv: cdecl, dynlib: flite.LibName.}

proc registerCmuUsAwb*(voxdir: cstring): Voice {.
  importc: "register_cmu_us_awb" .}

{.pop.}
