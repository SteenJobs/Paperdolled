// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function () {
    size_li = $("#myList li").size();
    x=3;
    $('#myList li:lt('+x+')').show();
    $('#loadMore').click(function () {
        x= (x+1 <= size_li) ? x+2 : size_li;
        $('#myList li:lt('+x+')').show();
    });
    $('#showLess').click(function () {
        x=(x-1<0) ? 1 : x-2;
        $('#myList li').not(':lt('+x+')').hide();
    });
});

// script-for-nav 
$(document).ready(function () {
		$( "span.menu" ).click(function() {
		  $( ".head-nav ul" ).slideToggle(300, function() {
			// Animation complete.
		  });
		});
	});
	
// script-for-textarea
	
$(document).ready(function() {
  /* Activating Best In Place */
  // jQuery(".best_in_place").best_in_place();
	// $('.best_in_place').bind('ajax:success', function(){ this.innerHTML = this.innerHTML.replace(/\n/g, '<br />') });
	$('#questions').find('select').chosen();
	$('#sandbox-container').datepicker({
	    format: "M dd, yyyy",
	    autoclose: true,
	    todayHighlight: true
	});
	$(function()
	{		
	    $('#bio').on('click', loadRedactor);
	});
 
	function loadRedactor()
	{
	     $('#bio').redactor({
	        iframe: true,
	        startCallback: function()
	        {
	            var marker = this.selection.getMarker();
	            this.insert.node(marker);
	        },
	        initCallback: function()
	        {
	            this.selection.restore();
	            $('#bio').off('click', loadRedactor);
 
	            $('#btn-save').show();
	        },
	        destroyCallback: function()
	        {
	            console.log('destroy');
	            $('#bio').on('click', loadRedactor);
	        }
	     });
	}
 
	function saveRedactor()
	{
	    // save content if you need
	    var html = $('#bio').redactor('code.get');
			
 
	    // destroy editor
	    $('#bio').redactor('core.destroy');
	    $('#btn-save').hide();
	}
	
	
});



