download("lib/vessel/get_resource.ks"). run once get_resource.


function get_resource_amount {
    parameter
            name_,
            vessel_ is ship.

    local r is get_resource(name_, vessel_).
    if r=0 return 0.
    return r:amount.
}