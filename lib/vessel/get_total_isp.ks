download_ine("lib/vessel/get_active_engines.ks"). run once get_active_engines.

function get_total_isp {
  local result is 0.
  for eng_ in get_active_engines() {
    set result to result + eng_:isp.
  }
  return result.
}
