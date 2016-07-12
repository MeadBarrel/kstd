download_ine("lib/orbit/get_delta_v_for_periapsis_change.ks").
run once get_delta_v_for_periapsis_change.


function change_apoapsis_to {
    declare parameter radius_.
    set deltav to get_delta_v_for_apoapsis_change(radius_).
    ADD NODE(TIME:SECONDS + ETA:PERIAPSIS, 0, 0, deltav).
    exec_node().
}
