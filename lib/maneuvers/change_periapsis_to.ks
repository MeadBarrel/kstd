download_ine("lib/orbit/get_delta_v_for_periapsis_change.ks"). run once get_delta_v_for_periapsis_change.


function change_periapsis_to {
    declare parameter radius_.
    local deltav is get_delta_v_for_periapsis_change(radius_).
    ADD NODE(TIME:SECONDS + ETA:APOAPSIS, 0, 0, deltav).
    exec_node().
}
