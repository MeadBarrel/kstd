function exec_node {
  local nd is nextnode.

  print "Node in: " + round(nd:eta) + ", DeltaV: " + round(nd:deltav:mag).

  local en_max_acc is ship:maxthrust/ship:mass.

  local burn_duration is nd:deltav:mag/en_max_acc.
  print "Crude Estimated burn duration: " + round(burn_duration) + "s".

  if __WARP {
    warpto(time:seconds+nd:eta-((burn_duration/2) + __ENODE_MARGIN)).
  } else
    wait until nd:eta <= (burn_duration/2) + __ENODE_MARGIN.
  set warp to 0.

  lock steering to nd:deltav.

  //the ship is facing the right direction, let's wait for our burn time
  wait until nd:eta <= (burn_duration/2).

  //we only need to lock throttle once to a certain variable in the beginning of the loop, and adjust only the variable itself inside it
  local tset is 0.
  lock throttle to tset.

  local done is False.
  //initial deltav
  local dv0 is nd:deltav.
  until done
  {
      //recalculate current en_max_acceleration, as it changes while we burn through fuel
      set en_max_acc to ship:maxthrust/ship:mass.

      //throttle is 100% until there is less than 1 second of time left to burn
      //when there is less than 1 second - decrease the throttle linearly
      set tset to min(nd:deltav:mag/en_max_acc, 1).

      //here's the tricky part, we need to cut the throttle as soon as our nd:deltav and initial deltav start facing opposite directions
      //this check is done via checking the dot product of those 2 vectors
      if vdot(dv0, nd:deltav) < 0
      {
          print "End burn, remain dv " + round(nd:deltav:mag,1) + "m/s, vdot: " + round(vdot(dv0, nd:deltav),1).
          lock throttle to 0.
          break.
      }

      //we have very little left to burn, less then 0.1m/s
      if nd:deltav:mag < 0.1
      {
          print "Finalizing burn, remain dv " + round(nd:deltav:mag,1) + "m/s, vdot: " + round(vdot(dv0, nd:deltav),1).
          //we burn slowly until our node vector starts to drift significantly from initial vector
          //this usually means we are on point
          wait until vdot(dv0, nd:deltav) < 0.5.

          lock throttle to 0.
          print "End burn, remain dv " + round(nd:deltav:mag,1) + "m/s, vdot: " + round(vdot(dv0, nd:deltav),1).
          set done to True.
      }
  }
  unlock steering.
  unlock throttle.
  wait 1.

  //we no longer need the maneuver node
  remove nd.

  //set throttle to 0 just in case.
  SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

}