set ascii_lowercase to "abcdefghijklmnopqrstuvwxyz".
set ascii_uppercase to "ABCDEFGHIJKLMNOPQRSTUVWXYZ".
set ascii_letters to ascii_lowercase+ascii_uppercase.
set digits to "0123456789".
set hexdigits to "0123456789abcdefABCDEF".


function flt_to_str {
  // Convert a floating point number to string
  // >>> print flt_to_str(2.8269, 2).
  // 2.82

  declare parameter n.  // Number
  declare parameter prec.  // Precision


  local an is abs(n).
  local result is floor(an) + "." + floor((an-floor(an))*10^prec).
  if n < 0 set result to "-" + result.
  return result.
}

