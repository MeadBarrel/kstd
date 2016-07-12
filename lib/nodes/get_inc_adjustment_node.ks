function get_inc_adjustment_node {
    parameter
        tgt.

    if __CONTRACTS {
        assert(tgt:obt:body=obt:body, "Ship and target must have the same central body").
    }

    local pos_tgt is tgt:position - body:position.
    local pos_ship is ship:position - body:position.

    // Calculate angular momentums
    local am_tgt is vcrs(pos_tgt, tgt:velocity:orbit).
    local am_ship is vcrs(pos_ship, ship:velocity:orbit).
    local desired_am_ship is am_tgt:normalized * am_ship:mag.
    local inc is vang(am_ship, desired_am_ship). // Inclination between angular momentums
    local node_direction is vcrs(am_ship, desired_am_ship):normalized.
    local dv is desired_am_ship - am_ship.
    local angle_to_node is vang(pos_ship, node_direction).

    local side is vdot(node_direction, velocity:orbit). // positive when towards node
    if side < 0
        set angle_to_node to 360-angle_to_node.

    local ship_period is 2*constant:pi*sqrt(pos_ship:mag^3/body:mu).
    local eta is angle_to_node/360*ship_period.

    set dv to dv:mag/pos_ship:mag.
    return Node(time:seconds+eta, 0, -dv*cos(inc/2), -dv*sin(inc/2)).
}