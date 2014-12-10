var main=function(){
	$('.commentary').click(function(){
		$(this).next().toggle();
	});
};

$(document).ready(main);
$(document).on('page:load',main);
