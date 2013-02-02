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


    $ =>
      $("#feedbackLink").click ->
        $("#feedback").reveal()

      $(window).resize =>
        this.resizeMap()

      if Gmaps.map
        Gmaps.map.callback = =>
          this.resizeMap()
          $('.map_wrapper').fadeIn()

  resizeMap: =>
    width = $("#side_bar").width() - 15

    $(".map_container").width(width)
    $("#map").width(width)

    if typeof "google" != undefined && google.maps
      google.maps.event.trigger(Gmaps.map.map, "resize")
      if (Gmaps.map.markers.length == 1)
        setTimeout ->
          Gmaps.map.map.setZoom(12);
        , 100
      else
        Gmaps.map.adjustMapToBounds();


  success: (position) ->
    console.log("Success callback")
    console.log(position)

    @pos = position.coords

    console.log(@pos)
    window.location = window.location + "?location[]=" + @pos.latitude + "&location[]=" + @pos.longitude

  error: (err) ->
    console.log(err)
    $('.location-box').hide();

    if err.code && err.code == err.PERMISSION_DENIED
      msg = "You did not give us your location. Please manually search for an address near you."
    else
      msg = err.message

    $('.location-box-error').text(msg).fadeIn();
