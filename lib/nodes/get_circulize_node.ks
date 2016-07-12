// Add circuisation node at time `t`.


function get_circulize_node {
    parameter
        t.

    local v is velocityat(ship, t):orbit.
    local R is body:position - positionat(ship, t).
    local vs is vxcl(R, v).
    print R:mag.
    local vcirc is sqrt(body:mu / R:mag).
    local dv is (vs:normalized*vcirc) - v.

    local prograde_vec is v:normalized.
    local norm_vec is vcrs(prograde_vec, R):normalized.
    local radial_vec is vcrs(prograde_vec, norm_vec):normalized.

    local prograde_ is vdot(prograde_vec, dv).
    local norm_ is vdot(norm_vec, dv).
    local radial_ is vdot(radial_vec, dv).

    local rad is sqrt(abs(vcirc^2-prograde_^2)).
    return node(t, radial_, norm_, prograde_).
}