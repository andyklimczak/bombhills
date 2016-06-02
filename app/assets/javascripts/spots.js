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
    $.ajax({
      url: '/spots.json',
      method: 'GET'
    }).done(function(response) {
      response.spots.forEach(function(spot) {
        L.marker([spot.latitude, spot.longitude], { clickable: true })
          .bindPopup("<b>" + spot.title + "</b></br>Description: " + spot.description + "<br>Created by: " + spot.user.username + "<br>Difficulty: " + spot.difficulty + "<br><a href='/spots/" + spot.id + "'>More Info</a>")
          .addTo(mymap);
      });
    }).fail(function() {
      console.log('Error getting points');
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
