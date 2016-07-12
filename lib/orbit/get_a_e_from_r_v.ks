download_ine("get_velocity_at.ks"). run once get_velocity_at.


// Return semimajor axis from position and velocity
function get_a_from_r_v {
    parameter
        r_,     // radius
        v_,     // velocity
        body_.

    return (body_:mu*r_)/(2*body_:mu-v_^2*r_).
}


// Return eccentricity from position and velocity
function get_e_from_r_v {
    parameter
        r_,     // radius
        v_,     // velocity
        vt_,    // velocity tangent component
        body_.

    local vt is get_vt_at_radius_cmn(

    )
    return (sqrt(
        1 + ((vt_^2*r_)/body_:mu)*((v^2*r_)/body_:mu - 2)
    )).
}