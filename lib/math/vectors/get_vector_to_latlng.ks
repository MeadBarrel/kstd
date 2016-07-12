download("lib/math/vectors/get_vector_heading.ks"). run once get_vector_heading.


function get_vector_to_latlng {
  declare parameter target_latlng.

  local v_ is target_latlng:altitudeposition(ship:altitude).
  set v_ to heading(get_vector_heading(v_), 0):vector * v_:mag.
  return v_.
}