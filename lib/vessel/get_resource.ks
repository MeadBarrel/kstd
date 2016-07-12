function get_resource {
    parameter
        name_,
        vessel_ is ship.

    for r in vessel_:resources {
        if r:name=name_ return r.
    }
    return 0.
}
