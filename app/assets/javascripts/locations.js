
var newPoint = function(userEmail, lat, long, title, description, difficulty) {
    pointName = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(lat,long), null);
    map.entities.push(pointName);
    map.entities.push(new Microsoft.Maps.Infobox(new Microsoft.Maps.Location(
        lat, long), {
        title: title,
        description: "Description: " + description + "<br/>Created by: " + userEmail + "<br/>Difficulty: " + difficulty,
        pushpin: pointName
    }));
}

function getMap() {
  if ( $('#myMap').length ) {
    Microsoft.Maps.loadModule('Microsoft.Maps.Themes.BingTheme', {
        callback: function() {
            map = new Microsoft.Maps.Map(document.getElementById('myMap'), {
                credentials: 'Al9aBb7etkdbFTyp2LNeKvnuZsE7r1-gCm95LmXZru0rbfBTSNaQjRxd2WDatfii',
                theme: new Microsoft.Maps.Themes.BingTheme(),enableSearchLogo: false, showMapTypeSelector:false,showDashboard: false
            });
      
            map.setView({
                mapTypeId: Microsoft.Maps.MapTypeId.road, 
                zoom: 12,
                center: new Microsoft.Maps.Location(37.776619,-122.469296)
            });

            Microsoft.Maps.Events.addHandler(map, 'rightclick', function(e) {
              if (gon.user_signed_in && e.isSecondary) {
                $('#new-location-form').modal('toggle');
                var point = new Microsoft.Maps.Point(e.getY(),e.getX());
                var pixelLocation = e.target.tryPixelToLocation(point);
                var computedLocation = new Microsoft.Maps.Location(pixelLocation.latitude, pixelLocation.longitude);
                console.log(computedLocation);
                //set data in element to be used when creating a new point
                document.getElementById('new-latitude').value = computedLocation.latitude;
                document.getElementById('new-longitude').value = computedLocation.longitude;
              } else {
                $('#new-location-error').modal('toggle');
              }
            });

      
          var sanfranlargest = new newPoint("sanfranlargest", 37.800309, -122.418117,
              "Filbert Street", "high density", "Starter");
          var thevalleyamazingtrail = new newPoint("thevalleyamazingtrail", 41.460184, -81.823116,
              "Amazing Trail", "watch out for bikers", "Starter");
              
          loadLocations();
        }
    });
  }
}

var setLocation = function() {
    $('#findmebutton').click(function() {
        var geoLocationProvider = new Microsoft.Maps.GeoLocationProvider(map);
        geoLocationProvider.getCurrentPosition();
    });
}

var fullScreen = function() {
    $('#fullscreenbutton').click(function() {
        $('.dashboard').animate({
            left: "-100%" 
        }, 200);
    });
    $('#hamburgerbutton').click(function() {
        $('.dashboard').animate({
            left: "0" 
        }, 200);
    });
}

// Load locations from the database to the map
function loadLocations() {
  console.log(gon.locations);
  gon.locations.forEach(function(location) {
    var p = new newPoint(location.user.username, location.latitude, location.longitude, location.title, location.description, location.difficulty);
  });
}

$(document).ready(getMap);
$(document).ready(setLocation);
$(document).ready(fullScreen);
