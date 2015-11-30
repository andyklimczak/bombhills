// JavaScript Document

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
};
var newPoint = function(name, loc1, loc2, title, description) {
    name = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(loc1,loc2), null);
    map.entities.push(name);
    map.entities.push(new Microsoft.Maps.Infobox(new Microsoft.Maps.Location(
        loc1, loc2), {
        title: title,
        description: description,
        pushpin: name
    }));
}

function GetMap() {
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
              if (e.isSecondary)
                $('#myModal').modal('toggle');
                var latlong = new Microsoft.Maps.Location(e.getY(),e.getX());
                console.log(latlong);

            });

      
          var sanfranlargest = new newPoint("sanfranlargest", 37.800309, -122.418117,
              "Filbert Street", "high density");
          var thevalleyamazingtrail = new newPoint("thevalleyamazingtrail", 41.460184, -81.823116,
              "Amazing Trail", "watch out for bikers");
              
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

function loadLocations() {
  console.log('in load locations');
  var $locations = $('.data-locations');
  $locations.each(function(index, item) {
    var temp = new newPoint(
      $(item).data('username'),
      $(item).data('latitude'),
      $(item).data('longitude'),
      $(item).data('title'),
      $(item).data('description')
    );
  });
}

$(document).ready(displayMap);
$(document).ready(closeMap);
$(document).ready(setLocation);
$(document).ready(main);
$(document).ready(GetMap); 
