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

	$('#side-menu').metisMenu();
	
	$("#baseline_invoices_table th a").live(click, function(){
		$.getScript(this.href);
		return false;
	});
};

$(document).ready(main);
$(document).on('page:load', main);
