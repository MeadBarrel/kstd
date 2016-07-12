function g {
  parameter
    alt_ is ship:altitude,
    body_ is body.

  return body_:mu/(body_:radius+alt_)^2.
}

