// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function () {
	
	var handle = $('.ui-resizable-handle')
	var initialClass = "draggable"
	if (handle.parent().hasClass(initialClass)) {
		handle.hide();
	}
	else {
	}
	
	var items = $('.draggable')
	var items2 = $('.draggable2')
	
	items.width(150)
	items.height(150)
	items2.width(150)
	items2.height(150)
	
	var newClass = 'draggable2 ui-draggable ui-draggable-handle ui-resizable ui-draggable-dragging'
  // For each .draggable element
  $('.draggable').each(function() {
    // Set up the variables
    var $this = $(this),
        w = $this.find('img').width(), // Width of the image inside .draggable
        h = $this.find('img').height(); // Height of the image inside .draggable
    $this.width(w).height(h); // Set width and height of .draggable to match image
  });
	
  // For each .draggable2 element
  $('.draggable2').each(function() {
    // Set up the variables
    var $this = $(this),
        w = $this.find('img').width(), // Width of the image inside .draggable2
        h = $this.find('img').height(); // Height of the image inside .draggable2
    $this.width(w).height(h); // Set width and height of .draggable2 to match image
  });
	
	$( "#outfit_canvas" ).droppable({
	  accept: ".draggable, .draggable2",
		tolerance: "fit",
		hoverClass: "drop-hover",
	  drop: addDrag
	 });
					 
					 
	$( ".draggable" ).draggable({
	  revert: "invalid",
		helper: "clone"
		//stop: help
	});
	
	function addDrag( event, ui ) {
		var canvas = $('#outfit_canvas')
		var dropElem = ui.draggable.get(0)
		var clone = $(dropElem).clone()
		console.log($(clone).attr('class'))
		if ($(clone).attr('class') != newClass) {
			clone.attr('class', 'draggable2');
			// position of the draggable minus position of the droppable
      // relative to the document
      var $newPosX = ui.offset.left - $(this).offset().left;
      var $newPosY = ui.offset.top - $(this).offset().top;
			
      clone.css('left',$newPosX);    
      clone.css('top',$newPosY);

			clone.appendTo("#outfit_canvas");
			$(clone).draggable({
	  		revert: "invalid"
			});
			$(clone).resizable({
     	 // minWidth: image.width(),
     	 // minHeight: image.height(),
  			aspectRatio: true,
				containment: "parent",
      	handles: {
          	'nw': '#nwgrip',
          	'ne': '#negrip',
          	'sw': '#swgrip',
          	'se': '#segrip',
          	'n': '#ngrip',
          	'e': '#egrip',
          	's': '#sgrip',
          	'w': '#wgrip'
      	}
	  	});
		}
		else {	
		}
	}
});