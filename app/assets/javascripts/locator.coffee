window.Surf = {}

class Surf.Locator
  constructor: (location_obj) ->
    @pos = location_obj
    console.log(@pos)

    unless @pos
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition(this.success, this.error)
      else
        this.error { message : 'Location services are not supported on your browser' }


  success: (position) ->
    console.log("Success callback")
    console.log(position)

    @pos = position.coords

    console.log(@pos)
    window.location = window.location + "?location[]=" + @pos.latitude + "&location[]=" + @pos.longitude

  error: (err) ->
    console.log("Error callback #{err.message}")
    console.log(msg)
