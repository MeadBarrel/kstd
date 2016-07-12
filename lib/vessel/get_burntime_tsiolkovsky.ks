download("lib/vessel/get_total_isp.ks"). run once get_total_isp.
download("lib/std.ks"). run once std.


function tsiolkovsky_burn_time {
  parameter
    dv.

  local g0 is g(0, Kerbin).
  local isp is total_isp()*g0.
  local end_mass is ship:mass / constant:e^(dv / isp).
  local t is (ship:mass - end_mass) / (ship:availablethrust / isp).
  return t.
}
