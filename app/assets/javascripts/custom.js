var main = function() {
	$('.commentary').click(function() {
		$(this).next().toggle();
	});
	
	$('.show-selection').click(function(){
		$(this).parent().next().toggle();
	});
	
	$('.edit-selection').click(function(){
		$(this).parent().next().next().toggle();
	});

	$(function() {
		$('#side-menu').metisMenu();
	});
};

$(document).ready(main);
$(document).on('page:load', main);
