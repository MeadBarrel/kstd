download("lib/orbit/get_circular_orbit_v_at_alt.ks"). run once get_circular_orbit_v_at_alt.
download("lib/math/vectors/get_vector_to_latlng.ks"). run once get_vector_to_latlng.
download("lib/math/vectors/get_vector_heading.ks"). run once get_vector_heading.
download("lib/vessel/get_max_acc.ks"). run once get_max_acc.


function orbit_to_geoposition {
    parameter
            pos_,
            distance is 100,
            warp_ is True.

    function correction {
        set steering_ to heading(get_vector_heading(a_h), 0).
        if v_h_c:mag > 1 and vectorangle(ship:facing:vector, steering_:vector) < 1 and vectorangle(ship:velocity:orbit, vec) < 80 {
            set throttle_ to a_h:mag/get_max_acc().
        } else set throttle_ to 0.
    }

    local lock vec to get_vector_to_latlng(pos_).
    local lock dist to vec:mag.

    local lock hover_v_h to vec:normalized * get_circular_orbit_v_at_alt().
    local lock v_h_c to hover_v_h - vxcl(up:vector, ship:velocity:orbit).
    local lock a_h to v_h_c:normalized * v_h_c:mag.

    local steering_ is heading(0, 0).
    local throttle_ is 0.
    lock steering to steering_.
    lock throttle to throttle_.

    local theta is 360.
    local new_theta is 0. lock new_theta to vectorangle(ship:velocity:orbit, vec).

    //lock v1 to vxcl(pos_:altitudposition(ship:altitude), ship:velocity:orbit).
    lock v0 to (
        ship:velocity:orbit:normalized * (ship:velocity:orbit:normalized * pos_:altitudeposition(ship:altitude)) +
        body:position:normalized * (body:position:normalized * pos_:altitudeposition(ship:altitude))
    ).
    lock v1 to -(body:position-v0).
    lock v2 to -body:position.
    lock v3 to ship:velocity:orbit.
    if warp_ set warp to 4.
    wait until vectorangle(v1, v2) <= 90 and vectorangle(v3, v0) < 90.

    set warp to 0.

    // First corrections
    set w to 4.
    for d in list(50000, 10000, 5000) {
        wlog("Correction at + " + dist + " meters from target.").
        until v_h_c:mag < 1 {
            correction.
        }
        set throttle_ to 0.
        wait 2.
        if warp_ set warp to w.
        set w to w/2.
        wait until dist < d.
        set warp to 0.
    }

    // Approach correction
    wlog("Correction burn at approach.").
    until dist < distance { correction. }

    // Finalize.
    set ship:control:pilotmainthrottle to 0.
    unlock throttle.
    unlock steering.
    wlog("Destination reached.").
}
