download("lib/orbit/get_semi_major_axis_from_apses.ks"). run once get_semi_major_axis_from_apses.
download("lib/orbit/vis_a_vis.ks"). run once vis_a_vis.


function get_delta_v_for_apoapsis_change {
	parameter
    final_apoapsis,  // Radius of final apoapsis.
    obt_ is obt.

	local r_p is obt_:PERIAPSIS + obt_:body:radius.
	local final_orbit_sma is get_semi_major_axis_from_apses(r_p, final_apoapsis).

	local final_orbit_v is vis_a_vis(obt_:body, r_p, final_orbit_sma).
	local starting_orbit_v is vis_a_vis(obt_:body, r_p, obt_:SEMIMAJORAXIS).

	return final_orbit_v - starting_orbit_v.
}
