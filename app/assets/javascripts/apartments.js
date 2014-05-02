/*# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/*/
$(document).ready(function() {
    $("#reset_filters").click(function(e){
		e.preventDefault();
		$("#filters input").each(function() {
			$(this).val("");
		})
		$("#search_form").submit();
    });

    var mapOptions = {
        center: new google.maps.LatLng(37.869182, -122.258403),
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);

    var bounds = new google.maps.LatLngBounds();
    
    var markerOptions = {
        position: new google.maps.LatLng(37.869182, -122.258403)
    };
    
    var marker = new google.maps.Marker(markerOptions);
    //marker.setMap(map);

    var address = $("#apt-street").html() + $("#apt-zip").html();
    geocoder = new google.maps.Geocoder();
    geocoder.geocode({'address':address}, function(res, status) {
        //console.log(address);
        console.log(res[0]);
        //console.log(res[0].geometry.location.lng());
        //console.log(res[0].geometry.location.lat());*/
        if (status == google.maps.GeocoderStatus.OK) {
            var markers = [
                [address, res[0].geometry.location.lat(), res[0].geometry.location.lng()],
                ['Safeway', 37.880913, -122.269980],
                ['Berkeley Bowl', 37.857071, -122.267396],
                ['Trader Joes', 37.871738, -122.273266],
                ['Sproul Plaza', 37.869182, -122.258403],
                ['Soda Hall', 37.875743, -122.258732]
            ];

            var infoWindowContent = [
                ['<div class="info_content">' +
                '<span>' + res[0].formatted_address +'</span>' + '</div>'],
                ['<div class="info_content">' +
                '<span>Safeway</span>' + '</div>'],
                ['<div class="info_content">' +
                '<span>Berkeley Bowl</span>' + '</div>'],
                ['<div class="info_content">' +
                '<span>Trader Joes</span>' + '</div>'],
                ['<div class="info_content">' +
                '<span>Sproul Plaza</span>' + '</div>'],
                ['<div class="info_content">' +
                '<span>Soda Hall</span>' + '</div>'],
            ];

            var iconURLPrefix = 'http://maps.google.com/mapfiles/ms/icons/';
            
            var icons = [
              iconURLPrefix + 'red-dot.png',
              iconURLPrefix + 'blue-dot.png',
              iconURLPrefix + 'blue-dot.png',
              iconURLPrefix + 'blue-dot.png',
              iconURLPrefix + 'blue-dot.png',
              iconURLPrefix + 'blue-dot.png',
            ]

            var infoWindow = new google.maps.InfoWindow()

            /*var marker = new google.maps.Marker({
                map:map,
                position: res[0].geometry.location,
            });*/
            for(i = 0; i < markers.length; i++) {
                var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
                bounds.extend(position);
                marker = new google.maps.Marker({
                    position: position,
                    map: map,
                    title: markers[i][0],
                    icon : icons[i]
                });

                google.maps.event.addListener(marker, 'click', (function(marker, i) {
                    return function() {
                        infoWindow.setContent(infoWindowContent[i][0]);
                        infoWindow.open(map, marker);
                    }
                })(marker, i));
            }
            map.setCenter(marker.position);
        }
    });
});