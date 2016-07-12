function get_time_since_periapsis_at_true_anomaly_cmn {
    parameter
        t_,     // true anomaly
        a_,     // semimajor axis
        e_,     // eccentricity
        body_.

    return (
        sqrt(a_^3/body_:mu) * (
            2 * arctan(sqrt((1-e_)/(1+e_))*tan(t_/2))
            -
            (e_*sqrt(1-e_^2)*sin(t_))/(1+e_*cos(t_))
        )
    ).
}


function get_time_since_periapsis_at_true_anomaly {
    parameter
        t_,     // true anomaly
        obt_ is obt.    // orbit

    return get_time_since_periapsis_at_true_anomaly_cmn(
        t_, obt_:semimajoraxis, obt_:eccentricity, obt_:body
    ).
}


function get_time_since_periapsis_at_radius_cmn {
    parameter
        r_,     // radius
        a_,     // semimajor axis
        e_,     // eccentricity
        body_.

    return (
        sqrt(a_^3/body_:mu)
        *
        (
            2 * arctan(sqrt(
                (r_-a_*(1-e_))/(a_*(1+e_)-r_)
            ))
            -
            sqrt(
                e_^2 - (1 - r_/a_)^2
            )
        )
    ).
}


function get_time_since_periapsis_at_radius {
    parameter
        r_,     // radius
        obt_ is obt.    // orbit

    return get_time_since_periapsis_at_radius_cmn(
        r_, obt_:semimajoraxis, obt_:eccentricity, obt_body
    ).
}