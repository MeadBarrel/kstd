download("lib/vessel/get_max_acc.ks"). run once get_max_acc.
download("lib/vessel/get_throttle_for_a.ks"). run once get_throttle_for_a.
download("lib/orbit/get_circular_orbit_v_at_alt.ks"). run once get_circular_orbit_v_at_alt.


// Non-atmospheric ascent to circular orbit with no specified radius.
function non_atm_ascent {
    parameter
        min_alt_, // Minimal altitude
        hdng_.    // Heading.

    // Initialisation
    set steering_ to 0.
    set throttle_ to 0.
    lock steering to steering_.
    lock throttle to throttle_.

    // Head straight up until apoapsis is at minimal altitude.
    set steering_ to up.
    set throttle_ to 1.
    wait until apoapsis > min_alt_.
    set throttle_ to 0.

    // Gravity turn.
    local lock v_ to heading(hdng_, 0):vector * get_circular_orbit_v_at_alt().
    local lock v_c to v_-ship:velocity:orbit.
    local lock t to v_c:mag / (get_max_acc()/2).
    lock steering_ to v_c.
    wait until eta:apoapsis < t+20.
    set warp to 0.
    wait until eta:apoapsis < t.
    until ship:obt:eccentricity < 0.0005 {
        if vectorangle(ship:facing:vector, steering_) > 1
            set throttle_ to 0.
        else {
            local a is v_c:mag.
            until (v_c:mag > a or a < 1) set a to a * 0.5.
            set throttle_ to get_throttle_for_a(a).
        }
    }

    // Finalisation
    set ship:control:pilotmainthrottle to 0.
    unlock steering.
    unlock throttle.
}
