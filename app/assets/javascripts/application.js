// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dropzone
//= require fotorama
//= require_tree .

$(function() {
	$('.rating_star').click(function() {
		var star = $(this);
		var apt_id = $(this).attr('data-apt-id');
		var stars = $(this).attr('data-stars');

		for (i=1; i<=5; i++) {
			if(i <= stars){
				$('#' + apt_id + '_' + i).addClass('on');
			} else {
				$('#' + apt_id + '_' + i).removeClass('on');
			}
		}

		var sel = document.getElementById('review_overall_rating');
		sel.options[stars-1].selected = true;
	});
});

$(function() {
	$('.rating_star').hover(function() {
		var star = $(this);
		var apt_id = $(this).attr('data-apt-id');
		var stars = $(this).attr('data-stars');

		for (i=1; i<=5; i++) {
			if(i <= stars){
				$('#' + apt_id + '_' + i).addClass('on');
			} else {
				$('#' + apt_id + '_' + i).removeClass('on');
			}
		}

		var sel = document.getElementById('review_overall_rating');
		sel.options[stars-1].selected = true;
	});
});

$(function() {
	$('#review_overall_rating').change(function(){
		var star = document.getElementsByClassName('rating_star');
		var apt_id = star[0].getAttribute('data-apt-id');
		var sel = document.getElementById('review_overall_rating');
		var stars = sel.selectedIndex + 1;
		console.log(apt_id)
    	for (i=1; i<=5; i++) {
			if(i <= stars){
				$('#' + apt_id + '_' + i).addClass('on');
			} else {
				$('#' + apt_id + '_' + i).removeClass('on');
			}
		}
  	});
});