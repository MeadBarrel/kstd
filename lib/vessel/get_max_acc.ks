function get_max_acc {
  declare parameter vessel_ is ship.

  return vessel_:availablethrust/vessel_:mass.
}