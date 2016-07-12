function get_vector_pitch {
  declare parameter v_.

  return vectorangle(-(up:vector), v_) - 90.
}