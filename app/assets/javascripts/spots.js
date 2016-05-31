var mymap;

function initMap() {
  if ($('#mapid').length) {

    mymap = L.map('mapid', { zoomControl: false });
    L.control.zoom({position: 'bottomright'}).addTo(mymap);


    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
      attribution: 'Bombhills 2016',
      maxZoom: 30,
      id: 'andyklimczak.096gbnif',
      accessToken: 'pk.eyJ1IjoiYW5keWtsaW1jemFrIiwiYSI6ImNpb3Vscm54bTAwdWV1bG01bGgzZHIyZ24ifQ.RDMsT_UvZBarJoRPGnjFmg'
    }).addTo(mymap);

    mymap.on('load', loadPoints);
    mymap.setView(getInitialView(), 13);
    mymap.on('contextmenu', onMapRightClick);

    $('#findmebutton').click(locateMe);
    $('#fullscreenbutton, #hamburgerbutton').click(toggleDashboard);
  }
}

function getInitialView() {
  if(gon.spot) {
    return [gon.spot.latitude, gon.spot.longitude];
  } else if (gon.search) {
    return [gon.search.data.point.coordinates[0], gon.search.data.point.coordinates[1]];
  } else {
    return [37.776619, -122.469296];
  }
}

function onMapRightClick(e) {
  if(gon.user_signed_in) {
    $('#new-latitude').val(e.latlng.lat);
    $('#new-longitude').val(e.latlng.lng);
    $('#new-location-form').modal('toggle');
  } else {
    $('#new-location-error').modal('toggle');
  }
}

  function loadPoints(e) {
    gon.spots.forEach(function(location) {
      L.marker([location.latitude, location.longitude], { clickable: true })
        .bindPopup("<b>" + location.title + "</b></br>Description: " + location.description + "<br>Created by: " + location.user.username + "<br>Difficulty: " + location.difficulty)
        .addTo(mymap);
    });
  }

  function locateMe() {
    mymap.locate({setView: true});
  }

  function toggleDashboard() {
    $('#fullscreenbutton, #hamburgerbutton').click(function (){           
      $('.dashboard').animate({
        left: this.id === 'fullscreenbutton' ? "-100%" : "0"
      }, 200);
      $('.meetups').animate({
        marginLeft: this.id === 'fullscreenbutton' ? "0" : "250px"
      }, 200);
    });
  };

  $(document).ready(initMap);
