// Return velocity at the given radius

function vis_a_vis {
	parameter
	    reference_body,
	    radius,
	    semi_major_axis.

	return sqrt(reference_body:mu * (2/radius - 1/semi_major_axis)).
}
