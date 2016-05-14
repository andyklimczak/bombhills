var newPoint = function(userEmail, lat, long, style, title, description, difficulty) {
  pointName = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(lat,long), null);
  map.entities.push(pointName);
  map.entities.push(new Microsoft.Maps.Infobox(new Microsoft.Maps.Location(
    lat, long), {
      title: title,
      description: "Description: " + description + "<br/>Created by: " + userEmail + "<br/>Difficulty: " + difficulty,
      pushpin: pointName,
      actions: [
        {label: 'meetups', eventHandler: meetupEventHandler}, 
        {label: 'edit', eventHandler: editEventHandler},
        {label: 'delete', eventHandler: deleteEventHandler},
      ]  
    }));
}

function meetupEventHandler() {           
  $('.meetups').animate({
    left: "0"
  }, 200);
}

function deleteEventHandler() { 
  //Do your stuff.
}

function editEventHandler() { 
  //Do your stuff.
}

var map;
function getMap() {
  if ( $('#myMap').length ) {
    Microsoft.Maps.loadModule('Microsoft.Maps.Themes.BingTheme', {
      callback: function() {
        map = new Microsoft.Maps.Map(document.getElementById('myMap'), {
          credentials: 'Al9aBb7etkdbFTyp2LNeKvnuZsE7r1-gCm95LmXZru0rbfBTSNaQjRxd2WDatfii',
          theme: new Microsoft.Maps.Themes.BingTheme(),enableSearchLogo: false, showMapTypeSelector:false,showDashboard: false
        });


        Microsoft.Maps.Events.addHandler(map, 'rightclick', function(e) {
          if (gon.user_signed_in && e.isSecondary && map.getZoom() > 19) {
            $('#new-location-form').modal('toggle');
            var point = new Microsoft.Maps.Point(e.getY(),e.getX());
            var pixelLocation = e.target.tryPixelToLocation(point);
            var computedLocation = new Microsoft.Maps.Location(pixelLocation.latitude, pixelLocation.longitude);
            console.log(computedLocation);
            //set data in element to be used when creating a new point
            document.getElementById('new-latitude').value = computedLocation.latitude;
            document.getElementById('new-longitude').value = computedLocation.longitude;
            console.log(map.getZoom());
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
    //find lat and long from ?search query param
    Microsoft.Maps.loadModule('Microsoft.Maps.Search', { callback: searchModuleLoaded });
  }
}

var setLocation = function() {
  $('#findmebutton').click(function() {
    var geoLocationProvider = new Microsoft.Maps.GeoLocationProvider(map);
    geoLocationProvider.getCurrentPosition();
  });
}

$(function (){
  $('#fullscreenbutton, #hamburgerbutton').click(function (){           
    $('.dashboard').animate({
      left: this.id === 'fullscreenbutton' ? "-100%" : "0"
    }, 200);
    $('.meetups').animate({
      marginLeft: this.id === 'fullscreenbutton' ? "0" : "250px"
    }, 200);
  });
});


$(function (){
  $('#closemeetupsbutton').click(function (){           
    $('.meetups').animate({
      left: this.id === 'closemeetupsbutton' ? "-100%" : "0"
    }, 200);
  });
});

// Load locations from the database to the map
function loadLocations() {
  console.log(gon.spots);
  gon.spots.forEach(function(location) {
    var p = new newPoint(location.user.username, location.latitude, location.longitude, location.title, location.description, location.difficulty);
  });
}

function searchModuleLoaded() {
  var searchManager = new Microsoft.Maps.Search.SearchManager(map);

  //center the map on a specific point if the id query param is present
  if(gon.spot) {
    map.setView({
      mapTypeId: Microsoft.Maps.MapTypeId.road, 
      zoom: 12,
      center: new Microsoft.Maps.Location(gon.spot.latitude,gon.spot.longitude)
    });
    //center the map on the search result
  } else if(gon.search) {
    var geocodeRequest = {where:gon.search, count:1, callback:geocodeCallback, errorCallback:errCallback};
    searchManager.geocode(geocodeRequest);
    //default map center
  } else {
    map.setView({
      mapTypeId: Microsoft.Maps.MapTypeId.road, 
      zoom: 12,
      center: new Microsoft.Maps.Location(37.776619,-122.469296)
    });
  }
}

function geocodeCallback(geocodeResult, userData) {
  console.log(geocodeResult.results[0]);
  map.setView({
    mapTypeId: Microsoft.Maps.MapTypeId.road, 
    zoom: 12,
    center: new Microsoft.Maps.Location(geocodeResult.results[0].locations[0].location.latitude, geocodeResult.results[0].locations[0].location.longitude)
  });
}

function errCallback(geocodeRequest) {

  alert("An error occurred.");
}

$(document).ready(getMap);
$(document).ready(setLocation);
