function get_radius_from_true_anomaly_cmn {
    parameter
        true_anomaly,
        semi_major_axis_,
        eccentricity_.

    return (
        (semi_major_axis_*(1-eccentricity_^2))
        /
        (1+eccentricity_*cos(true_anomaly))
    ).
}


function get_radius_from_true_anomaly {
    parameter
        true_anomaly,
        orbit is obt.

    return get_radius_from_true_anomaly_cmn(
        true_anomaly, obt:semimajoraxis, obt:eccentricity
    ).
}