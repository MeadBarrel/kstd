function get_delta_v_for_inclination_change {
  // Assuming uninclined circular orbit
  parameter
    inc_,
    vessel_ is ship.

  local inc_2 is inc_/2.
  local delta_v is 2*vessel_:velocity:orbit:mag * sin(inc_2).
  return lexicon("mag", delta_v, "normal", delta_v*cos(inc_2), "prograde", -delta_v*sin(inc_2)).
}
