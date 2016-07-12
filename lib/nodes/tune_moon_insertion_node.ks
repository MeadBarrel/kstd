function tune_moon_insertion_node {
    parameter
        a_p,
        nd is nextnode.

    if __CONTRACTS {
        assert(nd:orbit:hasnextpatch, "Must have next patch").
    }

    local nd_t is time:seconds + nd:eta.

    local tgt is nd:orbit:nextpatch:body.
    local change is 10.
    local lock diff to abs(nd:orbit:nextpatch:periapsis-a_p).
    local old_diff is diff.

    until  diff < 1 {
        if (not nd:orbit:hasnextpatch) or (tgt <> nd:orbit:nextpatch:body)
            set change to -change.
        set nd_t to nd_t + change.
        set nd:eta to nd_t - time:seconds.
        if diff > old_diff
            set change to -change * 0.5.
        set old_diff to diff.
    }
}