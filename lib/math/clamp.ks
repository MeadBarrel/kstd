function clamp {
  declare parameter n.
  declare parameter _min.
  declare parameter _max.

  return min(_max, max(_min, n)).
}
