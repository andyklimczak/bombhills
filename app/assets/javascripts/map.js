// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// load map for map page
function getMap() {
  Microsoft.Maps.loadModule('Microsoft.Maps.Themes.BingTheme', {
    callback: function() {
      map = new Microsoft.Maps.Map(document.getElementById("fullMap"), {
        credentials: 'Al9aBb7etkdbFTyp2LNeKvnuZsE7r1-gCm95LmXZru0rbfBTSNaQjRxd2WDatfii',
        theme: new Microsoft.Maps.Themes.BingTheme(),enableSearchLogo: false, showMapTypeSelector:false,showDashboard: false
      });
      map.setView({
        mapTypeId: Microsoft.Maps.MapTypeId.road, 
        zoom: 12,
        center: new Microsoft.Maps.Location(37.776586, -122.448811)
      });
      Microsoft.Maps.Events.addHandler(map, 'rightclick', function(e) {
        if (gon.user_signed_in && e.isSecondary) {
          $('#new-location-form').modal('toggle');
          var point = new Microsoft.Maps.Point(e.getY(),e.getX());
          var pixelLocation = e.target.tryPixelToLocation(point);
          var computedLocation = new Microsoft.Maps.Location(pixelLocation.latitude, pixelLocation.longitude);
          console.log(computedLocation);
          document.getElementById('new-latitude').value = computedLocation.latitude;
          document.getElementById('new-longitude').value = computedLocation.longitude;
        } else {
          $('#new-location-error').modal('toggle');
        }
      });
      loadLocations();
    }
  });
}

var setLocation = function() {
    $('#findmebutton').click(function() {
        var geoLocationProvider = new Microsoft.Maps.GeoLocationProvider(
            map);
        geoLocationProvider.getCurrentPosition();
    });
}

$(document).ready(getMap);
