function get_norm_angle {
    parameter theta.
    return mod((mod(theta, 360) + 360), 360).
}