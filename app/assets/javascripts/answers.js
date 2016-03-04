// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function () {
	
	$(function(){
	$(".chosen-select").chosen({width: "100% !important"})
  	filterOptionsList();
  	$('select#event_id').change();
	});

});

function filterOptionsList(){
  	options = $('select#option_id').html();
	options2 = $('select#option_id2').html();
	options3 = $('select#option_id3').html();
	options4 = $('select#option_id4').html();
	options5 = $('select#option_id5').html();
	options6 = $('select#option_id6').html();

  	$('select#event_id').change(function(){

  		var toggle = $('fieldset').get(0);
  		console.log($('select#event_id').val())
  		if ($('select#event_id').val() > 0) {
  			toggle.disabled = false
  		} else {
  			toggle.disabled = true
  		}

  		event_category = $('#event_id_chosen span').text();
  		console.log()
		value_num = $(this).val();
  		optgroup = "option[data-event-id='"+ value_num +"']"
  		all_options = $(options).filter(optgroup);
		all_options2 = $(options2).filter(optgroup);
		all_options3 = $(options3).filter(optgroup);
		all_options4 = $(options4).filter(optgroup);
		all_options5 = $(options5).filter(optgroup);
		all_options6 = $(options6).filter(optgroup);
		
  		if(event_category != "Other"){ 
  			console.log("changed!")
  		  	$('#option_id').html(all_options);
					$('#option_id').val('').trigger('chosen:updated');
					
  		  	$('#option_id2').html(all_options2);
					$('#option_id2').val('').trigger('chosen:updated');
					
  		  	$('#option_id3').html(all_options3);
					$('#option_id3').val('').trigger('chosen:updated');
					
  		  	$('#option_id4').html(all_options4);
					$('#option_id4').val('').trigger('chosen:updated');
					
  		  	$('#option_id5').html(all_options5);
					$('#option_id5').val('').trigger('chosen:updated');
					
  		  	$('#option_id6').html(all_options6);
					$('#option_id6').val('').trigger('chosen:updated');
  		}
				
  	}); 
}