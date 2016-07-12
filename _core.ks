function assert {
    parameter
        assertion,
        message is "Assertion error".

    if not assertion {
        wlog("[ASSERTION ERROR]" + message, "ALERT").
        local _nothing is 1/0.  // ERROR
    }
}


function file_get_name {
    parameter path.

    set separated to path:split("/").
    return separated[separated:length-1].
}


function notify {
  parameter
    message, priority is "NOMINAL".

  local col is GREEN.
  if priority = "ALERT" set col to rgb(1, 0.31, 0).
  else if priority = "WARNING" set col to RED.

  hudtext("kOS: " + message, 1.5, 2, 30, col, False).
}


function wlog {
    parameter
        message,
        priority is "NOMINAL".

    local full_msg is "[T+"+round(missiontime)+"]["+priority+"] " + message.
    notify(message, priority).
    print full_msg.
    log full_msg to "log.txt".
}


function on_drive
{
	parameter
    filename,
    vol.
  switch to vol.
  local result is exists(filename).
	switch to 1.
  return result.
}


function download_ine {
  parameter
    filename,
    vol is 0.

  if not on_drive(filename, 1) {
    print "downloading: " + filename.
    copy filename from vol.
  }
}


// Get a file from volume
function download
		{
			parameter
					path,
					vol is 0.
			local filename is file_get_name(path).
			IF on_drive(filename, 1)
					{
						DELETE filename.
					}
			print "downloading: " + path.
			COPY path FROM vol.
		}

// Get a file from KSC if connection exists
function download_ifc
		{
			parameter
					path.
			local filename is file_get_name(path).
			if not addons:rt:HasKscConnection(ship) return.
			IF on_drive(filename, 1)
					{
						DELETE filename.
					}
			print "downloading: " + path.
			COPY path FROM 0.
		}

// Put a file on volume
function upload
{
	parameter
    filename,
    vol is 0.
	IF on_drive(filename, vol)
	{
		switch to vol. delete filename. switch to 1.
	}
	copy filename to vol.
}


