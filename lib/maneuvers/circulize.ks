download("lib/maneuvers/change_apoapsis_to.ks"). run once change_apoapsis_to.
download("lib/maneuvers/change_periapsis_to.ks"). run once change_periapsis_to.


function circulize {
    declare parameter radius_.

    wait 5.

    if ETA:PERIAPSIS < ETA:APOAPSIS or ETA:APOAPSIS = 0 {
        change_apoapsis_to(radius_).
        change_periapsis_to(radius_).
    } else {
        change_periapsis_to(radius_).
        change_apoapsis_to(radius_).
    }
}