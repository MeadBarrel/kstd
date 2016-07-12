// Radial component

function get_vr_at_true_anomaly_cmn {
    parameter
        t_, // true anomaly
        a_, // semimajor axis
        e_, // eccentricity
        body_.

    return (
        sqrt(
            body_:mu / (a_*(1-e_^2))
        ) * e_ * sin(t_)
    ).
}


function get_vr_at_true_anomaly {
    parameter
        t_,  // true anomaly
        obt_ is obt.  // orbit

    return get_vr_at_true_anomaly_cmn(
        t_, obt_:semimajoraxis, obt_:eccentricity, obt_:body
    ).
}


function get_vr_at_radius_cmn {
    parameter
        r_,  // radius
        a_,  // semimajor axis
        e_,  // eccentricity
        body_.

    return (sqrt(
        (body_:mu*(e_^2*a_^2 - (r_ - a_)^2)) / (a_*r_^2)
    )).
}


function get_vr_at_radius {
    parameter
        r_,  // radius
        obt_ is obt.// orbit

    return get_vr_at_radius_cmn(
        r_, obt_:semimajoraxis, obt_:eccentricity, obt_:body
    ).
}


// Tangent component

function get_vt_at_true_anomaly_cmn {
    parameter
        t_,     // true anomaly
        a_,     // semimajor axis
        e_,     // eccentricity
        body_.

    return (
        sqrt(body_:mu/(a_*(1-e_^2))) * (1+e_*cos(t_))
    ).
}


function get_vt_at_true_anomaly {
    parameter
        t_,      // true anomaly
        obt_ is obt.    // orbit

    return get_vr_at_true_anomaly_cmn(
        t_, obt_:semimajoraxis, obt_:eccentricity, obt_:body
    ).
}


function get_vt_at_radius_cmn {
    parameter
        r_,     // radius
        a_,     // semimajor axis
        e_,     // eccentricity
        body_.

    return (
        sqrt(body_:mu*a_*(1-e_^2)) / r_
    ).
}


function get_vt_at_radius {
    parameter
        r_,     // radius
        obt_ is obt.  // orbit

    return get_vt_at_radius_cmn(
        r_, obt_:semimajoraxis, obt_:eccentricity, obt_:body
    ).
}


// Velocity magnitude

function get_v_at_true_anomaly_cmn {
    parameter
        t_,     // true anomaly
        a_,     // semimajor axis
        e_,     // eccentricity
        body_.

    return (
        sqrt(
            body_:mu*(1+e_^2+2*e_*cos(t_)) / (a_*(1-e_^2))
        )
    ).
}


function get_v_at_true_anomaly {
    parameter
        t_,     // true anomaly
        obt_ is obt.     // orbit

    return get_v_at_true_anomaly_cmn(
        t_, obt_:semimajoraxis, obt_:eccentricity, obt_:body
    ).
}


function get_v_at_radius_cmn {
    parameter
        r_,     // radius
        a_,     // semimajor axis
        body_.

    return sqrt(body_:mu * (2/r_ - 1/a_)).
}


function get_v_at_radius {
    parameter
        r_,     // radius
        obt_ is orbit.  // orbit

    return get_v_at_radius_cmn(
        r_, obt_:semimajoraxis, obt_:body
    ).
}