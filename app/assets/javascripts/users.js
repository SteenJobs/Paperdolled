// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

/*
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
*/

$(document).ready(function () {
    //turn to inline mode
    $.fn.editable.defaults.mode = 'inline';
    $.fn.editable.defaults.ajaxOptions = {type: "PUT"};
    $("#bio, #age, #styleLikes, #styleDislikes, #styleIcon").editable({
        send: 'always',
        ajaxOptions: {
            type: 'put',
            dataType: 'html'
        },
        success: function(response, newValue) {
            if(response.status == 'error') return response.msg; //msg will be shown in editable form
        },
        error: function(response, newValue) {
            console.log(response)
        }
    });

    /*
    // Masonry init
        // init Isotope
    var $grid = $('.grid').masonry({
        itemSelector: '.grid-item',
      //percentPosition: true,
        //layoutMode: 'packery',
        
        //packery: {
        //  gutter: 30
        //}
         masonry: {
            columnWidth: 375, //".grid-sizer",
            gutter: 30,
            isFitWidth: true
         }
    });
    // layout Isotope after each image loads
    $grid.imagesLoaded().progress( function() {
        $grid.isotope('layout');
    });
    $(window).resize(function(){ $('.grid').isotope('layout'); });
    */
	
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


// script-for-nav 
/*
		$( "span.menu" ).click(function() {
		  $( ".head-nav ul" ).slideToggle(300, function() {
			// Animation complete.
		  });
		});
*/
	
// script-for-textarea
	
	$(function () { 
    /* Activating Best In Place */
    // jQuery(".best_in_place").best_in_place();
	  // $('.best_in_place').bind('ajax:success', function(){ this.innerHTML = this.innerHTML.replace(/\n/g, '<br />') });
	  $('#questions').find('select').chosen();
	  $('#sandbox-container').datepicker({
	      format: "M dd, yyyy",
	      autoclose: true,
	      todayHighlight: true
	  });
  });
	
	$(function () {
		var boards = $('.small_outfit_canvas')
		boards.each(function () { 
			var canvas = $(this);
			canvas.children('.small_draggable2').each(function () { 
				var obj = $(this);
				var width = obj.data().width;
				var height = obj.data().height;
				var canvasHeight = canvas.height();
				var canvasWidth = canvas.width();
				var newHeight = height * canvasHeight;
				var newWidth = width * canvasWidth;
				obj.height(newHeight);
				obj.width(newWidth);
				var offsetX = obj.data().left;
				var offsetY = obj.data().top;
				var PosX = (offsetX * canvasWidth) + canvas.offset().left;
				var PosY = (offsetY * canvasHeight) + canvas.offset().top;
				obj.offset({ top: PosY, left: PosX });
	  	});
  	});
	});
});

/*
obj.style.setProperty('left', PosX, 'important');
obj.style.setProperty('top', PosY, 'important');
obj.style.setProperty('height', newHeight, 'important');
obj.style.setProperty('width', newWidth, 'important');
*/





