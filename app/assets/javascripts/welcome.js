var main = function() {
    $('#mobilenavbutton').click(function() {
        $('#mobilenavdiv').animate({
            left: '0'
        });
    });
    $('#mobilenavclose').click(function() {
        $('#mobilenavdiv').animate({
            left: '-100%'
        });
    });
    $('#tripsbutton').click(function() {
        $('#tripsdiv').animate({
            left: '0'
        });
    });
    $('#tripsclosebutton').click(function() {
        $('#tripsdiv').animate({
            left: '-100%'
        });
    });
};

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
    Microsoft.Maps.loadModule('Microsoft.Maps.Themes.BingTheme', {
        callback: function() {
            map = new Microsoft.Maps.Map(document.getElementById(
                'myMap'), {
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

      
          var sanfranlargest = new newPoint("sanfranlargest", 37.800309, -122.418117,
              "Filbert Street", "high density", "Starter");
          var thevalleyamazingtrail = new newPoint("thevalleyamazingtrail", 41.460184, -81.823116,
              "Amazing Trail", "watch out for bikers", "Starter");
              
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

var displayMap = function() {
    $(function() {
        $('#mapbutton').click(function() {
            $('#myMap').animate({
                left: '0'
            });
            $('#myMap').animate({
                opacity: '1'
            });
            $('.mymapoff').addClass('mymapon');
            $('.mapmenudivoff').addClass('mapmenudivon');
        });
    });
}

var closeMap = function() {
    $('#closebutton').click(function() {
        $('#myMap').animate({
            opacity: '.3'
        });
        $('#myMap').animate({
            left: '-100%'
        });
        $('#myMap').animate({
            opacity: '0'
        });
        $('.mymapoff').removeClass('mymapon');
        $('.mapmenudivoff').removeClass('mapmenudivon');
    });
};

// Load locations from the database to the map
function loadLocations() {
  console.log(gon.locations);
  gon.locations.forEach(function(location) {
    var p = new newPoint(location.user.email, location.latitude, location.longitude, location.title, location.description, location.difficulty);
  });
}

$(document).ready(displayMap);
$(document).ready(closeMap);
$(document).ready(setLocation);
$(document).ready(main);
$(document).ready(getMap);
