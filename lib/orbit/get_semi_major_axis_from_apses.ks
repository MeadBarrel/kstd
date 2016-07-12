function get_semi_major_axis_from_apses {
	parameter
    r_a,  // Apoapsis radius.
	  r_b.  // Periapsis radius.

	return (r_a + r_b) / 2.
}
