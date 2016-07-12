// Get orbital velocity required for circular orbit at specified altitude.
function get_circular_orbit_v_at_alt {
	parameter
		alt_ is ship:altitude,
		body_ is body.

	return sqrt(body_:mu / (alt_+body:radius)).
}