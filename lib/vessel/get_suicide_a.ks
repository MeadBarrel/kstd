function get_suicide_a {
  parameter altf,    // Target altitude
    alts is ship:altitude,    // Starting altitude
    vs is ship:verticalspeed,      // Starting velocity
    body_ is body,   // Central body
    vessel_ is ship. // Vessel

  local g_ is g(alts, body).
  set g_ to g_ + (g(altf, body)-g_)/2.
  local y is alts-altf.
  local t is (sqrt(2*g_*y+vs^2)+vs)/g_.
  local a is ((g_*t-vs)/2) / t.
  return a.
}