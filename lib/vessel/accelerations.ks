download("lib/vessel/get_max_acc.ks"). run once get_max_acc.


function get_current_acc {
  return ship:facing:vector * (get_max_acc()*throttle).
}

function get_vertical_acc {
  return vdot(current_acc(), up:vector).
}

function get_ground_acc {
  return vxcl(up:vector, get_current_acc()).
}
