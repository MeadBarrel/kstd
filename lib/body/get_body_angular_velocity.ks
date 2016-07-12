function get_body_angular_velocity {
  declare parameter body_.
  return 360/body_:rotationperiod.
}