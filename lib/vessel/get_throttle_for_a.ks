download_ine("lib/vessel/get_max_acc.ks"). run once get_max_acc.


function get_throttle_for_a {
  parameter
    a,
    vessel_ is ship.

    return a / get_max_acc(vessel_).
}