function tune_midcourse_correction_node {
    parameter
        nd,
        a_p,
        soi_obt_func.

    if __CONTRACTS {
        assert(a_p > 0).
    }

    local change is 1.
    local lock diff to abs(soi_obt_func():periapsis-a_p).
    local old_diff is diff.
    until  diff < 1 {
        set nd:radialout to nd:radialout + change.
        print diff + ":" + old_diff + ":" + change.
        local d is diff - old_diff.
        if diff > old_diff {set change to -change * 0.9.}
        set old_diff to diff.
    }

    return nd.
}
