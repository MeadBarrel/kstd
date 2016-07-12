download_ine("lib/math/vectors/get_vector_heading.ks"). run once get_vector_heading.
download_ine("lib/math/vectors/get_vector_to_latlng.ks"). run once get_vector_to_latlng.
download_ine("lib/controllers/hover.ks"). run once hover.
download_ine("lib/vessel/get_max_acc.ks"). run once get_max_acc.
download_ine("lib/vessel/get_throttle_for_a.ks"). run once get_throttle_for_a.
download_ine("lib/vessel/get_suicide_a.ks"). run once get_suicide_a.
download_ine("lib/math/clamp.ks"). run once clamp.
download_ine("lib/std.ks"). run once std.


function kill_hvel_with_main_engines {
  lock v0 to heading(get_vector_heading(ship:velocity:surface), 0):vector * ship:groundspeed.
  lock d to (-v0):direction.

  lock steering to d.
  until ship:groundspeed < 1 {
    if (facing:vector-d:vector):mag >= 0.05 {
      lock throttle to 0.
      wait until (facing:vector-d:vector):mag < 0.01.
    }
    local a is get_max_acc().
    until (v0:mag > a or a < 1) set a to a * 0.5.
    lock throttle to get_throttle_for_a(a).
  }
  unlock throttle.
  unlock steering.
}


function guided_descent {
  declare parameter geo_pos.
  declare parameter pos_alt.

  local lock tgt_vector to get_vector_to_latlng(geo_pos).
  local lock x to tgt_vector:mag.
  local lock y to ship:altitude - pos_alt.

  local vd_tgt is vecdraw(
    ship:position, tgt_vector,
    RGB(1,0,0), "TARGET: "+x, 1.0, True, 0.2
  ).

  hover_lock_all().
  hover_control_by_v_h_a_v().
  until y <= 0.25 {
    set vd_tgt:vec to tgt_vector.
    set vd_tgt:label to "TARGET: "+x.

    local v_ is 150.
    if x < 5 set v_ to 0.
    else if x < 30 set v_ to x/35.
    else if x < 100 set v_ to x^0.4.
    else if x < 3000 set v_ to x^0.6.

    set hover_v_h to tgt_vector:normalized * v_.

    set HOVER_MAX_DEVIATION to 90.
    local sa is get_suicide_a(pos_alt).
    print (sa).
    if x > 5 set hover_a_v to sa.
    else if get_throttle_for_a(sa) > 0.8 set hover_a_v to sa.
    else {
      set HOVER_MAX_DEVIATION to 2.
      set hover_a_v to 0.
    }

    hover_tick().
  }
  set vd_tgt:show to false.
}


function suicide_descent {
  declare parameter geo_pos.
  declare parameter pos_alt.

  kill_hvel_with_main_engines().
  guided_descent(geo_pos, pos_alt).
}
