import flite

{.push callconv: cdecl, dynlib: flite.LibName.}

proc registerCmuTimeAwb*(voxdir: cstring): Voice {.
  importc: "register_cmu_time_awb" .}

{.pop.}
