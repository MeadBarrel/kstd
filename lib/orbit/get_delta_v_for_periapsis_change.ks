download("lib/orbit/get_semi_major_axis_from_apses.ks"). run once get_semi_major_axis_from_apses.
download("lib/orbit/vis_a_vis.ks"). run once vis_a_vis.


function get_delta_v_for_periapsis_change {
	parameter
    final_periapsis, // Radius of final periapsis
    obt_ is obt.

	local r_a is obt_:APOAPSIS + obt_:body:radius.
	local final_orbit_sma is get_semi_major_axis_from_apses(final_periapsis, r_a).
	local final_orbit_v is vis_a_vis(obt_:body, r_a, final_orbit_sma).
	local starting_orbit_v is vis_a_vis(obt_:body, r_a, obt_:SEMIMAJORAXIS).

	return final_orbit_v - starting_orbit_v.
}