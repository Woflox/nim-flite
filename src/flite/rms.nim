import flite

{.push callconv: cdecl, dynlib: flite.LibName.}

proc registerCmuUsRms*(voxdir: cstring): Voice {.
  importc: "register_cmu_us_rms" .}

{.pop.}
