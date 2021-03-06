var main = function() {

/*  $("#company_select").change(function() {
    // make a POST call and replace the content
    var company = $('select#company_select :selected').val();
    if(company == "") company="0";
    jQuery.get('/application/update_site_select/' + company, function(data){
        $("#addressStates").html(data);
    });
    return false;
  });*/
  
    $('#company_select').change(function() {
      $.ajax({
        url: "update_sites",
        data: {
          company_id : $('#company_select').val()
        },
        dataType: "script"
      });
    });  
    
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
	
	var table=$('.datatable').DataTable({    
      scrollX: true
  });

/*  $('.service-datatable').DataTable({		
    "columnDefs": [
    { targets: 'option-col'}
    ]
  });*/
	
	$('.toggle-vis').on( 'click', function (e) {
        e.preventDefault();
        // Get the column API object
        var column = table.column( $(this).attr('data-column') );
        // Toggle the visibility
        column.visible( ! column.visible() );
    } );
    
	$('.chosen-it').chosen();
	
	$("#baseline_invoices_table th a").live(click, function(){
		$.getScript(this.href);
		return false;
	}); 
};
$(document).ready(main);
