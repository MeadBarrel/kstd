download_ine("lib/math/get_norm_angle.ks"). run once get_norm_angle.
download_ine("lib/orbit/get_angle_to_equinox.ks"). run once get_angle_to_equinox.
download_ine("lib/orbit/is_orbit_coplanar_to.ks"). run once is_orbit_coplanar_to.


function get_moon_insertion_node {
    parameter
        moon.

    if __CONTRACTS {
        assert(obt:eccentricity < 0.01, "Orbit must be circular").
        assert(moon:obt:eccentricity < 0.01, "Target body orbit must be circular").
        assert(moon:obt:body=obt:body, "Ship and target must have the same central body").
        assert(is_orbit_coplanar_to(moon:obt), "Ship orbit must be coplanar to target body orbit").
    }

    // Get transfer parameters
    local r_a is body:radius + moon:apoapsis.
    local r_p is body:radius + apoapsis.
    local a is (r_a+r_p) / 2.
    local v_at_periapsis is sqrt(body:mu * (2/r_p-1/a)).
    local moon_angular_vel is 360/moon:obt:period.
    local ship_angular_vel is 360/obt:period.
    local transfer_period is 2 * constant:pi * sqrt(a^3/body:mu).
    local phase_angle is moon_angular_vel * transfer_period/2.
    local angle_increse is ship_angular_vel - moon_angular_vel.

    local current_angle is
        get_norm_angle(
            get_angle_to_equinox(ship:obt) + 180 -
            get_angle_to_equinox(moon:obt)
        ).

    local node_t is time:seconds + (phase_angle-current_angle+360) / angle_increse.
    local nd is Node(node_t, 0, 0, v_at_periapsis - velocityat(ship, node_t):orbit:mag).
    return nd.
}
