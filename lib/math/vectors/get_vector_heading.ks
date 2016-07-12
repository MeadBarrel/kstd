function get_vector_heading {
  // Return a compass heading for some vector, assuming it's origin is the ship

  declare parameter v_.
  local h1 is vectorangle(heading(0, 0):vector, vxcl(up:forevector, v_)).
  local h2 is vectorangle(heading(90, 0):vector, vxcl(up:forevector, v_)).
  if h2 > 90 return 360-h1.
  return h1.
}
