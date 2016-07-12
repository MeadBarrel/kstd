function is_orbit_coplanar_to {
    parameter
        tgt_obt_, // target orbit
        obt_ is obt, // current orbit
        tolerance is 0.1.

    // if both orbit has zero inclination, only check for inclination values
    if obt_:inclination < tolerance and tgt_obt_:inclination < tolerance
        return True.
    local err_lan is abs(obt_:LAN-tgt_obt_:LAN).
    local err_inc is abs(obt_:inclination-tgt_obt_:inclination).
    return max(err_lan, err_inc) < tolerance.
}