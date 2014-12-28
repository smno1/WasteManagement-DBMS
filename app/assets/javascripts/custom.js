var main = function() {
	$('.commentary').click(function() {
		$(this).next().toggle();
	});

	$(function() {
		$('#side-menu').metisMenu();
	});
};

$(document).ready(main);
$(document).on('page:load', main);
