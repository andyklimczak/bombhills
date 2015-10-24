// JavaScript Document
var main = function() {
  $(".button").mouseenter(function() {
    $(this).toggleClass("activebutton");
  });
  $(".button").mouseleave(function() {
    $(this).toggleClass("activebutton");
  });
  $('.openmap').mouseenter(function() {
	  $(this).addClass("mapbuttonhighlight");
  }); 
  $('.openmap').mouseleave(function() {
	  $(this).removeClass("mapbuttonhighlight");
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
                theme: new Microsoft.Maps.Themes.BingTheme()
            });
			
            map.setView({
                mapTypeId: Microsoft.Maps.MapTypeId.road, 
                zoom: 10,
                center: new Microsoft.Maps.Location(37.776586, -122.448811)
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
        $('#pinimage').click(function() {
			$('#myMap').animate({
                left: '0'
            });
			$('#myMap').animate({
                opacity: '1'
            });
			$('video').addClass('videostop');
			$('html').addClass('htmlbodycolor');
			$('.controlsoff').addClass('controlson');
			$('.citation').addClass('citationoff');
			 $('.mymapoff').addClass('mymapon');
        });
    });
}
var closeMap = function() {
    $('#closemapbutton').click(function() {
        $('#myMap').animate({
            opacity: '.3'
        });
		$('#myMap').animate({
            left: '-2000px'
        });
		$('#myMap').animate({
            opacity: '0'
        });
		$('video').removeClass('videostop');
		$('html').removeClass('htmlbodycolor');
		$('.controlsoff').removeClass('controlson');
		$('.citation').removeClass('citationoff');
		$('.mymapoff').removeClass('mymapon');
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
