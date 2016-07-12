function get_active_engines {
  local engines is 0.
  list engines in engines_.
  local result is list().
  for eng_ in engines_ {
    if eng_:ignition result:add(eng_).
  }
  return result.
}