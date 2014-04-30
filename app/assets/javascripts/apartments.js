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
	    center: new google.maps.LatLng(37.7831, -122.4039),
	    zoom: 12,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	var map = new google.maps.Map(document.getElementById('map'), mapOptions);

	var markerOptions = {
	    position: new google.maps.LatLng(37.7831, -122.4039)
	};
	var marker = new google.maps.Marker(markerOptions);
	//marker.setMap(map);

	var address = $("#apt-street").html() + $("#apt-zip").html();
	geocoder = new google.maps.Geocoder();
	geocoder.geocode({'address':address}, function(res, status) {
		console.log(address);
		if (status == google.maps.GeocoderStatus.OK) {
			var marker = new google.maps.Marker({
				map:map,
				position: res[0].geometry.location,
			});
			map.setCenter(marker.position);
		}
	});
});