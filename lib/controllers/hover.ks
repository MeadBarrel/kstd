download_ine("lib/math/vectors/get_vector_heading.ks"). run once get_vector_heading.
download_ine("lib/vessel/get_max_acc.ks"). run once get_max_acc.
download_ine("lib/std.ks"). run once std.
download_ine("lib/math/clamp.ks"). run once clamp.


set HOVER_MAX_A_H to 30.
set HOVER_A_H_FACTOR to 2.
set HOVER_A_V_FACTOR to 2.
set HOVER_MAX_DEVIATION to 90.


set hover_a to V(0, 0, 0).
set hover_v_v to 0.
set hover_v_h to V(0, 0, 0).
set hover_a_h to V(0, 0, 0).
set hover_a_v to 0.
lock hover_a_h_max to sqrt(get_max_acc()^2 - 0.99*min(get_max_acc(), hover_a_v)^2) * 0.95.
lock hover_steering to heading(
  get_vector_heading(hover_a_h),
  90-min(HOVER_MAX_DEVIATION, arctan2(min(hover_a_h_max, hover_a_h:mag), hover_a_v))
).
set hover_pitch to 90.
set hover_throttle to 0.


function hover_control_by_a_h_a_v {
  // Control by vertical and horisontal acceleration
  lock hover_a to hover_a_h + hover_a_v.
}

function hover_control_by_a {
  // Control by acceleration vector
  lock hover_a_h to vxcl(up:vector, hover_a).
  lock hover_a_v to sqrt(hover_a:sqrmagnitude-hover_a_h:sqrmagnitude).
}


function _velocity_control_h {
  local v_h_c is hover_v_h - vxcl(up:vector, ship:velocity:surface).
  set v_h_c to v_h_c:normalized * min(HOVER_MAX_A_H, v_h_c:mag/HOVER_A_H_FACTOR).
  return v_h_c.
}

function _velocity_control_v {
  return ((hover_v_v-ship:verticalspeed)*HOVER_A_V_FACTOR) + g().
}

function hover_control_by_v_h_v_v {
  // Control by vertical and horisontal velocity
  // inputs: hover_v_h, hover_v_v, HOVER_MAX_A_H, HOVER_A_H_FACTOR, HOVER_A_V_FACTOR
  lock hover_a_h to _velocity_control_h.
  lock hover_a_v to _velocity_control_v.
  lock hover_a to hover_a_h + up:vector*hover_a_v.
}

function hover_control_by_v_h_a_v {
  // Control by horisontal velocity and vertical acceleration
  // inputs: hover_v_h, hover_a_v, HOVER_MAX_A_H, HOVER_A_H_FACTOR
  unlock hover_a_v.
  lock hover_a_h to _velocity_control_h.
  lock hover_a to hover_a_h + (up:vector*hover_a_v) .
}

function hover_tick {
  set hover_pitch to VANG(HEADING(0, 90):VECTOR, SHIP:FACING:VECTOR).
  set hover_throttle to clamp(((hover_a_v / get_max_acc())/ cos(hover_pitch)), 0.0, 1.0).
}

function hover_lock_all {
  lock throttle to hover_throttle.
  lock steering to hover_steering.
}

print "loaded:hover".
