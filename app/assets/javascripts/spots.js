var mymap;

/**
 * Init the map with the correct layout, points, and listeners
 */
function initMap() {
  if ($('#map-id').length) {
    mymap = L.map('map-id', { zoomControl: false });
    L.control.zoom({position: 'bottomright'}).addTo(mymap);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
      attribution: 'Bombhills 2016',
      maxZoom: 30,
      id: 'andyklimczak.096gbnif',
      accessToken: 'pk.eyJ1IjoiYW5keWtsaW1jemFrIiwiYSI6ImNpb3Vscm54bTAwdWV1bG01bGgzZHIyZ24ifQ.RDMsT_UvZBarJoRPGnjFmg'
    }).addTo(mymap);

    mymap.on('load', loadPoints);
    mymap.setView(getInitialView(), 12);
    mymap.on('contextmenu', onMapRightClick);

    $('#find-me-btn').click(locateMe);
    $('#fullscreen-btn, #hamburger-btn').click(toggleDashboard);

    fadeAlert();
  }
}

/**
 * Hides the map alert after 4 seconds
 */
function fadeAlert() {
  $(".map-alert").delay(4000).slideUp(200, function() {
    $(this).alert('close');
  });
}

/**
 * Set the initial view of the map for the user. It can be 1 of 3 ways:
 * If the user searched for a point, look for the cordinates from the json search object (?q= url query param)
 * If the user is looking at a specific point, focus on that point
 * If a specific point or location isn't specified, default to SF lat/long
 */
function getInitialView() {
  if(gon.spot) {
    return [gon.spot.latitude, gon.spot.longitude];
  } else if (gon.search) {
    return [gon.search.data.point.coordinates[0], gon.search.data.point.coordinates[1]];
  } else {
    return [37.776619, -122.469296];
  }
}

/**
 * Open the add new location form modal when user right clicks on the map
 */
function onMapRightClick(e) {
  if(gon.user_signed_in) {
    $('#new-latitude').val(e.latlng.lat);
    $('#new-longitude').val(e.latlng.lng);
    $('#new-spot-form').modal('toggle');
  } else {
    $('#new-location-error').modal('toggle');
  }
}

/**
 * Function to initially load all of the spots onto the map
 * Uses ajax to hit the json version of the points, and creates the markers by looping through
 */
function loadPoints() {
  fetch('/spots.json')
  .then(status)
  .then(json)
  .then(function(json) {
    json.spots.forEach(function(spot) {
      L.marker([spot.latitude, spot.longitude], { clickable: true })
        .bindPopup(
          "<b>" + spot.title + "</b></br> \
          Description: " + spot.description + "<br> \
          Created by: " + spot.user.username + "<br> \
          Difficulty: " + spot.difficulty + "<br> \
          Traffic: " + spot.traffic + "<br> \
          <a href='/spots/" + spot.id + "'>more info</a>" +"<br> \
          <a data-toggle='modal' data-target='#report-modal'>report</a>")
        .addTo(mymap);
    });
  }).catch(function(err) {
    console.log('Error loading points: ', err);
  });
}

/**
 * Allows user to move the map view to their location based on ip
 */
function locateMe() {
  mymap.locate({setView: true});
}

/**
 * Show or hide the left hand nav dashboard
 */
function toggleDashboard() {
  $('#fullscreen-btn, #hamburger-btn').click(function () {
    $('.dashboard').animate({
      left: this.id === 'fullscreen-btn' ? "-100%" : "0"
    }, 200);
    $('.meetups').animate({
      marginLeft: this.id === 'fullscreen-btn' ? "0" : "250px"
    }, 200);
  });
}

document.addEventListener("turbolinks:load", initMap);
