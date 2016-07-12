download_ine("lib/math/get_norm_angle.ks"). run once get_norm_angle.

function get_angle_to_equinox {
    parameter
        obt,
        t is -1.  // True anomaly, defaults to current true anomaly.

    local t_ is t.
    if t = -1 set t_ to obt:trueanomaly.

    return get_norm_angle(obt:LAN + obt:ARGUMENTOFPERIAPSIS + t_).
}
